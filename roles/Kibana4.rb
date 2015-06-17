name 'Kibana4'
description 'install Kibana4'
run_list(
  "recipe[ElasticSearch::default]",
  "recipe[Kibana4::default]",
  "recipe[td-agent::default]"
)
