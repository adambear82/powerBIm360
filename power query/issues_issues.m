// issues issues

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & InsightData & "issues_issues.csv"),
        [Delimiter=",", Columns=29, Encoding=1252, QuoteStyle=QuoteStyle.Csv]
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        Source, [PromoteAllScalars=true]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change type to text
        #"Promoted Headers",{
            {"issue_id", type text}, {"bim360_account_id", type text}, {"bim360_project_id", type text}, {"display_id", Int64.Type}, {"title", type text}, {"description", type text}, 
            {"type_id", type text}, {"subtype_id", type text}, {"status", type text}, {"assignee_id", type text}, {"assignee_type", type text}, {"due_date", type text}, 
            {"location_id", type text}, {"location_details", type text}, {"linked_document_urn", type text}, {"owner_id", type text}, {"root_cause_id", type text}, {"root_cause_category_id", type text}, 
            {"response", type text}, {"response_by", type text}, {"response_at", type text}, {"opened_by", type text}, {"opened_at", type text}, {"closed_by", type text}, {"closed_at", type text}, 
            {"created_by", type text}, {"created_at", type text}, {"updated_by", type text}, {"updated_at", type text}}
        ),

    #"Removed Other Columns" = Table.SelectColumns( // keep only required cols
        #"Changed Type",{"issue_id", "bim360_project_id", "display_id", "title", "description", "status", "response"}
        )

in
    #"Removed Other Columns" // output
