import json

english_russian = open("english_russian.json", encoding="utf8")
english_russian_json = json.load(english_russian)

english = open("english.json", encoding="utf8")
english_json = json.load(english)

result_json = []

for item in english_json:
    result_item = item.copy()
    for russian_item in english_russian_json["itemsList"]:
        if item["name"] == russian_item["en"]["name"]:
            result_item["name"] = russian_item["ru"]["name"]
    result_json.append(result_item)

result_file = open("result.json", 'w', encoding='utf8')

json.dump(result_json, result_file, ensure_ascii=False)

english_russian.close()
english.close()
