library(XML)

parseEditFile <- function(filename) {
    doc <- xmlTreeParse(filename)
    root <- xmlRoot(doc)
    instances <- root[['ALL_INSTANCES']]
    
    startTimes <- xmlSApply(instances, function(e) xmlValue(e['start'][[1]]))
    startTimes <- as.numeric(startTimes)

    endTimes <- xmlSApply(instances, function(e) xmlValue(e['end'][[1]]))
    endTimes <- as.numeric(endTimes)
    
    codes <- xmlSApply(instances, function(e) xmlValue(e['code'][[1]]))
    codes <- as.factor(codes)

    data.frame(startTimes, endTimes, codes) 
}

