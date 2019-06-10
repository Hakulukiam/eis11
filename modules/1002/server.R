ui_elements <- R6Class("ui_elements", public = list(
  resources_list = NULL,
  agent_ext_list = NULL,
  agent_int_list = NULL,
  initialize = function(){
    con <- DBI::dbConnect(dbDriver("SQLite"),"db_projektarbeit.sqlite")
    self$resources_list <- DBI::dbGetQuery(con, "SELECT id, description FROM Material_Master")
    self$agent_ext_list <- DBI::dbGetQuery(con, "SELECT id, description FROM Economic_Agent_Master WHERE isExternalAgent = 1")
    self$agent_int_list <- DBI::dbGetQuery(con, "SELECT id, description FROM Economic_Agent_Master WHERE isExternalAgent = 0")
    DBI::dbDisconnect(con)
  },
  getResouces = function() setNames(as.character(self$resources_list$id), self$resources_list$description),
  getExtAgents = function() setNames(as.character(self$agent_ext_list$id), self$agent_ext_list$description),
  getIntAgents = function() setNames(as.character(self$agent_int_list$id), self$agent_int_list$description)
))

pzu_journal <- R6Class("pzu_journal", public = list(
  row = c("Timestamp" = NULL, "AccTransactID"= NULL, "VoucherType"= NULL, "AccountNo"= NULL, "AmountDrCr"= NULL, "Remarks"= NULL),
  con = NULL,
  initialize = function(){
    self$con <- DBI::dbConnect(dbDriver("SQLite"),"db_projektarbeit.sqlite")
    self$setAccountNo(1)
    self$setVoucherType("PZU")
  },
  finalize = function() {
    DBI::dbDisconnect(self$con)
  },
  getCurrentRow = function() self$row,
  setTimeStamp = function(TimeStamp) self$row['Timestamp'] <<- TimeStamp,
  setAccTransactID = function(AccTransactID) self$row['AccTransactID'] <<- AccTransactID,
  setVoucherType = function(VoucherType) self$row['VoucherType'] <<- VoucherType,
  setAccountNo = function(AccountNo) self$row['AccountNo'] <<- AccountNo,
  setAmountDrCr = function(AmountDrCr) self$row['AmountDrCr'] <<- AmountDrCr,
  setRemarks = function(Remarks) self$row['Remarks'] <<- Remarks,
  commit = function() {
    self$setTimeStamp(format(Sys.time(), "%Y-%m-%d %X"))
    rs <- dbSendStatement(
      self$con,
      "INSERT INTO journal (Timestamp, AccTransactID, VoucherType, AccountNo, AmountDrCr, Remarks) VALUES (?, ?, ?, ?, ?, ?)",
      param = list(self$row['Timestamp'], self$row['AccTransactID'], self$row['VoucherType'], self$row['AccountNo'], self$row['AmountDrCr'], self$row['Remarks'])
    )
    dbClearResult(rs)
  }
))

material <- R6Class("material", public = list(
  con = NULL,
  initialize = function(){
    self$con <- DBI::dbConnect(dbDriver("SQLite"),"db_projektarbeit.sqlite")
  },
  finalize = function() {
    DBI::dbDisconnect(self$con)
  },
  getMaterialInfo = function(material_id) DBI::dbGetQuery(self$con, "SELECT id, pricePerUnit, accountNo FROM Material_Master WHERE id = ?", c(material_id)),
  getNextAccountTransaction = function() DBI::dbGetQuery(self$con, "SELECT max(AccTransactID)+1 as id FROM journal")
))

observeEvent(
  input$actionButton_1002,
  {
    materialInstance <- material$new()
    materialInfo <- materialInstance$getMaterialInfo(input$resource_1002)
    AccTransactID <- materialInstance$getNextAccountTransaction()
    
    #preis und vst berechnen
    preis.brutto <- materialInfo$pricePerUnit * input$quantity_1002
    preis.netto <- preis.brutto / 1.2
    preis.vst <- preis.brutto - preis.netto
    
    #Geld Abgang
    journal <- pzu_journal$new()
    journal$setAccTransactID(AccTransactID$id)
    journal$setAccountNo(3390)
    journal$setAmountDrCr(-preis.brutto)
    journal$setRemarks("Zahlung incl. Vorsteuer")
    journal$commit()
    
    #VST
    journal <- pzu_journal$new()
    journal$setAccTransactID(AccTransactID$id)
    journal$setAccountNo(2500)
    journal$setAmountDrCr(preis.vst)
    journal$setRemarks("Vst. Forderung")
    journal$commit()
    
    #Ware zugang
    journal <- pzu_journal$new()
    journal$setAccTransactID(AccTransactID$id)
    journal$setAccountNo(materialInfo$accountNo)
    journal$setAmountDrCr(preis.netto)
    journal$setRemarks("Waren Zugang")
    journal$commit()

    showModal(modalDialog(
      title = "Buchnung erfolgreich",
      "Der Wareneingang wurde vom System erfasst.",
      easyClose = TRUE,
      footer = NULL
    ))
  }
)

selection_lists <- ui_elements$new()
updateSelectInput(session, "resource_1002",
    choices = selection_lists$getResouces()
)
updateSelectInput(session, "agent_ext_1002",
    choices = selection_lists$getExtAgents()
)
updateSelectInput(session, "agent_int_1002",
    choices = selection_lists$getIntAgents()
)

