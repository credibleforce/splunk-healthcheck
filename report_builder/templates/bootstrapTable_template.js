    var <<REPORT>>_cols = [];
    for(var n in <<REPORT>>[0].result){
        <<REPORT>>_cols.push({
            field: "result."+n,
            title: n,
            squash: n
        });
    }
    
    $('#<<REPORT>>_table').bootstrapTable({
        data: <<REPORT>>,
        columns: <<REPORT>>_cols
    })