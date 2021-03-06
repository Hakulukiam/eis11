library(shiny)
library(shinydashboard)
library(DT)
library(DBI)
library(RSQLite)
library(xts)

library(data.table)
library(data.tree)
library(openxlsx)
library(rpivotTable)

library(dygraphs)
library(V8)
library(diagram)
library(DiagrammeR)
library(DT)
library(forecast)
library(R6)


ui <- dashboardPage(
  dashboardHeader(title = "Shiny-ERP", titleWidth = 350),
  dashboardSidebar(
    width = 350,
    
    sidebarMenu(
      menuItem("Home", tabName = "tab_home", icon = icon("home")),
      menuItem("Showcase", tabName = "tab_1000", icon = icon("line-chart")),
      menuItem("Showcase 2", tabName = 'tab_forecasting', icon = icon('balance-scale')
    ),
      
      # Finance
      menuItem(
        "Finance",
        tabName = "tab_finane",
        icon = icon("line-chart"),
        menuItem(
          "REA Transactions",
          tabName = 'tab_reatransactions',
          icon = icon('exchange')
        ),
        menuItem(
          "ALE Accounting",
          tabName = 'tab_aleacclunting',
          icon = icon('balance-scale')
        )
        
      ),
      # Operations
      menuItem(
        "Operations",
        tabName = "tab_operations",
        icon = icon("industry"),
        menuItem(
          "Procurement",
          tabName = 'tab_procurement',
          icon = icon('shopping-basket'),
          menuSubItem('Incoming Goods', tabName = 'tab_procurement_incoming_goods'),
          menuSubItem('Receipt Incoming Goods', tabName = 'tab_procurement_receipt_incoming_goods')
        ),
        menuItem(
          "Manufacturing",
          tabName = 'tab_manufacturing',
          icon = icon('wrench')
        ),
        menuItem("Sales",
                 tabName = 'tab_sales',
                 icon = icon('truck'))
      ),
      
      # Data Warehouse
      menuItem(
        "Data warehouse",
        tabName = "tab_datawarehouse",
        icon = icon("database"),
        menuSubItem(
          'Table Browser (SQLITE)',
          tabName = 'tab_tablebrowser',
          icon = icon('table')
        )
      ),
      # Settings
      menuItem(
        "Administration",
        tabName = "tab_administration",
        icon = icon("gears"),
        menuSubItem('Resources',
                    tabName = 'tab_resources',
                    icon = icon("gears")),
        menuSubItem('Agents',
                    tabName = 'tab_agents',
                    icon = icon("users")),
        menuSubItem('Bill of Materials',
                    tabName = 'tab_billofmaterials',
                    icon = icon("sitemap")),
        menuSubItem('Routings',
                    tabName = 'tab_routings',
                    icon = icon("users"))
      )
      
    )
  ),
  
  
  dashboardBody(tabItems(
    source('modules/_home/ui.R', local = environment())$value,
    source('modules/1000//ui.R', local = environment())$value,
    source('modules/1001//ui.R', local = environment())$value,
    source('modules/1002//ui.R', local = environment())$value
  ))
  
)

shinyApp(ui = ui, server = function(input, output, session) {
  source('modules/1000//server.R', local = environment())$value
  source('modules/1001//server.R', local = environment())$value
  source('modules/1002//server.R', local = environment())$value
  
})