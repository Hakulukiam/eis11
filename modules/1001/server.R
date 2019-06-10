global_df <- NULL
observeEvent(
  input$actionButton_1001,
  {
    con <- DBI::dbConnect(dbDriver("SQLite"),"EIS.sqlite")
    df_sql <- DBI::dbReadTable(con, "Sales")
    DBI::dbDisconnect(con)

    df_sql$value = df_sql$value/100 #Umrechnung auf EUR/kg
    df_sql$value = paste(df_sql$value, "\u20ac/kg", sep = " ")
    
    output$dataTableOutput_1001 <- renderDataTable({
      df_sql
    },options = list(scrollX = TRUE))
    
    output$rpivotTableOutput_1001 <- renderRpivotTable(
      rpivotTable(data = df_sql, height = "100px")
    )
    global_df <<- df_sql

})

