// This file is part of MLDB. Copyright 2017 Element AI Inc. All rights reserved.

/**
 * MLDB-2169-skip-extra-columns.js
 * Copyright (c) 2017 Element AI Inc. All rights reserved.
 **/

var mldb = require('mldb')
var unittest = require('mldb/unittest')

var mldb2169Config = {
        type: "import.text",
        params: {
            dataFileUrl : "file://mldb/testing/fixtures/MLDB-2169-skip-extra-columns.csv",
            outputDataset: {
                id: 'mldb2169',
            },
            runOnCreation: true,
            encoding: 'latin1',
            ignoreBadLines: false,
            ignoreExtraColumns: true
        }
    }

var res = mldb.put("/v1/procedures/csv_proc", mldb2169Config);

mldb.log(res);

unittest.assertEqual(res.responseCode, 201);

expected = [
   [ "_rowName", "a", "b" ],
   [ "2", 1, 2 ],
   [ "3", 3, 4 ],
   [ "4", 5, 6 ],
   [ "5", 5, 6 ],
   [ "6", 5, 6 ],
   [ "7", 5, 6 ],
   [ "8", 9, 10 ]
];

var res = mldb.get("/v1/query", { q: 'select * from mldb2169 order by rowName()', format: 'table' });
unittest.assertEqual(res.json, expected, "quoteChar test");

"success"
