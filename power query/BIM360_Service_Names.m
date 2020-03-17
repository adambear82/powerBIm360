// BIM 360 Service Names - defined manualy - not downloaded

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & WessexWaterData & "BIM360_Service_Names.csv"),
        [Delimiter=",", Columns=2, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change type to text
        Source,{
            {"Column1", type text}, {"Column2", type text}
            }
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        #"Changed Type", [PromoteAllScalars=true]
        )

in
    #"Promoted Headers" // output
