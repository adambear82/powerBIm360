// admin projects

let
    Source = Csv.Document( // load csv with delimiter
        File.Contents(Root & InsightData & "admin_projects.csv"),
        [Delimiter=",", Columns=22, Encoding=1252, QuoteStyle=QuoteStyle.None]
        ),

    #"Promoted Headers" = Table.PromoteHeaders( // promote headers
        Source, [PromoteAllScalars=true]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // change types
        #"Promoted Headers",{
        {"id", type text}, {"bim360_account_id", type text}, {"name", type text}, {"start_date", type text}, {"end_date", type text}, {"type", type text}, 
        {"value", Int64.Type}, {"currency", type text}, {"status", type text}, {"job_number", type text}, {"address_line1", type text}, {"address_line2", type text}, 
        {"city", type text}, {"state_or_province", type text}, {"postal_code", type text}, {"country", type text}, {"timezone", type text}, {"construction_type", type text}, 
        {"contract_type", type text}, {"business_unit_id", type text}, {"last_sign_in", type text}, {"created_at", type text}
        }
        ),

    #"Inserted Text After Delimiter" = Table.AddColumn( // remove day of week after first space dilimiter
        #"Changed Type", "Text After Delimiter", each Text.AfterDelimiter([last_sign_in], " "), type text
        ),
        
    #"Inserted Text Before Delimiter" = Table.AddColumn( // remove time of day after skipping first 2 space delimiters
        #"Inserted Text After Delimiter", "Text Before Delimiter", each Text.BeforeDelimiter([Text After Delimiter], " ", 2), type text
        ),
        
    #"Inserted Parsed Date" = Table.AddColumn( // parse text as date
        #"Inserted Text Before Delimiter", "Parse", each Date.From(DateTimeZone.From([Text Before Delimiter])), type date
        ),

    #"Inserted Age" = Table.AddColumn( // calculate age of date from now
        #"Inserted Parsed Date", "Age", each Date.From(DateTime.LocalNow()) - [Parse], type duration
        ),

    #"Inserted Days" = Table.AddColumn( // show days only not fractions of days
        #"Inserted Age", "Days", each Duration.Days([Age]), Int64.Type
        ),

    #"Removed Other Columns" = Table.SelectColumns( // keep only the required cols
        #"Inserted Days",{"id", "name", "status", "business_unit_id", "Days"}
        )
in
    #"Removed Other Columns" // output
