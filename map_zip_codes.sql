SELECT 
	row_to_json (collection)
FROM
	(
	SELECT
		'FeatureCollection' as type,
		array_to_json (array_agg (feature)) as features
	FROM
		(
		SELECT
			'Feature' as type,
			ST_AsGeoJson (self.wkb_geometry)::json as geometry,
			(WITH DATA (nombre) AS (VALUES (self.nomvial)) SELECT row_to_json (data) FROM data) as properties
		FROM
			(
			SELECT 
				*
			FROM
				zip
			) as self
		) as feature
	) as collection

