shared_examples 'emails' do |emails, validator, adj|
  emails.each do |email|
    it "`#{email}` is #{adj}" do
      subject.email = email
      expect(subject).to(send(validator))
    end
  end
end
