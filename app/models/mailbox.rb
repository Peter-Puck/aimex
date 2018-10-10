class Mailbox < Mailboxer::Message
		  scope :mycount, ->  { where(unread: true) }
end