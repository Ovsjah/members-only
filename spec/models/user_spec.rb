require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe '#email' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it "accepts valid emails" do
      valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_emails.each do |v_e|
        subject.email = v_e
        expect(subject).to be_valid
      end
    end

    it "rejects invalid emails" do
      invalid_emails = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_emails.each do |i_e|
        subject.email =  i_e
        expect(subject).to be_invalid
      end
    end

    it "is saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      subject.email = mixed_case_email
      subject.save
      expect(subject.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  describe '#password' do
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6) }

    it "should be present (nonblank)" do
      subject.password = subject.password_confirmation = ' ' * 6
      expect(subject).to be_invalid
    end
  end
end
