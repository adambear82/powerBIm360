// BIM 360 Memebers - not included in insight data extractor - downloaded from account admin members

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(
            Root & AccountAdmin & "BIM360_Members.csv"),
            [Delimiter=",", Columns=10, Encoding=65001, QuoteStyle=QuoteStyle.None]
            ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        Source, [PromoteAllScalars=true]
        ),

    #"Removed Other Columns" = Table.SelectColumns( // keep only required cols
        #"Promoted Headers",{"Email", "Status"}
        )
in
    #"Removed Other Columns" // output
