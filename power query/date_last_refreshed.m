// Date Last Refreshed

let
    Source = #table( // create a table with a single single row as now
        type table[Date Last Refreshed=datetime],
        {{DateTime.LocalNow()}}
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change to text for transformation
        Source,{{"Date Last Refreshed", type text}}
        ),

    #"Replaced Value" = Table.ReplaceValue( // replace space with padded @ for formatting
        #"Changed Type"," "," @ ",Replacer.ReplaceText,{"Date Last Refreshed"}
        )
in
    #"Replaced Value"
