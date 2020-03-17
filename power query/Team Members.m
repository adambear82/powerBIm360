// team members - defined manualy - not downloaded

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & WessexWaterData & "Team Members.csv"),
        [Delimiter=",", Columns=2, Encoding=65001, QuoteStyle=QuoteStyle.None]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change type to text
        Source,{
            {"Column1", type text}, {"Column2", type text}
            }
        ),

    #"Renamed Columns" = Table.RenameColumns( // headers not defined in csv rename cols manually
        #"Changed Type",{
            {"Column1", "email"}, {"Column2", "teamMember"}
            }
        )

in
    #"Renamed Columns" // output
