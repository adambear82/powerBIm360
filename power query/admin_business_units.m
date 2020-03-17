// admin business units

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & InsightData & "admin_business_units.csv"),
        [Delimiter=",", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change type
        Source,{
            {"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}
            }
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        #"Changed Type", [PromoteAllScalars=true]
        )
in
    #"Promoted Headers" // output
