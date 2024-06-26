const getParentsByTripId = `
    SELECT
        parent.id AS parent_id,
        parent.phone,
        parent.email
    FROM
        parent
    JOIN
        parent_student_relation ON parent.id = parent_student_relation.parent_id
    JOIN
        student_trip_list ON parent_student_relation.student_id = student_trip_list.student_id
    WHERE
        student_trip_list.trip_id = ?;
`;

module.exports={
    getParentsByTripId
}