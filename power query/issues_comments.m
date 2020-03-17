// issues comments

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & InsightData & "issues_comments.csv"),
        [Delimiter=",", Columns=7, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change types to text
        Source,{
            {"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, 
            {"Column5", type text}, {"Column6", type text}, {"Column7", type text}
            }
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        #"Changed Type", [PromoteAllScalars=true]
        ),

    #"Removed Other Columns" = Table.SelectColumns( // keep only the required cols
        #"Promoted Headers",{"issue_id", "comment_body"}
        )

in
    #"Removed Other Columns" // output
