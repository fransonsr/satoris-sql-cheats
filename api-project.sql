-- select batch by batchId
select uuid_from_bin(uuid), b.*
from batches b
where b.batch_id = :batchId;

-- select batch by uuid
select uuid_from_bin(uuid), b.*
from batches b
where b.uuid = uuid_to_bin(:uuid);

