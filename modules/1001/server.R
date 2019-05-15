global_df <- NULL
observeEvent(
  input$actionButton_1001,
  {
    con <- DBI::dbConnect(dbDriver("SQLite"),"EIS.sqlite")
    df_sql <- DBI::dbReadTable(con, "Sales")
    DBI::dbDisconnect(con)

    df_sql$value = df_sql$value/100
    df_sql$value = paste(df_sql$value, "\u20ac", sep = " ")
    
    output$dataTableOutput_1001 <- renderDataTable({
      df_sql
    },options = list(scrollX = TRUE))
    
    output$rpivotTableOutput_1001 <- renderRpivotTable(
      rpivotTable(data = df_sql, height = "100px")
    )
    global_df <<- df_sql

})
observeEvent(
  input$actionButtont1_1001,
  {
    con <- DBI::dbConnect(dbDriver("SQLite"),"EIS.sqlite")
    df_sql <- DBI::dbReadTable(con, "Sales")
    DBI::dbDisconnect(con)
    beer <- ts(df_sql$value/100,start=1978,freq=12)
    model <- HoltWinters(beer, gamma=FALSE)

    print(model)
    
    output$plotOutput_1001 <- renderPlot({
      plot(forecast(model, h=40, level=input$Confidence), xlim=c(2017,2019))
    })
  }
)

observeEvent(
  input$actionButtont2_1001,
  {
    beer <- read.csv("beer.csv", header=T, dec=",", sep=";")
    beer <- ts(beer[,1],start=1978,freq=12)
    model <- HoltWinters(beer, gamma=FALSE)
    
    output$plotOutput_1001 <- renderPlot({
      plot(forecast(model, h=40, level=input$Confidence), xlim=c(2015,2019))
    })
  }
)

observeEvent(
  input$actionButtont3_1001,
  {
    beer <- read.csv("beer.csv", header=T, dec=",", sep=";")
    beer <- ts(beer[,1],start=1978,freq=12)
    model <- HoltWinters(beer, gamma=FALSE)
    
    output$plotOutput_1001 <- renderPlot({
      plot(forecast(model, h=40, level=input$Confidence), xlim=c(2003,2019))
    })
  }
)

