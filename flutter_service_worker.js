'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"index.html": "96a53a81359a078ca5814abab8e57f12",
"/": "96a53a81359a078ca5814abab8e57f12",
"main.dart.js": "cf8ef9012abcde9e96bb06b4deff2636",
"manifest.json": "35d497c5c8a8fe4d3d570521e0a366c3",
"version.json": "ac91c9dbd8a5d55c33e595c75c66b68b",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"icons/Icon-512.png": "6fe1efc34d898e7e4450dec3e6e20f87",
"icons/Icon-192.png": "d3d5637c7223378cad11252db8e57ee3",
"favicon.ico": "ebe6ebbb93705d86c2450b9dae2c2834",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/NOTICES": "3953862142f3b2917e6eafd1d2afb33a",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/rules/en/skills.json": "bf4718b11d999339cfd9461259c30cde",
"assets/assets/rules/en/equipment.json": "2c3b9081bc17066db1f6a21e1b530886",
"assets/assets/rules/en/races.json": "09d95016889cda73945dd94dd15c51c3",
"assets/assets/rules/en/classes.json": "ba5eb07212bddf466a3f8fb8a7722bad",
"assets/assets/rules/en/spells.json": "0fff1ce5db24033112537b2a72f2f3f8",
"assets/assets/rules/en/features.json": "7e05a5304458ea369faee15b837eebbe",
"assets/assets/rules/en/traits.json": "3dfd2be664778d186a3e3a8fd6cf1ca5",
"assets/assets/drawable/money/platinum.png": "eb416149abc300643c21d3a261f049e5",
"assets/assets/drawable/money/gold.png": "15cc69adec95c9de17ee8850addaad46",
"assets/assets/drawable/money/copper.png": "311904509a066ceae07638cbdd381735",
"assets/assets/drawable/money/electrum.png": "8c0cdbacf0db999281d03485568ef5b8",
"assets/assets/drawable/money/silver.png": "c2342b9f70300ce6626b8d6a2bb70269",
"assets/assets/drawable/icons/cleric.png": "fe2fbf28a9417676c2e438fa3bee3c59",
"assets/assets/drawable/icons/bard.png": "00a0bc3da7218113b7172ad263936492",
"assets/assets/drawable/icons/sorcerer.png": "ad58fa1fd6e75db7d37a445083f20993",
"assets/assets/drawable/icons/monk.png": "cad34920bebe53e6d93f39b6aede26b3",
"assets/assets/drawable/icons/paladin.png": "cf757563093e700bdc46625b533f0f04",
"assets/assets/drawable/icons/warlock.png": "7fb3ad8f83e98d8cd4839a89547f4717",
"assets/assets/drawable/icons/ranger.png": "789ae6179d89714d96b52872b21fa338",
"assets/assets/drawable/icons/barbarian.png": "657df62e2bd3e43320d70fa8268d4f97",
"assets/assets/drawable/icons/fighter.png": "8a9adfc55c8b2dc74fa065bfed7ce413",
"assets/assets/drawable/icons/wizard.png": "4872d3edfe23d639534b1cbc7f4e770c",
"assets/assets/drawable/icons/rogue.png": "31e124fe62f4220203fc168cfb88ab62",
"assets/assets/drawable/icons/druid.png": "eecf504f6cbe9023f1ba1c472cde4fc2",
"assets/assets/drawable/icons/2.0x/cleric.png": "055a03265bb0868e9c28eb9f8bc6d27f",
"assets/assets/drawable/icons/2.0x/bard.png": "6c2d29c3040ef660ec3ba654d9c608f3",
"assets/assets/drawable/icons/2.0x/sorcerer.png": "ae8cbbdbdbee094295ddf3dbf2d16002",
"assets/assets/drawable/icons/2.0x/monk.png": "8c9a2a612af4ce89d2b81ef199631959",
"assets/assets/drawable/icons/2.0x/paladin.png": "00bde005d6951ec8415b2675ad606f35",
"assets/assets/drawable/icons/2.0x/warlock.png": "c9bb27d70f64a7dfee61ff6a687b9d48",
"assets/assets/drawable/icons/2.0x/ranger.png": "7b4a388db7b6e44c053d2e25a368071e",
"assets/assets/drawable/icons/2.0x/barbarian.png": "fc5190ed80bcc83099b77e8d2378cd7d",
"assets/assets/drawable/icons/2.0x/fighter.png": "650351ab7e179b91b538c94ec5523e38",
"assets/assets/drawable/icons/2.0x/wizard.png": "02507ab3b79f25b69a00e25221524192",
"assets/assets/drawable/icons/2.0x/rogue.png": "8884de7fada04a4ddae7ce38cbf794a5",
"assets/assets/drawable/icons/2.0x/druid.png": "ca7447ae8faa4041af9e877f50ed8006",
"assets/assets/drawable/stats/sword.png": "d068f36cca5e624dd072b8b0da171181",
"assets/assets/drawable/stats/shield.png": "0f265bb05c88b407241b63c694c3b863",
"assets/assets/drawable/stats/tent.png": "da7c90256030956c6381966ec2d0939d",
"assets/assets/drawable/stats/xp.png": "da4ee052eccfb3a82d03193eeed56a96",
"assets/assets/drawable/stats/heart.png": "f38e2bdc41eaedd904e79432a9911ada",
"assets/assets/drawable/stats/money.png": "adbbbc57d777323a2aaff33c4f03195b",
"assets/assets/drawable/stats/hammer.png": "280449e3197f9fd54de2fcfefad80838",
"assets/assets/drawable/dice/d20.png": "d120f9e789dba0bc1c5cb4e23c043aa9",
"assets/assets/drawable/shape/romb.png": "c96b10fb162a86eb4e1ff54e22e9ff99",
"assets/AssetManifest.json": "2dec12dfe6f03445a11240e68abe8e9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
