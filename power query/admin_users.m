// admin users

let // data to be transformed before being outputted to 'in'

    Source = Csv.Document( // load a csv file
        File.Contents(Root & InsightData & "admin_users.csv"), // use parameters in file structure
        [Delimiter=",", Columns=22, Encoding=1252, QuoteStyle=QuoteStyle.None] // deliminate at each ','
        ),
        
    #"Promoted Headers" = Table.PromoteHeaders( // promote the first row of data as headers
        Source, [PromoteAllScalars=true]
        ),

    #"Changed Type" = Table.TransformColumnTypes( // identify data types as text, integers, dates , etc
        #"Promoted Headers",{
            {"id", type text}, {"autodesk_id", type text}, {"bim360_account_id", type text},
            {"email", type text}, {"name", type text}, {"first_name", type text},
            {"last_name", type text}, {"address_line1", type text}, {"address_line2", type text},
            {"city", type text}, {"state_or_province", type text}, {"postal_code", type text},
            {"country", type text}, {"last_sign_in", type text}, {"phone", type text},
            {"job_title", type text}, {"access_level_account_admin", Int64.Type},
            {"access_level_project_admin", Int64.Type}, {"access_level_project_member", Int64.Type},
            {"access_level_executive", Int64.Type}, {"default_role_id", type text},
            {"default_company_id", type text}
            }
        ),

    #"Removed Other Columns" = Table.SelectColumns( // remove unrequired columns
        #"Changed Type",{"id", "email", "name", "first_name", "last_name", "last_sign_in"}
        ),

    #"Duplicated Column" = Table.DuplicateColumn( // create a copy of 'last_sign_in' to transform
        #"Removed Other Columns", "last_sign_in", "last_sign_in - Copy"
        ), // by not transforming the oringinal data it is maintained for future examination if required

    #"Extracted Text Before Delimiter" = Table.TransformColumns( // remove text after delim for date only
        #"Duplicated Column", {
            {"last_sign_in - Copy", each Text.BeforeDelimiter(_, " "), type text}
            }
        ),

    #"Parsed Date" = Table.TransformColumns( // change type from text to date
        #"Extracted Text Before Delimiter",{
            {"last_sign_in - Copy", each Date.From(DateTimeZone.From(_)), type date}
            }
        ),

    #"Calculated Age" = Table.TransformColumns( // transform date into an age from now
        #"Parsed Date",{ 
            {"last_sign_in - Copy",
            each Date.From(DateTime.LocalNow()) - _,
            type duration}
            }
        ),

    #"Extracted Days" = Table.TransformColumns( // transform age to show just the days
        #"Calculated Age",{
            {"last_sign_in - Copy", Duration.Days, Int64.Type}
            }
        ),

    #"Renamed Columns" = Table.RenameColumns( // rename column to 'Days'
        #"Extracted Days",{
            {"last_sign_in - Copy", "Days"}
            }
        ),

    #"Removed Columns" = Table.RemoveColumns( // remove column 'last_sign_in'
        #"Renamed Columns",{"last_sign_in"} // duplicating then removing maintains data
        ) // without duplicating there would be less opportunity to use original data

in // transformed data is outputted
    #"Removed Columns" // output the final step 'Removed Columns'
