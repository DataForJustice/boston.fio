COPY (
	SELECT
		*
	FROM (
		SELECT distinct 
			split_part("ZIP", '-', 1) as zip, 
			count (*) as total, 
			count (*) filter (WHERE people."RACE" = 'Black') as black_total, 
			count (*) filter (WHERE people."RACE" = 'White') as white_total, 
			count (*) filter (WHERE people."Ethnicity" = 'Hispanic Origin') as hispanic_total, 
			count (*) filter (WHERE stop."SearchPerson" = 'Y') as search_total, 
			count (*) filter (WHERE stop."SummonsIssued" = 'Y') as summons_total,
			count (*) filter (WHERE stop."Frisked" = 'Y') as frisked_total,
			count (*) filter (WHERE stop."SearchPerson" = 'Y' AND people."RACE" = 'Black') as search_black, 
			count (*) filter (WHERE stop."SearchPerson" = 'Y' AND people."RACE" = 'White') as search_white,
			count (*) filter (WHERE stop."SearchPerson" = 'Y' AND people."Ethnicity" = 'Hispanic Origin') as search_hispanic,
			count (*) filter (WHERE stop."SummonsIssued" = 'Y' AND people."RACE" = 'Black') as summons_black,
			count (*) filter (WHERE stop."SummonsIssued" = 'Y' AND people."RACE" = 'White') as summons_white,
			count (*) filter (WHERE stop."SummonsIssued" = 'Y' AND people."Ethnicity" = 'Hispanic Origin') as summons_hispanic,
			count (*) filter (WHERE stop."Frisked" = 'Y' AND people."RACE" = 'Black') as frisked_black,
			count (*) filter (WHERE stop."Frisked" = 'Y' AND people."RACE" = 'White') as frisked_white,
			count (*) filter (WHERE stop."Frisked" = 'Y' AND people."Ethnicity" = 'Hispanic Origin') as frisked_hispanic 
		FROM 
			"FieldContacts_For_Public_2015-Apr_30_2016" as stop LEFT JOIN 
				"FieldContacts_Name_For_Public_2015-Apr_30_2016" people 
					ON stop."FC_NUM" = people."FC_NUM" 
		GROUP BY 
			zip 
		ORDER BY 
			total DESC
	) a
	WHERE
		total > 1
) TO '/tmp/fios.csv' CSV HEADER;
