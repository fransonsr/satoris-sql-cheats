-- select batch by batchId
select uuid_from_bin(uuid), b.*
from batches b
where b.batch_id = :batchId;

-- select batch by uuid
select uuid_from_bin(uuid), b.*
from batches b
where b.uuid = uuid_to_bin(:uuid);

-- select imageset by name
select uuid_from_bin(im.uuid) as uuid, im.* from imagesets im
where im.name = :name;

-- select images by imageset name
select uuid_from_bin(i.uuid) as uuid, i.* from images i
join imagesets ON imagesets.imageset_id = i.imageset_id
where imagesets.name = :name
order by i.imageset_index;
