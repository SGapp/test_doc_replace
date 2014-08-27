class UserReportController < ApplicationController

  def index
    user_report
  end

  def user_report
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.docx do
        # Initialize DocxReplace with your template
        doc = DocxReplace::Doc.new("#{Rails.root}/lib/docx_templates/user.docx", "#{Rails.root}/tmp")

        puts 'TEST'
        puts doc.matches("USER_FIRST_NAME")
        puts doc.unique_matches("USER_FIRST_NAME")
        puts 'TEST'

        # Replace some variables. $var$ convention is used here, but not required.
        doc.replace("USER_FIRST_NAME", @user.first_name, true)
        doc.replace("USER_LAST_NAME", @user.last_name, true)
        # doc.replace("USER_BIO", @user.bio, true)
        # doc.replace("USER_BO", @user.bio)

        # Write the document back to a temporary file
        tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
        doc.commit(tmp_file.path)

        # Respond to the request by sending the temp file
        send_file tmp_file.path, filename: "user_#{@user.id}_report.docx", disposition: 'attachment'
      end
    end
  end

end
