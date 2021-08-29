import json

english_russian = open("tools/spells/english_russian.json", encoding="utf8")
english_russian_json = json.load(english_russian)

english = open("tools/spells/english.json", encoding="utf8")
english_json = json.load(english)

result_json = []

for item in english_json:
    for russian_item in english_russian_json["allSpells"]:
        if item["name"] == russian_item["en"]["name"]:
            result_item = item.copy()
            result_item["name"] = russian_item["ru"]["name"]
            result_json.append(result_item)

result_file = open("tools/spells/result.json", 'w', encoding='utf8')

json.dump(result_json, result_file, ensure_ascii=False)

english_russian.close()
english.close()
