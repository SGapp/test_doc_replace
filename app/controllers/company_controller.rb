class CompanyController < ApplicationController

  def index
    company_report
  end

  def company_report
    @company = Company.find(params[:company_id])

    respond_to do |format|
      format.docx do
        # Initialize DocxReplace with your template
        doc = DocxReplace::Doc.new("#{Rails.root}/lib/docx_templates/company.docx", "#{Rails.root}/tmp")

        puts 'TEST'
        puts doc.matches("CAPITAL_SOCIAL")
        puts doc.unique_matches("CAPITAL_SOCIAL")
        puts 'TEST'

        # Replace some variables. $var$ convention is used here, but not required.
        doc.replace("CAPITAL_SOCIAL", @company.capital_social, true)
        doc.replace("DENOMINATION_SOCIALE", @company.denomination_social.gsub('&', '&amp;'), true)
        doc.replace("SIEGE_SOCIAL", @company.siege_social, true)
        # doc.replace("company_BO", @company.bio)

        # Write the document back to a temporary file
        tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
        doc.commit(tmp_file.path)

        # Respond to the request by sending the temp file
        send_file tmp_file.path, filename: "company_#{@company.id}_report.docx", disposition: 'attachment'
      end
    end
  end
end
