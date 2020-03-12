// BIM 360 Service Levels - defined manualy - not downloaded

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & WessexWaterData & "BIM360_Service_Levels.csv"),
        [Delimiter=",", Columns=3, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        Source, [PromoteAllScalars=true]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change type to integers
        #"Promoted Headers",{
            {"DocsAvailable", Int64.Type}, {" BuildAvailable", Int64.Type}, {" CostAvailable", Int64.Type}
            }
        )
in
    #"Changed Type" // output
