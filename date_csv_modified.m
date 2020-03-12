// date csv modified

let
    Source = Folder.Files(Root), // refer to root parameter for folder location

    #"Filtered Rows" = Table.SelectRows(  // select single csv to refer to
        Source, each [Name] = "admin_users.csv"
        ),

    #"Duplicated Column" = Table.DuplicateColumn(  // copy col
        #"Filtered Rows", "Date created", "Date created - Copy"
        ),

    #"Renamed Columns" = Table.RenameColumns(  // rename col
        #"Duplicated Column",{{"Date created - Copy", "created date"}}
        ),

    #"Extracted Date" = Table.TransformColumns(  // transform date
        #"Renamed Columns",{{"created date", DateTime.Date, type date}}
        )
        
in
    #"Extracted Date" // output
