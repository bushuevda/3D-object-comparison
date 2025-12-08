def recors_to_json(records):
    return list(map(lambda x: x.model_dump_json(), records))
