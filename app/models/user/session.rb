class User::Session < ApplicationRecord
    belongs_to :user

    enum :session_source, %i(web app)

    after_create :init_session

    protected

        def init_session
            process_uuids = true

            while process_uuids do
                user_uuid = SecureRandom.uuid
                session_uuid = SecureRandom.uuid

                unless User::Session.find_by(
                    :user_uuid => user_uuid,
                    :session_uuid => session_uuid
                )

                    self.user_uuid = user_uuid
                    self.session_uuid = session_uuid
                    self.usage_count += 1
                    self.save

                    process_uuids = false
                end
            end
        end

end