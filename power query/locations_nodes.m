// location nodes

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & InsightData & "locations_nodes.csv"),
        [Delimiter=",", Columns=9, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        Source, [PromoteAllScalars=true]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change type to text
        #"Promoted Headers",{
            {"tree_id", type text}, {"bim360_account_id", type text}, {"bim360_project_id", type text}, {"parent_id", type text}, 
            {"id", type text}, {"name", type text}, {"order", Int64.Type}, {"created_at", type text}, {"updated_at", type text}
            }
        )

in
    #"Changed Type" // output
