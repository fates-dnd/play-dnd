import json

english_russian = open("english_russian.json", encoding="utf8")
english_russian_json = json.load(english_russian)

english = open("english.json", encoding="utf8")
english_json = json.load(english)

result_json = []

for item in english_json:
    for russian_item in english_russian_json["allSpells"]:
        if item["name"] == russian_item["en"]["name"]:
            result_item = item.copy()
            result_item["name"] = russian_item["ru"]["name"]
            result_item["casting_time"] = russian_item["ru"]["castingTime"]
            result_item["desc"] = russian_item["ru"]["text"].split("<br>")
            result_item["range"] = russian_item["ru"]["range"]
            result_item["duration"] = russian_item["ru"]["duration"]
            result_json.append(result_item)

result_file = open("result.json", 'w', encoding='utf8')

json.dump(result_json, result_file, ensure_ascii=False)

english_russian.close()
english.close()
