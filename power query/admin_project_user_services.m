// admin project user services

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & InsightData & "admin_project_user_services.csv"),
            [Delimiter=",", Columns=4, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        #"Source", [PromoteAllScalars=true]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change types to text
        #"Promoted Headers",{
            {"project_id", type text}, {"bim360_account_id", type text}, {"user_id", type text}, {"service", type text}
        }
        )
in
    #"Changed Type" // output
