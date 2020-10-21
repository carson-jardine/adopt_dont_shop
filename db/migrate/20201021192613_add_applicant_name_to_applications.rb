class AddApplicantNameToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :applicant_name, :string
  end
end
