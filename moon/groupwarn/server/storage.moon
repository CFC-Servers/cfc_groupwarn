import concat from table
import format from string

class Storage
    GetTotals: (groupIDs) =>
        groups = concat groupIDs, ", "

        result = sql.Query format [[
            SELECT
                count
            FROM
                cfc_groupCheck
            WHERE
                group_id IN (%s)
        ]], groups

    AddTotals: (groupIDs) =>
        sql.Begin!

        for id in *groupIDs
            sql.Query format [[
                INSERT OR IGNORE INTO
                    cfc_groupcheck_totals (group_id, count)
                VALUES
                    (%s, 0)
            ]], id

        sql.Query format [[
            UPDATE
                cfc_groupcheck_totals
            SET
                count = count + 1
            WHERE
                group_id IN (%s)
        ]], concat groupIDs, ", "

        sql.Commit!

    CreateTable: =>
        sql.Query [[
            CREATE TABLE IF NOT EXISTS cfc_groupcheck_totals(
                group_id TEXT        PRIMARY KEY,
                count    INTEGER     NOT NULL DEFAULT 0
            )
        ]]

    Setup: =>
        @CreateTable!

GroupCheck.Storage = Storage!
