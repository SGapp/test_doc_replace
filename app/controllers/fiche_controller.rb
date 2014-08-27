class FicheController < ApplicationController

  def index
    fulfill_fiche
  end

  def fulfill_fiche
    @fiche = Fiche.find(1)

    respond_to do |format|
      format.docx do
        # Initialize DocxReplace with your template
        doc = DocxReplace::Doc.new("#{Rails.root}/lib/docx_templates/fiche.docx", "#{Rails.root}/tmp")

        puts 'TEST'
        puts doc.matches("DENOMINATION_SOCIALE")
        puts doc.unique_matches("DENOMINATION_SOCIALE")
        puts 'TEST'

        # Replace some variables. $var$ convention is used here, but not required.
        doc.replace("DENOMINATION_SOCIALE", @fiche.denomination_sociale, true)

        # Write the document back to a temporary file
        tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
        doc.commit(tmp_file.path)

        # Respond to the request by sending the temp file
        send_file tmp_file.path, filename: "fiche_#{@fiche.id}_report.docx", disposition: 'attachment'
      end
    end
  end
end