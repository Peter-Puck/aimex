class MailboxController < ApplicationController
layout false
before_action :authenticate_user!, unless: -> { !signed_in? }

  def inbox
    @inbox = current_user.mailbox.inbox
    @active = :inbox
  end

  def sent
    @sent = mailbox.sentbox
    @active = :sent
  end

  def trash
    @trash = mailbox.trash
    @active = :trash
  end

end
