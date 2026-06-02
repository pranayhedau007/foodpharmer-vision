--
-- PostgreSQL database dump
--

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: food_allergies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.food_allergies (
    id integer NOT NULL,
    ingredient_name text NOT NULL
);


--
-- Name: food_allergies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.food_allergies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: food_allergies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.food_allergies_id_seq OWNED BY public.food_allergies.id;


--
-- Name: ingredient_aliases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredient_aliases (
    id integer NOT NULL,
    alias text,
    ingredient_id integer
);


--
-- Name: ingredient_aliases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredient_aliases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredient_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredient_aliases_id_seq OWNED BY public.ingredient_aliases.id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredients (
    id integer NOT NULL,
    name text,
    category text,
    health_label text,
    health_score double precision,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- Name: food_allergies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.food_allergies ALTER COLUMN id SET DEFAULT nextval('public.food_allergies_id_seq'::regclass);


--
-- Name: ingredient_aliases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredient_aliases ALTER COLUMN id SET DEFAULT nextval('public.ingredient_aliases_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- Data for Name: food_allergies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.food_allergies (id, ingredient_name) FROM stdin;
1	butter
2	eggs
3	milk
4	flour
5	all-purpose flour
6	wheat flour
7	celery
8	mayonnaise
9	pecans
10	walnuts
11	almonds
12	dijon mustard
13	mustard
14	dry mustard
15	shrimp
16	cheese
17	cream cheese
18	cheddar cheese
19	parmesan cheese
20	mzarella cheese
21	buttermilk
22	whipping cream
23	yogurt
24	heavy cream
25	sour cream
26	peanut butter
27	peanut
28	hazelnuts
29	cashew
30	sesame oil
31	soy sauce
32	soy
33	sesame
34	almond
35	peanuts
36	wheat germ
37	yogurt coated raisins
38	whey
39	malt
40	rye
41	rye flour
42	durum wheat flour
43	albumen
44	soybean oil
45	soybean
46	sesame seeds
47	milk sugar
48	peanut flour
49	milk protein
50	whole wheat flour
51	buckwheat flour
52	spelt flour
53	oat flour
54	hazelnut
55	sulfur dioxide
56	butter oil
57	white chocolate
58	liquid whole eggs
59	egg powder
60	gluten
61	pistachio
62	hazelnut paste
63	almond flour
64	egg white
65	malt flour
66	whey protein
67	soy lecithin
68	mustard seeds
69	sulfites
70	sulfite
71	peanut flavor
72	sheep milk
73	goat milk
74	skim milk powder
75	semolina
76	spelt
77	milk chocolate
79	milk powder
80	skim milk
81	cream
82	sweet whey powder
83	clams
84	clam broth
85	clam extract
86	soya lecithin
87	whole milk powder
88	wheat protein
89	lupin flour
90	arachis oil
91	egg albumen
92	mozzarella cheese
93	parmesan
94	sodium bisulfite
96	milk fat
97	casein
98	chocolate milk
99	caramel sweetened condensed skim milk
100	whey powder
101	reduced minerals whey
102	cultured milk
103	brazil nut
104	pecan
105	walnut
106	peanut oil
108	barley malt
109	wheat starch
110	khorasan wheat
111	macadamia nut
112	dried egg
113	egg yolk
114	milk solids
115	enriched wheat flour
116	nonfat dry milk
117	whole wheat
118	enriched flour
119	salmon
120	fish protein
121	crab extract
122	crab meat
123	crab protein
124	asiago
125	blue cheese
126	sodium caseinate
127	calcium lactate
128	sodium stearoyl lactylate
130	almond milk
131	soy milk
132	cashew milk
133	hazelnut milk
134	sardine
135	pollock
136	snow crab
137	crab and lobster extract
138	fish oil
139	mascarpone cheese
140	dried egg whites
141	vital wheat gluten
142	sweetened condensed skim milk
144	wheat gluten
145	textured vegetable protein (soy flour)
146	romano cheese
147	ricotta cheese
148	asiago cheese
149	fontina and provolone cheese cultured part-skim milk
150	pine nuts
151	dried yogurt
152	calcium caseinate
153	sour cream powder
154	egg whites
155	buttermilk powder
156	sweet whey
157	bleached wheat flour
158	blue cheese whey
159	kamut wheat
160	soy fiber
161	potassium metabisulfite
162	soybean with tbhq
163	modified soy protein
164	celery seed
165	cream and milk
166	soy extract
167	celery seed oil
168	egg yolk flavor
169	cultured dairy product
170	heavy whipping cream
171	sodium sulfite
172	cracked wheat flour
173	blue cheese cultures
174	parmesan and romano cheese blend
175	romano and blue cheese blend cultured milk
176	anchovy extract
177	fermented wheat flour
178	water and eggs
179	eggs with citric acid
180	cheese culture
181	monocasein
182	sesame paste
183	casein and soy protein isolate
184	cow's milk
185	butter milk powder
186	whey permeate
187	nonfat milk powder
188	ultrafiltered milk
189	milk protein concentrate
190	cultured cream and skim milk
191	milkfat
192	pasteurized low-fat milk
193	monterey jack cheese
194	part-skim milk
195	reduced fat cheddar
196	pasteurized milk colby cheese
197	pasteurized milk cheese
198	pasteurized cheese
199	pasteurized milk monterey jack cheese
200	black walnut
201	coconut oil and soybean oil
202	hard-cooked eggs
203	clam stock
204	anchovy
205	lobster
206	durum wheat semolina
207	swiss cheese
208	cheddar cheese milk
210	soy protein isolate
211	cultured buttermilk
212	lowfat buttermilk
213	soy protein and wheat gluten
214	mustard powder
215	macadamia nuts
216	butter milk
217	wheat fiber
218	malt syrup
219	fontina cheese
221	whole eggs
222	mackerel
223	tahini
224	mustard water
225	cheddar
226	sodium metabisulfite: sulfite, disodium edta: edta
227	egg yolks
228	skimmed milk cheese
229	yellowfin tuna
230	barley malt extract
231	wheat semolina
232	textured soy protein
233	miso
234	black soybean paste
235	almond flavor
236	soy protein and wheat protein
237	pink salmon
238	sour cream and blue cheese flavor
239	fermented wheat gluten
240	whole grain wheat flour
241	egg noodles
242	monofat milk
243	low-moisture mozzarella cheese
244	dairy product solids
245	miso extract
246	lactococcus lactis subsp. lactis and lactococcus lactis subsp. cremoris
247	barley syrup
248	barley malt syrup
249	mustard bran
250	gorgonzola cheese
251	ricotta cheese whey
252	grana padano
253	gruyère and fontina cheeses, milk
254	grana padano cheese
255	feta cheese
256	sweet cream
257	cream powder
258	flock of eggs
259	peanut paste
260	oyster sauce
261	oyster extract
262	dried whole egg
263	cashew butter
264	vanilla ice cream skim milk
265	wheat syrup
266	pecorino romano cheese
267	goat cheese
268	emmentaler cheese
269	dried milk
270	sweet cream butter
271	part-skim mozzarella cheese
272	emmer wheat
273	cracked wheat
274	durum flour
275	asadero cheese
276	pacific cod
277	sockeye salmon
278	blue crab extract
279	anchovy oil
280	gruyère
281	neufchâtel
282	pepper jack cheese
283	romano cheese powder
284	lecithinated soy flour
285	lecithinated soy flour with buttermilk
286	parmesan and romano cheeses pasteurized milk
287	egg protein
288	modified milk solids
289	pasteurized cow's milk
290	low fat milk
291	pine nut
292	pistachio paste
293	almond paste
295	celery root
296	potassium bisulfite
297	modified wheat starch
298	graham flour
299	enriched farina
301	brazil nuts
302	sesame seed
303	durum wheat
304	soybean oil with emulsifier propylene glycol monoesters
305	montamore cheese
306	reduced-fat milk
307	milk fructose
308	aged provolone cheese
309	cod
310	swai
311	mahi-mahi
312	halibut
313	walleye
314	lake whitefish
315	bluegill
316	nonfat dry milk; whey protein
317	evaporated milk
318	condensed milk
319	whole egg powder
320	scallops
321	sardine protein
322	filberts
323	sodium metabisulfite
324	scallop extract
325	horse mackerel
326	squid
328	black soybean
329	sodium bisulphite
330	threadfin bream fish paste
331	fish extract
332	oyster
333	fish paste
334	brown mustard
337	wheat
339	egg white powder
340	soybean paste
341	butter substitute
342	shellfish
343	king crab
344	cheese sauce mix
345	sweetened condensed whole milk
346	cheese whey
347	asiago and parmesan cheeses pasteurized milk
348	almond meal
349	cheddar cheese solids
350	nonfat dry milk powder
351	peanut flavour
352	peanut meal
353	romano cheese cultures
354	nonfat yogurt powder
355	parmesan cheese blend pasteurized milk
356	pasteurized cows milk
357	provolone
358	sodium chloride, cheddar cheese, enzyme modified cheddar cheese, milk
359	parmesan cheese, romano cheese, blue cheese, pasteurized milk
360	blue cheese milk
361	pasteurized process cheese food
362	semisoft cheese
364	dairy whey
365	asiago and provolone cheeses pasteurized cow's milk
366	clam meat
367	cashews
368	soy protein and wheat protein with partially hydrogenated soybean oil
371	sodium metabisulphite
373	sodium metabusulfite
374	sulphur dioxide
375	reduced protein whey
376	whey protein concentrate
377	sodium stearyl lactate
378	bleu cheese
379	milk and cream
380	anhydrous milkfat
381	lactobacillus bulgaricus and streptococcus thermophilus cultures
382	bifidobacterium lactis
383	lactobacillus rhamnosus
384	lactocasei
385	lactobacillus rhamnosus, lactobacillus casei
386	bifidobacterium
387	ghee
388	clarified butter
389	pasteurized whole milk cheese
390	soy mono- and diglycerides
391	soy grits
392	white fish
393	pistachio flavor
394	celery seeds
395	goat's milk
396	asiago and romano cheese pasteurized milk
397	bellavitano cheese
398	peanut oil and/or cottonseed oil
400	dried egg white
401	sprouted whole wheat flour
402	coarse durum wheat semolina
403	neufchatel
404	neufchâtel cheese
405	neufchatel cheese
406	organic cheddar cheese
407	cultured whey
408	pasteurized milk, parmesan cheese, monterey jack cheese
409	black sesame seeds
410	almond extract
411	mustard smoke flavoring
412	potassium bisulphite
413	tree nut meal pecan
414	condensed skim milk
415	coconut with sodium metabisulfite for color retention
\.


--
-- Data for Name: ingredient_aliases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ingredient_aliases (id, alias, ingredient_id) FROM stdin;
1	Bananas	92
2	vegetable oil coconut oil	135
3	corn oil and/or palm oil sugar	1
4	natural banana flavor.	136
5	Peanuts	137
6	wheat flour	131
7	sugar	1
8	rice flour	138
9	tapioca starch	139
10	salt	140
11	leavening ammonium bicarbonate	141
12	baking soda	24
13	soy sauce water	39
14	soybeans	142
15	wheat	143
16	potato starch.	139
17	Organic hazelnuts	144
18	organic cashews	145
19	organic walnuts almonds	146
20	organic sunflower oil	147
21	sea salt.	148
22	Organic polenta	149
23	Rolled oats	78
24	grape concentrate	150
25	expeller pressed canola oil	90
26	sunflower seeds	151
27	almonds	60
28	walnuts oat bran	152
29	sesame seeds	153
30	cashews	145
31	natural vitamin e.	154
32	Organic long grain white rice	64
33	Org oats	78
34	org hemp granola org oats	155
35	evaporated cane juice	1
36	org expeller-pressed canola oil	90
37	crispy rice org brown rice flour	64
38	org evaporated cane juice	1
39	org molasses	156
40	sea salt	98
41	org flax seeds	157
42	org oat solids	78
43	hemp seeds	158
44	org raisins	67
45	org dates	159
46	org almonds	160
47	org hazelnuts	144
48	org coconut	135
49	org sunflower seeds	151
50	org pumpkin seeds	161
51	org corn flakes org corn meal	162
52	org grape and/or pear juice concentrate	163
53	org quinoa amaranth flakes org corn meal	164
54	org yellow corn flour	165
55	org flax	157
56	org buckwheat flour	166
57	org quinoa	167
58	org amaranth	168
59	tocopherols natural vitamin e.	169
60	Organic chocolate liquor	118
61	organic raw cane sugar	170
62	organic cocoa butter	171
63	organic unrefined whole cane sugar	170
64	organic ground vanilla beans.	20
65	Organic expeller pressed	90
66	refined high oleic sunflower oil	147
67	Organic adzuki beans	172
68	Organic refined durum semolina wheat flour	131
69	Roasted peanuts peanuts	173
70	peanut or canola oil	26
71	sesame sticks unbleached wheat flour	131
72	sunflower oil	147
73	sa;t	148
74	beet powder	174
75	turmeric	175
76	chili crackers rice	64
77	corn starch	139
78	soy saucewater	39
79	brown rice syrup	176
80	paprika	55
81	onion powder	121
82	garlic powder	45
83	tamari roasted almonds almonds	160
84	tamari shoyu water	39
85	Organic golden flax seeds	157
86	Organic dry roasted pumpkin seeds	177
87	tamari soybeans	39
88	water and salt	178
89	garlic and cayenne.	179
90	Organic rolled oats	78
91	honey	36
92	raisins	67
93	walnuts	58
94	wheat germ	180
95	unrefined expeller-pressed safflower oil	181
96	molasses	156
97	cinnamon	15
98	Organic raw hazelnuts.	144
99	Organic bananas	136
100	organic coconut oil	135
101	organic sugar	170
102	Organic brown jasmine rice	64
103	Organic oat groats	78
104	Yogurt raisins	182
105	tamari roasted almonds	60
106	organic tamari roasted soy nuts	142
107	dark chocolate stars	118
108	cranberries	126
109	dark chocolate chips	118
110	peanut butter chips	173
111	milk chocolate raisins	183
112	pineapple	63
113	papaya	184
114	peanut butter peanuts & raisins	137
115	roasted peanuts.	173
116	Chocolate stars dehydrated cane juice	1
117	sweetened chocolate	56
118	cocoa butter	171
119	soy lecithin an emulsifier	185
120	natural vanilla	186
121	safflower	181
122	peanut	137
123	and/or canola oil	187
124	dry roasted almonds almonds	160
125	dry roasted cashews cashews	145
126	dried cranberries cranberries	188
127	dried cherries	189
128	dried blueberries blueberries	130
129	sunflower oil.	147
130	organic evaporated cane juice	1
131	organic quinoa flakes	167
132	organic raisins	67
133	organic expeller pressed canola oil	90
134	organic mango	190
135	organic oat bran	191
136	organic coconut.	68
137	Dry roasted almonds	160
138	hatch green chile seasoning organic cheddar cheese powder organic cheddar cheese {cultured pasteurized milk	32
139	enzymes}	192
140	organic nonfat milk	7
141	organic whey	193
142	sodium phosphate	194
143	hatch green chile pepper	195
144	onion	9
145	parsely	22
146	natural flavors	196
147	garlic	4
148	maltodextrin	197
149	spices	198
150	spices extractives	199
151	citric acid	200
152	expeller pressed canola oil.	90
153	Peanut butter dry roasted peanuts	173
154	palm oil	201
155	crispy brown rice brown rice flour rice flour	64
156	rice bran	202
157	calcium carbonate	203
158	barley malt	204
159	locust bean gum	205
160	carrageenan gum.	206
161	Ancient sea salt with natural trace minerals	148
162	Organic whole rolled oats	78
163	organic coconut	68
164	organic corn meal	134
165	organic flax seed	207
166	organic freeze dried raspberries	208
167	organic freeze dried blueberries	130
168	organic vanilla	20
169	salt.	148
170	Whole cashews	145
171	black pepper	12
172	curry seasoning salt	148
173	torula yeast	209
174	extractives of spice and natural flavor	210
175	canola oil.	187
176	wasabi spice salt	148
177	spice extracts	211
178	horseradish powder	212
179	yeast extract	209
180	dried parsley	22
181	spice	198
182	tamari shoyu sauce water	39
183	Organic red quinoa	167
184	Coconut bar coconut	68
185	dark chocolate coating unsweetened chocolate	118
186	dehydrated cane juice	1
187	soy lecithin as an emulsifier	185
188	natural vanilla.	186
189	Organic semi-sweet chocolate chips organic sugar	118
190	soy lecithin	185
191	organic pumpkin seeds	161
192	organic almonds	160
193	organic cranberries sweetened with organic cane juice	126
194	organic sunflower seeds.	151
195	Organic whole rolled oates	78
196	organic cinnamon	15
197	organic apples	213
198	organic blueberries	130
199	Raw cane demerara sugar.	170
200	flame raisins	67
201	organic coconut chips	68
202	organic maple syrup	170
203	roasted diced almonds	160
204	crunchy almond butter dry roasted almonds	160
205	hazelnuts	144
206	organic ground cinnamon	15
207	organic vanilla extract.	186
208	Organic black beans	214
209	Bluebird grain organic grain emmer farro	215
210	Organic hard red wheat berries.	143
211	organic brown rice syrup	176
212	unsulphured blackstrap molasses	156
213	almond butter	216
214	roasted almonds	160
215	organic spices.	198
216	turbinado sugar	170
217	organic rolled rye	217
218	organic walnuts	58
219	organic safflower oil	181
220	spices.	198
221	Organic black chia seeds	218
222	pasteurized free range egg.sugar.blueberries 15%.rapeseed oil.potato starch.water.cornflour.thickener.e1422.palm oil.dried whey milk.raising agent.e450	14
223	sodium bicarbonate. emulsifier. e481	24
224	e472e	219
225	e472b	219
226	e475.flavoring.dried glucose syrup.dried skimmed milk.stabiliser. xanthan gum.salt	220
227	Organic french green lentils	221
228	Organic garbanzo beans	222
229	Organic green split peas	132
230	High fiber	223
231	low fat	224
232	vegetable nourishment.	225
233	Organic small white beans.	226
234	Organic grey-green lentils	221
235	Organic yellow split peas	132
236	Organic mung beans	227
237	Organic baby lima beans	228
238	Organic dark red kidney bean	229
239	Whole	143
240	vegetable oil canola and/or safflower and/or sunflower oil	35
241	coconut	68
242	milled cane sugar	170
243	organic cardamon seed	230
244	organic fennel seed	231
245	organic fenugreek seed	232
246	organic nutmeg.	37
247	Whole rolled oats	78
248	natural flavor	210
249	organic cardamom seed	230
250	organic nutmeg	37
251	vegetable oil canola and/or sunflower oil	35
252	maple syrup	102
253	raisins raisins	233
254	vegetable glycerin	234
255	rolled rye apple powder	235
256	corn flour	165
257	apples	74
258	date powder	159
259	barley malt syrup	176
260	organic cinnamon bark	15
261	annatto for color	236
262	turmeric for color	175
263	purple carrot juice for color	237
264	dates may contain date pits	159
265	sunflower seeds and sesame seeds	238
266	Organic semolina flour	239
267	organic spinach powder	79
268	organic tomato powder.	240
269	Egg pasta refined durum semolina wheat flour	239
270	pasteurized eggs	14
271	dehydrated tomato and spinach	241
272	filling grated bread sticks	242
273	parmesan cheese	62
274	soybean oil	243
275	whole milk	7
276	egg whites	244
277	pepper and nutmeg	245
278	Refined enriched durum semolina wheat	246
279	thiamine	247
280	riboflavin	248
281	niacin and iron	249
282	Refined	1
283	enriched durum semolina wheat flour	131
284	niacin	250
285	iron	251
286	folic acid	252
287	Organic refined spelt flour.	131
288	rye	217
289	triticale	253
290	oat	254
291	corn	134
292	barley	255
293	soy bean	256
294	brown rice	64
295	and millet flours; flaxseed	257
296	buttermilk powder	72
297	non-aluminum baking powder baking soda	258
298	cornstarch	139
299	and monocalcium phosphate	259
300	New zealand sea salt with natural trace elements.	148
301	Organic evaporated cane juice.	1
302	Organic refined wheat flour niacin	131
303	thiamin mononitrate	247
304	riboflavin and folic acid.	260
305	Organic whole brown rice flour	261
306	Organic whole grain spelt flour	262
307	Organic whole rye flour.	235
308	constarch	263
309	acai berry.	264
310	Organic whole grain hard red wheat flour	131
311	Organic soft white wheat flour.	131
312	coating sucrose	1
313	wheat starch	139
314	xanthan gum	265
315	non gmo canola oil	90
316	Organic cashews.	145
317	Organic sesame seed with hulls	153
318	Organic hulled sesame seeds	266
319	hydrolyzed corn protein	267
320	natural smoke flavor	268
321	extractives	269
322	and expeller pressed sunflower oil.	147
323	Spanish peanuts	173
324	expeller pressed high monounsaturated safflower and/or sunflower oil	147
325	pecans	49
326	sucrose	170
327	lactose	270
328	Sunflower kernels	271
329	coconut oil	135
330	brazil nuts	272
331	expeller pressed	90
332	high monosaturated safflower and/or sunflower oil	273
333	Honey roast mixed nuts peanuts	173
334	safflower and/or sunflower oil	147
335	starch	139
336	milk chocolate wafers sugar	1
337	whole milk powder	7
338	unsweetened chocolate	118
339	vanilla	20
340	dried pineapple.	63
341	Organic raw sunflower seeds.	151
342	organic dry roasted peanuts	173
343	organic sunflower seeds	151
344	organic dates organic dates	159
345	organic oat flour	274
346	organic apricots	275
347	organic walnuts.	58
348	Us grown organic pecans.	49
349	Dry roasted almonds.	160
350	100% cold pressed unrefined oil from the first pressing of organic olives.	6
351	Water	5
352	bragg's formulated soy protein	276
353	Organic expeller pressed refined canola oil	90
354	organic whole soybeans	277
355	organic whole wheat	143
356	salt and alcohol to preserve freshness. cooked	140
357	mashed and fermented with a traditional microbial culture aspergillus oryzae.	278
358	mashed	279
359	and fermented with a traditional microbial culture aspergillus oryzae.	278
360	Maple	102
361	Precooked lentils	221
362	curry spices and herbs	280
363	onions	11
364	garlic.	281
365	Precooked green split peas	132
366	carrots	31
367	herbs and spices	211
368	Figs	282
369	stone-ground whole wheat flour	283
370	pear juice	284
371	unhydrogenated soybean oil	243
372	extract of malted barley and corn	197
373	cultured whey	285
374	lemon juice	18
375	and lecithin.	185
376	Peanut butter chips evaported cane juice	1
377	fractionated palm kernel oil	286
378	peanut flour	137
379	whey	193
380	lecithin	185
381	chocolate chips whole grain malted barley and corn	287
382	chocolate liquor with unsweetened chocolate	118
383	chocolate peanuts and raisins whole grain malted barley and corn	288
384	food glaze	289
385	Peanut butter coating evaporated cane juice	1
386	fractionated palm kernal oil	286
387	partially defatted peanut flour	290
388	whey powder milk	291
389	milk chocolate coating dehydrated cane juice	1
390	malt balls glucose syrup corn	220
391	whey powder	193
392	malted milk powder malted barley	204
393	milk	7
394	bicarbonate of soda	258
395	mono and diglycerides	292
396	pure food glaze.	289
397	organic wheat free tamari	39
398	seasoning water	293
399	whole soybeans	277
400	Pretzels: enriched flour refined wheat flour	131
401	malted barley flour	204
402	nianin	250
403	reduced iron	251
404	thiamine mononitrate and riboflavin	260
405	malt	204
406	yeast	294
407	baking soda. yogurt coating: dried cane juice	258
408	nonfat milk powder	7
409	yogurt powder	109
410	lacfic acid	295
411	soy lecithin added as an emulsifier	185
412	pure vanilla and confectioners glaze no sugar	20
413	Organic kamut flakes	296
414	Quick rolled oats	78
415	Organic bulgur.	143
416	Organic toasted buckwheat groats	297
417	Rolled barley	255
418	Red wheat flakes	143
419	white wheat flakes	143
420	barley flakes	255
421	rye flakes	217
422	sunflower seeds.	151
423	Whole grain corn	134
424	oats	78
425	oat bran	191
426	millet	298
427	sunflower seeds and flax seeds	299
428	rolled wheat	143
429	rolled rye	217
430	date pieces	159
431	toasted almonds	160
432	roasted hazelnuts	300
433	roasted walnuts	58
434	raw sunflower seeds	151
435	Organic hulless barley	255
436	Organic millet	298
437	Organic popcorn	162
438	Organic soft white wheat berries	143
439	Organic pearled barley.	255
440	Organic wheat bran	301
441	Organic raw buckwheat groats	297
442	Organic thick cut rolled oats	78
443	Organic regular rolled oats	78
444	Organic rolled rye flakes	217
445	Steel-cut are whole groats sliced.	78
446	Spelt berries	302
447	Unmilled wehani	64
448	japonica black	303
449	and long grain brown rices	64
450	Organic arborio rice	64
451	Organic golden rose medium brown rice	64
452	wehani rice	64
453	black japonica rice	64
454	black-eyed peas	304
455	brown lentils	221
456	green split peas	132
457	yellow split peas	132
458	Organic short grain brown rice	64
459	Organic sweet brown rice	305
460	Organic california white sushi rice	64
461	Organic basmati rice	64
462	organic green and yellow peas	132
463	organic red and green lentils	221
464	and organic wild rice.	64
465	Organic wild rice	64
466	alcohol and vanilla bean extractives.	186
467	Organic brown flax seeds	157
468	Apricots	275
469	sulfur dioxide.	306
470	vegetable oilcoconut oil	135
471	corn oil	307
472	and/or palm oilsugar	201
473	natural banana flavor	136
474	whole rolled wheat	143
475	organic nu	308
476	Dried mango	190
477	and cayenne.	195
478	Milk chocolate sugar	170
479	chocolate liquor	118
480	vanillin an artificial flavor	20
481	pretzels enriched wheat flour wheat starch	131
482	thiamine mononitrate	247
483	silicon dioxide anti-caking agent	309
484	syrup	310
485	sodium bicarbonate	258
486	yeast.	294
487	tapioca starch salt	148
488	leaveningammonium bicarbonate	141
489	soybean	256
490	wheat salt	148
491	milk chocolate 32% sugar	56
492	dried whole milk	7
493	cocoa mass	118
494	dried whey milk	193
495	dried skimmed milk	7
496	emulsifier: soya lecithin	185
497	dark chocolate 17% sugar	118
498	butter oil milk	311
499	vanilla flavouring	186
500	wheatflour contains gluten with wheatflour	131
501	thiamin	247
502	white chocolate 13% sugar	312
503	butter milk	72
504	palm kernel oil	286
505	palm fat	201
506	cocoa powder	96
507	partially inverted sugar syrup	220
508	glucose syrup	220
509	cornflour	263
510	oatmeal contains gluten	78
511	ginger	28
512	raising agent: sodium bicarbonate	24
513	e450	313
514	e503	314
515	dextrose	315
516	ground ginger	28
517	pasteurised free range egg	14
518	flavourings	316
519	orange peel	317
520	lemon peel	317
521	colour: carotenes	318
522	acidity regulator: citric acid	200
523	carbonated  water	5
524	acid: citric acid; flavourings	200
525	acidity regular: trisodium citrate; sweetener: sucralose; preservative: potassium sorbate	319
526	Organic pistachios	320
527	Roasted pistachios.	320
528	Organic medjool dates.	159
529	Organic dried plums	321
530	Organic deglet noor dates	159
531	Apple juice concentrate	322
532	Organic zante currants	323
533	Organic select thompson seedless raisins	67
534	and organic sunflower oil.	147
535	Organic unrefined extra virgin coconuts oil	135
536	Organic brown basmati rice	64
537	Organic white basmati rice	64
538	Organic unrefined mascobado sugar.	170
539	Organic dry roasted peanuts.	173
540	Pecan halves	49
541	Organic pearl quinoa	167
542	Fresh organic carrots	119
543	INGREDIENTS : LAITUE. VINAIGRETTE HUILE DE CANOLA. EAU. AIL. JAUNE D'OEUF CONGELE. FROMAGE PARMESAN. JUS DE CITRON CONCENTRE. SEL. PATE D'ANCHOIS. ASSAISONNEMENTS. GOMME XANTHANE. FROMAGE PARMESAN. CROUTONS FARINE. FARINE DE BLE ENTIER. HUILE DE PALME. EAU. GLUCOSE—FRUCTOSE. FARINE DE SEIGLE. SEL. GLUTEN DE BLE. CARAMEL. MELASSE OUALITE FANTAISIE. POUDRE DE LACTOSERUM. MALTODEXTRINE. CARVI. LEVURE. VINAIGRE. SUCRE. POUDRE D'AIL. LEVAIN DE SEIGLE.  PERSIL. ACIDE ASCORBIQUE. PHOSPHATE MONOCALCIQUE. SULFATE D'AMMONIUM. SULFATE DE CALCIUM. CITRON.	324
544	Ingrédients: Pâte farine	131
545	eau	5
546	beurre	2
547	sucre	1
548	cassonade	13
549	levure	294
550	lactosérum en poudre	193
551	oeufs entiers liquides	325
552	sel	148
553	farine de gluten	326
554	huile de Soya	243
555	esters tartriques des mono et disglycérides acetyles	327
556	carbonate de calcium	328
557	acide ascorbique	329
558	amylase	330
559	arôme artificiel. GARNITURE : sucre	1
560	substances laitières modifiées	7
561	farine	8
562	épices	198
563	farine de Pomme de terre modifiée	331
564	amidon de maïs modifié	332
565	huile végétale	26
566	poudre d'œuf	333
567	cacao	118
568	poudre à pâte	17
569	arginate de sodium	334
570	sorbate de calcium	335
571	sorbitol	336
572	sirop de maïs	220
573	pectine	337
574	sorbate de potassium	338
575	gomme de caroube	339
576	chlorure decalcium	340
577	mono et diglycérides	341
578	acide citrique	200
579	agar	342
580	colorant.	343
581	modified potato starch	331
582	glucose-fructose syrup	344
583	acid: malic acid	345
584	lactic acid	295
585	acidity regulator: calcium carbonate - fruit	328
586	vegetable and plant concentrates safflower	346
587	apple	213
588	lemon	29
589	pumpkin	347
590	carrot	119
591	red grape	348
592	blackcurrant	349
593	elderberry juice from concentrate	350
594	invert sugar syrup	170
595	spirulina concentrate	351
596	Ingrédients : Pâte farine	131
597	margarines d'huile de palme et de canola	352
598	L-cystéine	353
599	essences. Garniture: Pommes	213
600	glucose-fructose	1
601	cannelle	15
602	chlorure de calcium	340
603	benzoate de sodium	354
604	sulfites	306
605	sucre.	1
606	Ingrédients : Farine	8
607	orge malté	287
608	lentilles vertes	355
609	Eau gazéifiée	356
610	sirop de maïs à haute teneur en fructose	344
611	colorant : caramel	357
612	conservateur : E211	354
613	arômes naturels et artificiels	316
614	moussant : E999.	358
615	farine de Blé	131
616	graisse et huiles végétales karité	359
617	colza et tournesol	360
618	cacao maigre en poudre 7%	96
619	sirop de glucose	220
620	dextrine	197
621	Beurre concentré	2
622	Oeufs	3
623	pâte de Noisette	361
624	pâte de cacao	118
625	émulsifiants : lécithines colza et tournesol	185
626	poudre à lever : carbonates d'ammonium	141
627	arômes.	196
628	INGRÉDIENTS : GARNITURE SUBSTANCES LAITIÈRES. JAMBON PORC. BOUILLON DE LEGUMES. SEL. SUCRE	362
629	DEXTROSE. NITRITE DE SODIUM. LACTATE DE SODIUM	315
630	ERYTHORBATE DE SODIUM. DIÂCETATE DE SODIUMI	363
631	OEUF LIQUIDE ENTIER. FROMAGES CHEDUAR ET SUISSE SUBSTANCES LAITIERES MODIFIEES. SEL. CULTURE BACTERIENNE. ENZYME MICROBIEN. CHLORURE DE CALCIUM. NATAMYCINE. CELLULOSE. OIGNON. AMIDON DE MAIS MODIFIE. EPICES. SEL. CITRATE DE SODIUM. PHOSPHATE DE SODIUM	14
632	CARRAGHENINE. GOMME DE CAROUBE	206
633	CROUTE FARINE. SHORTENING D'HUILE DE PALME ET DE CANOLA. EAU. DEXTROSE. SEL. LEVURE. HUILE VEGETALE. L-CYSTEINE. PROPIONATE DE SODIUM	131
634	FROMAGES CHEDDAR ET MONTEREY SUBSTANCES LAITIERES MODIFIEES. CULTURE BACTERIENNE. SEL. ENZYME MICROBIEN. CHLORURE DE CALCIUM. CELLULOSE. COLORANT. NATAMYCINE. PERSIL SECHE. CONTIENT 2 OEUF. BLE. LAIT.  PEUT CONTENIRZ POISSON. MOLLUSQUES. CRUSTACES. NOIX  VARIEES. SESAME. MOUTARDE. SOYA. SULFITES.	38
635	Thé noir aromatisé à la fleur de violette et parsemé de bleuets	364
636	Thé noir de Chine	365
637	zestes d'oranges 7	366
638	5 %	367
639	arômes naturels cannelle 4	15
640	7 %	148
641	orange 4	119
642	poudre de cannelle 3	15
643	9 %.	225
644	Sirop saveur pistache 5 cl : sirop 99	368
645	16 % sucre cristallisé	1
646	arôme	316
647	acidifiant : acide citrique E330	200
648	denrée alimentaire colorante concentrés de carthame	346
649	pomme	213
650	colorant : mélange d'additifs : E171	369
651	E211	354
652	E131. Sirop saveur framboise 5 cl : sirop 93	310
653	98 % sucre	1
654	denrée alimentaire colorante concentrés de patate douce	370
655	cerise	371
656	radis	372
657	carthame	346
658	arôme naturel	210
659	E211. Sirop saveur citron 5 cl : sirop 98	354
660	86 % sucre cristallisé	170
661	denrée alimentaire colorante concentré de pomme	373
662	E211. Sirop saveur violette 4 cl : sirop 88	354
663	40 % sucre	1
664	denrée alimentaire colorante concentré de cassis	374
665	carotte	119
666	colorant : mélange d'additifs : E131	375
667	blanc d’œufs frais	376
668	poudre d’amande 16.5%	377
669	beurre pâtissier	2
670	pépites au citron 7% sucre	29
671	pulpe de citron 18.1%	378
672	fibres d’ananas	379
673	gélifiant : alginate de sodium	380
674	correcteurs d’acidité : acide citrique - citrates de potassium	200
675	stabilisant : phosphates de calcium	381
676	arôme naturel de citron	382
677	colorant : curcumine	383
678	œufs frais	3
679	sirop de glucose-fructose	220
680	stabilisant : glycérol	234
681	poudre de citron 0.9 % équivalent à 5% de jus de citron jus concentré de citron	18
682	maltodextrine	197
683	poudres à lever : carbonates de sodium - diphosphates blé	17
684	arôme naturel de citron. % exprimé sur les pépites équivalent à 1.2% sur l’ensemble du produit.	382
685	salt 4	148
686	8%	384
687	acidity regulator sodium hydroxide	385
688	malted wheat flour	386
689	emulsifier mono-und diglyderides of fatty acids.	341
690	Molkenproteinkonzentrat 99%Wheyproteinkonzentrat	387
691	nur Schoko Kakaopulver entölt	118
692	Aroma	316
693	Pflanzenöl aus Raps	187
694	Süßungsmittel Acesulfam-K und Sucralose.	388
695	williams pear brandy 8%	389
696	invert sugar	170
697	skimmed milk powder	7
698	thickener gum arabic	390
699	emulsifier soy lecithin	185
700	barley malt extract	391
701	flavoring vanillin.	186
702	Unpeeled potatoes	279
703	chocolate	56
704	soy lecithin - an emulafier	185
705	vanllan - an artificial flavor	186
706	soy lecithin -an emulsifier	185
707	vanillin - an artificial flavor.	392
708	Semi-sweet chocolate: sugar	170
709	chocolate liquor processed with alkali	118
710	milk fat	393
711	vanillin-an artificial flavor	186
712	natural flavors.	196
713	White chocolate: sugar	170
714	vanillin an artificial flavor.	20
715	soy lecithin-an emulsifier	185
716	vanillin-an artificial flavor.	20
717	soy lecithin - an emulsifier	185
718	Bittersweet chocolate chocolate	118
719	vanilla.	186
720	vanillian-an artificial flavor.	186
721	chocolate processed with alkali	118
722	vanillian-an artificial flavor	186
723	soy lecithin- an emulsifier	185
724	chocolate. soy lecithinan emulsifier	394
725	vanillian-an artificial flavor. malt center: corn syrup	186
726	whey dairy	193
727	malted milk malted barley	204
728	malt extract	391
729	coco	118
730	vanillian-an artificial flavors.	186
731	Semi-sweet chocolate sugar	1
732	vanilla-an artificial flavor	186
733	vanillin-an-artificial flavor	186
734	Mix chocolate sugar	1
735	Gherkins cucumbers	122
736	vinegar	73
737	mustgard seeds	395
738	tarragon	396
739	garlic pepper	4
740	contains sulfities.	397
741	xylitol	398
742	ascorbic acid	329
743	malic acid	345
744	natural and artificial flavors	196
745	sucralose	399
746	blueberry juice concentrate	400
747	sodium benzoate and potassium sorbate as a preservative.	401
748	glycerin	234
749	sodium benzoate and potassium sorbate as preservatives	402
750	yellow #5	403
751	blue #1.	375
752	Romaine hearts.	324
753	Romaine.	324
754	Green leaf.	324
755	Spinach.	79
756	Cooking spinach	79
757	Brussels sprouts.	404
758	Celery	27
759	Kalettes kale sprouts.	404
760	vegetable oil coconut tree nut	135
761	palm kernel	286
762	palm	201
763	cereals corn flour	165
764	lowfat cocoa powder	118
765	barley's	255
766	hazelnuts tree nut	300
767	lowfat c	405
768	barley's malt extr	391
769	puffed rice 12%	64
770	vegetable oil & fat palm	201
771	milk powder	7
772	soy flour	276
773	hazelnuts 3%	300
774	butter oil	311
775	glycerin humectants	234
776	soya & rapeseed lecithin and pgpr emulsifier	185
777	vanillin	186
778	artificial fla	316
779	Fuji apple cider	322
780	apple cider	322
781	pomegranate juice.	406
782	Filtered water	5
783	pure cane sugar.	170
784	natural flavor and spice.	407
785	Pink lady apple cider	322
786	apple cider.	322
787	100% organic apple juice.	322
788	Opal apple cider	322
789	Concentrated apple puree	213
790	concentrated apple juice	322
791	ascorbic acid vitamin c	329
792	natural pineapple flavor	63
793	natural mango flavor	408
794	concentrated black carrot juice for color	409
795	pectin	337
796	shellac	289
797	beeswax.	410
798	natural blueberry flavor	411
799	natural pomegranate flavor	412
800	Corn syrup	315
801	gelatin	413
802	natural & artificial flavor	196
803	root beer concentrate caramel color	357
804	mineral oil	414
805	carnauba wax.	415
806	fd&c red 40	416
807	yellow 5	403
808	yellow 6	417
809	blue 1	375
810	carnauba wax	415
811	Maltitol	398
812	inulin natural vegetable fiber	418
813	cinnamon.	419
814	white grape juice from concentrate	150
815	tartaric acid	420
816	fumaric acid	421
817	natural & artificial flavours	316
818	silicon dioxide anticaking agent	309
819	artificial colours fd&c red 40	416
820	modified corn starch	332
821	citrict acid	329
822	sodium citrate	200
823	natural and artificial flavours	316
824	red 40	416
825	blue 1.	375
826	assorted nonpareils sugar	1
827	confectioners glaze	289
828	hydrogenated palm kernel oil	286
829	whey protein concentrate milk	291
830	cocoa powder processed with alkali	422
831	modified food starch corn	263
832	apple puree	213
833	artificial flavor	407
834	carnuba wax	415
835	artificial colors fd&c red 40	416
836	Fuji apples.	74
837	strawberries.	423
838	Mangos.	190
839	Grapes.	424
840	Fuji apples	74
841	citric acid.	200
842	Dried apricots	275
843	sulfur dioxide to preserve flavor	306
844	malic acid.	345
845	Honey crisp apples	213
846	sulfur dioxide to preserve freshness.	306
847	Mango	190
848	mango juice	425
849	mangos	190
850	blueberries	130
851	sulfur dioxide to preserve flavor.	306
852	sodium sulphite.	426
853	Peanuts flavored dried cranberries cranberries	126
854	peanut flavored coating dried cane syrup	1
855	yogurt flavored coa	118
856	strawberry flavored dried cranberries cranberries	126
857	elderberry juice concentrate color	237
858	whey powde	193
859	flavored dried cranberries cranberries	188
860	natural flavor. peanut flavored coating dried cane syrup	427
861	yogurt flavored c	109
862	sodium sulphite to preserve freshness.	426
863	white grape juice concentrate	150
864	natural and artificial flavor	196
865	red 3	428
866	Grape juice	150
867	concentrate	429
868	modified food starch	139
869	Grape juice concentrate	150
870	natural & artificial flavors	196
871	re	430
872	yello	431
873	lactose milk	405
874	corn syrup solids	344
875	fd&c blue 1	375
876	processed with carbon dioxide for popping effect.	432
877	fd&c yellow 5	403
878	Pure raw honey	36
879	whole organic raspberries	433
880	whole organic hibiscus flowers	434
881	lemon juice.	200
882	real raspberries.	435
883	real hibiscus flowers.	434
884	Shrimp salt	148
885	sodium phosphate to retain moisture	194
886	Stone ground organic yellow corn	134
887	expeller pressed safflower or sunflower oil	147
888	salt and lime.	436
889	Ingredients: dry roasted almonds	160
890	pistachios	320
891	pure cane sugar	170
892	rice syrup	176
893	dried blueberries	411
894	pomegranate powder	412
895	sea salt and natural flavors.	437
896	Organic coconut water	438
897	ascorbic acid.	329
898	Pitted california dried plums with potassium sorbate as a preservative.	321
899	Vital wheat gluten.	326
900	Caperberries	439
901	vinegar and salt.	440
902	Nutella: sugar	170
903	cocoa	118
904	skim milk	7
905	whey milk	193
906	lecithin as emulsifier soy	185
907	vanillin: an artificial flavor. breadsticks: wheat flour	186
908	baker's yeast	294
909	malt extract.	176
910	skim	7
911	vanillin: an artificial flavor.	392
912	Pasteurized cow milk	7
913	pasteurized sheep milk	441
914	pasteurized goat milk	442
915	rennet.	443
916	Pâtisseries fourrées à la pulpe de pêche : farine de blé	131
917	fourrage pêche 20% sirop de glucose-fructose	444
918	purée de pêche 50%	444
919	gélifiant : pectines	337
920	correcteurs d’acidité : acide citrique - citrates de sodium	200
921	arômes	196
922	conservateur : sorbate de potassium	338
923	huile de colza	187
924	poudres à lever : carbonates d’ammonium - carbonates de sodium - diphosphates blé	17
925	lait écrémé en poudre	445
926	émulsifiants : mono et diglycérides d’acides gras	446
927	arôme. % exprimé sur le fourrage équivalent à 10% sur l’ensemble du produit. Pâtisseries fourrées à la pulpe d'abricot : farine de blé	275
928	fourrage abricot 20% sirop de glucose-fructose	275
929	purée d'abricot 50%	275
930	arôme. % exprimé sur le fourrage équivalent à 10% sur l’ensemble du produit. Pâtisseries fourrées à la pulpe de fruits rouges : farine de blé	316
931	fourrage fruits rouges 20% sirop de glucose-fructose	447
932	purée de fraise 17.8%	448
933	purée de framboise concentrée 5% équivalent à 21.2% de purée de framboise	208
934	purée de cerise concentrée 3% équivalent à 11% de purée de cerise	371
935	arôme. soit un équivalent de 50% de purée de fruits sur le fourrage équivalent à 10% sur l’ensemble du produit.	449
936	Organic tomatoes	240
937	organic tomato juice	450
938	calcium chloride.	340
939	Wheat flour - coconut oil - dehydrated glucose syrup - sugar hazelnuts 10.8% in the cream corresponding to 8	144
940	6% of the total ingredients - whey powder milk - soya flour - dried skimmed milk - low fat cocoa - dextrose - emulsifier: soya lecithin - raisin	7
941	Strawberries	88
942	high fructose corn syrup	344
943	fruit pectin.	337
944	Durum wheat semolina	451
945	water.	5
946	Tomatoes	19
947	canola oil	90
948	chili powder spices	195
949	caramel	452
950	mustard flour	95
951	cilantro	47
952	tamarind	453
953	sodium benzoate preservative	454
954	spice extract	199
955	disodium edta t	455
956	calcium sulfate	456
957	magnesium chloride.	457
958	alcohol	384
959	rice	64
960	Glucose	315
961	Peppermint Flavouring	458
962	Gelling Agent: Beef Gelatine	459
963	Menthol	460
964	Thiamin • Dark Chocolate Chunks 22% Sugar • Cocoa Mass • Cocoa Butter • Emulsifier: Soya Lecithin • Vanilla Flavouring • Sugar • Butter Milk 18% • Milk Chocolate Chunks 11 % Sugar • Dried Whole Milk • Cocoa Butter • Cocoa Mass • ü noulsifier: Soya Lecithin • Vanilla Flavouring • Raising Agent: E450	461
965	E503 • Salt • Vanilla Flavouring. Dark Chocolate contains Cocoa Solids 42% minimum. Milk Chocolate contains Cocoa Solids 29% minimum	118
966	Milk Solids 22% minimum.	7
967	Farine de blé contient Gluten avec Farine de blé	131
968	Fer	251
969	Niacine	250
970	Thiamine - Sucre - Beurre Lait - Raisins de Smyrne 17% - Sirop de glucose - Lait en poudre écrémé - Poudre à lever: E450	247
971	Bicarbonate de soude	258
972	E503 - Sel.	462
973	Morceaux de chocolat blanc 35% Sucre - Lait en poudre entier -Beurre de cacao - Lait en poudre écrémé émulsifiant : lécithine de soja	312
974	arôme vanille - Farine de blé avec Farine de blé	131
975	Thiamine - Beurre 19% - Sucre - Fécule de maïs -Poudre à lever: E450	463
976	E5030 - sirop de sucre inverti - sel.	464
977	Sucre • Beurre Lait 15% • flocons d'avoine contient du gluten • Farine de blécontient du gluten avec du blé	465
978	du carbonate de calcium	328
979	du fer	251
980	de la niacine	466
981	de la thiamine • Raisins secs 12% • Noix de coco desséchée 8 % • Abricots séchés 7 % Abricots • Farine de riz • Conservateur: E220 Sulfites • Golden syrup sirop de sucre inverti • œufs pasteurisés • Agent de levage: Bicarbonate de sodium	247
982	Mélasse.	156
983	Thiamine • Beurre Lait 23% • Sucre • Eclats de pistaches 14% • Éclats d'amandes 8% • Sirop de sucre inverti • Poudre à lever : E450	247
984	Bicarbonate de soude • Lait en poudre . Sel.	467
985	Farine de blé contient Gluten avec Farine de blé. Carbonate de; calcium. Fer. Niacine	131
986	Thiamine - Canneberges déshydratées sucrées 29% Sucre - canneberges - Antioxydant : Acide citrique - Huile de tournesol - Sucre - Beurre Lait 17% . Sirop de glucose - Fécule de maïs - Lait en poudre  - Poudre à lever: E450	468
987	E503 - Sel - Arôme orange.i	462
988	Thiamine -  Beurre Lait 23% - Gingembre confit cristallisé 18%  Gingembre conﬁt	2
989	Sucre - Sucre - Flocons d'avoine contiennent Gluten 12% - Sirop de sucre inverti - Gingembre moulu - Poudre à lever: E503	1
990	E450 - Lait en poudre écrémé - Sel	469
991	Thiamine; Sucre; Gingembre conﬁt cristallisé 17% Gingembre	468
992	Sucre de Canne; Beurre Lait 13%; Flocons d'avoine contient Gluten; Avoine grossièrement moulue contient Gluten; Fécule de maïs; Lait en poudre écrémé; Émulsifiant: Lécithine de soja ; Poudre à lever : E450	1
993	E503; Sirop de sucre inverti; Gingembre moulu; Sel.	148
994	nut Thiamin Dark Chocolate Chips 20% Sugar ? Cocoa Butter ? Cocoa Mass ? Emulsifier: Soya Lecithin ? Vanilla llavouri ng ? Palm Oil ? Sugar ? Roasted Hav!nuts 3% ? Dried }kimmed Milk ? Golden Syrup Invert Sugar Syrup Salt ? Raising Agent: Sodium Bicarbonate	56
995	E503 ? Emulsifier: Soya Lecithin ? Vanilla Flavouring. Dark Chocolate contains Cocoa Solids 39% minimum.	470
996	beurre lait 23 %	2
997	gingembre confit cristallisé 18 % gingembre confit	28
998	flocons d'avoine contiennent gluten 12 %	78
999	sirop de sucre inverti	471
1000	gingembre moulu	28
1001	poudre à lever : E503	314
1002	lait en poudre écrémé	445
1003	sel.	148
1004	Lait écrémé	472
1005	crème	473
1006	poudre de lactosérum sucré	474
1007	stabilisants E412	475
1008	E407	206
1009	émulsifiant E471	476
1010	arôme de vanille.	186
1011	Cheddar 51%	38
1012	fromage 9%	38
1013	sels de fonte E331	477
1014	E330	200
1015	protéines de lait	291
1016	arômes naturels	210
1017	colorants beta carotène	478
1018	extrait de paprika	55
1019	antiagglomérant lécithine de tournesol.	185
1020	Refined olive oil	6
1021	extra virgin olive oil.	6
1022	California wild rice.	479
1023	Extra virgin olive oil	6
1024	Dry roasted peanuts.	173
1025	Dry roasted peanuts	173
1026	Monocalcium phosphate	259
1027	cornstarch.	139
1028	Creamed honey.	36
1029	fresh yellow chile	195
1030	distilled vinegar from corn	480
1031	spice.	198
1032	Whole peeled	240
1033	cored gravenstein apples and well water.	481
1034	Sea clams	482
1035	sea clam juice	483
1036	potatoes	34
1037	natural clam flavor	484
1038	black pepper.	485
1039	Organic peanuts	173
1040	organic coconut sugar	170
1041	Olives	486
1042	vinegar contains sulfats	480
1043	jalapeno pappers	195
1044	lactic acid.	295
1045	unpeeled tomatoes	19
1046	extra heavy tomato puree	487
1047	cold pressed extra virgin olive oil	6
1048	herbs	488
1049	Carbonated mountain spring water	5
1050	blackberry juice concentrate	489
1051	potassium benzoate to ensure freshness	490
1052	green tea extract	491
1053	red #40	416
1054	biotin 1% trit. maltodextrin	492
1055	niacinamide b3	250
1056	d-calcium pantothenate b5	493
1057	vi	494
1058	Carbonated water	356
1059	orange juice concentrate	65
1060	gum arabic	390
1061	ester gum	495
1062	calcium disodium edta to protect flavor	455
1063	biotin	492
1064	niacin b3	250
1065	pantothenic	496
1066	pineapple juice concentrate	497
1067	coconut water concentrate	438
1068	biotin 1% trit	492
1069	d-c	498
1070	peach juice concentrate	499
1071	niacinami	250
1072	lemon juice concentrate	200
1073	yellow	383
1074	calcium disodium edta to protect	455
1075	cherry juice concentrate	500
1076	lime juice concentrate	200
1077	green tea extra	501
1078	flavor	316
1079	glazing agent: beeswax white and yellow	502
1080	acidity regulator: sodium citrate	319
1081	caramel syrup	452
1082	stabilizer: carrageenan.	206
1083	cocoa mass rum - raisins raisins	118
1084	rum 60% vol.	384
1085	rum flavor	186
1086	hazelnut paste	361
1087	emulsifier: soy lecithin	185
1088	flavor: vanille extract. cocoa solids: 31% minimum in chocolate.	20
1089	Salade Iceberg	503
1090	Carbonate Niacine	466
1091	Thiamine - Eau - farine de blé fermenté déshydraté contient gluten - levure levure	294
1092	levure enrichie en vitamine D - Poudre à lever : E450	17
1093	Bicarbonate de soude - sucre - sel.	504
1094	Large flat mushrooms	505
1095	More information on www.paulandlinh.com Mékong Biscuits à l'abricot sans gluten et sans lait Inaréd:ents: abncots• 27% . swe de canne'. Œufs	275
1096	huile de colza'. fanne de riz'. fanne de chàtagne•	187
1097	amandese miel'. amidon de mais'. poudre de vanille Bourbon'. poudre à IZ c bicarbonate de sodium	506
1098	tartrate monopotassique	507
1099	arôme naturel d'abricot Produits ISSUS de rAgricu!ture Fabriqués dans un ateLer uti•	508
1100	Chaudin de porc	509
1101	poivre	10
1102	conservateur : E250	367
1103	colorant : caramel ordinaire	452
1104	fumage au bois de hêtre. Enveloppe: boyau naturel. Abats de porc origine France et UE	510
1105	de vos supers sablés sont : une cuillère de flocons d'avoine 28	254
1106	8%3 du chocolat au tait 27% du sucre	118
1107	du beurre de cacao	171
1108	de la poudre de lait entier	511
1109	de la pâte de cacao	118
1110	une pointe d'émulsifiant : lécithines soja	185
1111	et un soupçon d'arôme naturel de vanille' une noix de beurre frais une cuillerée de farine de blé une petite cuillère de sucre roux de canne un peu de farine complète de blé des poudres à lever carbonates d'ammonium	20
1112	carbonates de sodium	512
1113	phosphates de calcium	381
1114	de la farine de seigle de la farine d'orge et une pincée de sel de Guérande. • Pourcentages exprimés sur l'ensemble du produite Gourmand et allergique ? contient : gluten	235
1115	soja et lait peut contenir : œufs et fruits à coque.	513
1116	Proteinmischung Sojaprotein	276
1117	Weizenprotein	514
1118	Molkenprotein	291
1119	Wheyprotein	387
1120	Milchprotein	291
1121	Hühnereiweiss	376
1122	Kakaopulver nur Sorte Schoko	118
1123	Pflanzenöl	26
1124	Süßungsmittel Natriumsaccharin und Acesulfam-K.	515
1125	Seasoned flour wheat flour wheat starch baking powder sodium bicarbonate	131
1126	glucond	516
1127	deltalactone	517
1128	calcium	203
1129	phosphate	194
1130	sodium acid pyrophosphate	518
1131	pepper	10
1132	shrimp	86
1133	and sugar.	170
1134	almonds 30%	160
1135	egg white	376
1136	wafers potato starch	519
1137	vegetable oil	26
1138	flavourings.	316
1139	Mediterranean sea salt.	148
1140	distilled vinegar	480
1141	seasoning blend salt	148
1142	spices including red pepper	195
1143	red and green bell pepper	195
1144	sodium benzoate and potassium sorbate to protect quality	402
1145	lime juice	61
1146	tomato puree water	240
1147	tomato paste	83
1148	including chioptle chili pepper	195
1149	caramel color	357
1150	sodium benzoate and potassium sorbate and calciu	402
1151	spices including black pepper	520
1152	mustard seed	95
1153	caraway seed	521
1154	Brown rice flour	261
1155	chili powder	59
1156	granulated onion	9
1157	granulated garlic	4
1158	ground cumin	43
1159	and oregano.	42
1160	Maple syrup.	170
1161	fourrage lait et caramel 17% sirop de glucose-fructose	522
1162	lait concentré sucré 20%	523
1163	caramel 2.5%	452
1164	chocolat au lait 11% sucre	461
1165	beurre de cacao	171
1166	poudre de lait entier	511
1167	émulsifiant : lécithines soja	185
1168	poudres à lever : carbonates d'ammonium - carbonates de sodium - diphosphates blé	17
1169	arôme. % exprimés sur le fourrage équivalent respectivement à 3.4% et 0.4% sur l’ensemble du produit.	316
1170	Thiamine • Sucre • Noix de Pécan 12% • Beurre Lait • Huile de palme • Huile de colza • Sirop • Sirop de sucre inverti • Fructose • Sucre roux • Lait écrémé • Maltodextrine • Sirop de sucre • Œufs de poules en poudre • Poudre à lever : Bicarbonate de soude	247
1171	Organic flours organic wheat	131
1172	organic oat and organic corn	524
1173	organic strawberry filling organic cane syrup	448
1174	organic apple powder	213
1175	organic rice starch	139
1176	organic strawberries	88
1177	red cabbage extract for color	237
1178	organic cane syrup	170
1179	organic sunflower and/or organic canola oil	26
1180	organic honey	36
1181	organic butter flavor milk	72
1182	cream of tarter	420
1183	organic acacia gum	390
1184	vitamin mix niacinamide	466
1185	pyridoxine hydrochloride	525
1186	cyanocobalmin	526
1187	thiamine hydrochloride	247
1188	zinc oxide	527
1189	reduced iron.	251
1190	Chili	195
1191	potassium sorbate and sodium bisulfite as preservatives and xanthan gum.	528
1192	potassium sorbate	338
1193	contains sodium bisulfite as preservatives	426
1194	and xanthan gum.	265
1195	blé torréfié	204
1196	sucre Demerara	1
1197	dioxyde de carbone	529
1198	houblon	530
1199	levure.	294
1200	Crust: Wheat  Flour	131
1201	Olive Oil	6
1202	Malted Flour. Toppings: Tomato Sauce Imported Italian Tomatoes	386
1203	Basil	48
1204	Low Moisture Mozzarella Cheese Pasteurized Whole Milk	531
1205	Cheese Cultures	532
1206	Enzymes	192
1207	Cooked Italian Sausage Pork	533
1208	Flavorings	196
1209	Uncured Pepperoni with no nitrate or nitrate added Pork	534
1210	Natural Flavoring	316
1211	Dehydrated Garlic	4
1212	Oleoresin Paprika	55
1213	Lactic Acid Starter Culture	535
1214	Roasted Red Peppers	195
1215	Roasted Yellow Peppers	536
1216	Roasted Green Peppers	195
1217	Roasted Onions	9
1218	Romano Cheese Pasteurized Cow's Milk	537
1219	Enzymes Parmesan Cheese Pasteurized Cultured Milk	405
1220	Salt Parsley	22
1221	Porc d’origine britannique élaboré avec 120 g de porc cru pour 100 g de jambon rôti au miel; Sucre; Miel 2%; Sels de salaison Sel	534
1222	Conservateur: Nitrite de sodium; Sirop de sucre caramélisé.	538
1223	Palm and coconut fat	539
1224	chocolate sugar	170
1225	cocoa liquor	118
1226	soya lecithin emulsifier	185
1227	sweet lupin flour	540
1228	egg	14
1229	natur	210
1230	contains less than 2% of onion	9
1231	parsley	22
1232	hydrolyzed soy and corn protein	267
1233	hydrolyzed torula and brewer's yeast protein	209
1234	acetic acid	480
1235	monosodium glutamate	541
1236	food starch-modified	139
1237	sodium hexametaphosphate	194
1238	potassium sorbate to preserve freshness	338
1239	guar gum	475
1240	carrageenan yellow 5 & 6. dehydrated.	206
1241	Peanut oil	542
1242	tbhq and citric acid added to protect flavor	543
1243	dimethylpolysiloxane	358
1244	an anti-foaming agent added.	358
1245	Energy 8400kJ/2000kcal Fat 70g Saturates 20g Sugars 90g Salt 6g biscottes sans gluten avec des dattes	159
1246	des noix et des graines de tournesol - élaborées sans blé INGRÉDIENTS Farine de riz • Dattes hachées 21 % • Fécule de maïs • Amidon de tapioca • Farine de pois chiches • Noix concassées • 7% • Graines de tournesol 6% • Sucre • Poudre à lever : Bicarbonate de soude	271
1247	E450 • Sirop de sucre • Huile de tournesol • Sel • Stabilisant : Gomme xanthane. Pour les allergènes	310
1248	: voir les ingrédients indiqués en gras. Ne convients pas aux personnes allergiques aux arachides et aux : autres fruits à coque en raison des méthodes de fabrication. Nos produits IMade Withoutl sont spécialement conçus pour notre clientèle suivant un régime alimentaire particulier et sont tous élaborés dans des environnements contrôlés. Vous avez ainsi l'assurance de pouvoir les savourer sanç danger. CONSERVATION A consommer de préférence avant le : voir sur le dessous de l'emballage. A conserver de préférence dans un endroit frais et sec. Une fois ouvert	137
1249	conserver dans un récipient hermétique. glutenvriie crackers met dadels	544
1250	walnoten en zonnebloempitten - gemaakt zonder tarwe INGREDIÉNTEN Rijstmeel • gehakte dadels 21 % • maïszetmeel • tapiocazetmeel • kikkererwtenmeel • i gehakte walnoten 7% • zonnebloempitten 6% • suiker • rijsmiddel: natriumbicarbonaat	545
1251	E450 • melasse • zonnebloemolie • zout • stabilisator: xanthaangom. Voor allergenen	310
1252	zie de vetgedrukte ingrediënten. Niet geschikt voor mensen met een pinda- of andere notenallergie vanwege de productiemethoden. Al onze 'Made Withoutl-producten zijn zorgvuldig afgestemd op klanten met speciale dieeteisen. Ze worden bereid in een speciaal gecontroleerde omgeving; u kunt er dus zeker van zijn dat u er veilig van kunt genieten. BEWAARADVIES Ten minste houdbaar tot: zie onderkant verpakking. Bij voorkeur koel en droog bewaren. Eenmaal geopend	173
1253	bewaren in een luchtdichte verpakking.	431
1254	biscuits sablés au beurre enrobés de chocolat au lait INGRÉDIENTS Chocolat au lait 32% Sucre • Beurre de cacao • Lait en poudre entier • Masse de cacao • Lactosérum en poudre Lait • Lait en poudre écrémé • Émulsifiant : Lécithine de soja • Farine de blé contient Gluten avec Farine de blé	131
1255	Thiamine • Beurre Lait 22% • Sucre • Fécule de maïs • Sel • Arôme. Chocolat au lait contient cacao 28% minimum	247
1256	matière sèche de lait Pour les allergènes	7
1257	voir les ingrédients indiqués en gras. Ne convient 16% minimum. pas aux personnes allergiques aux arachides et aux fruits à coque en raison des : méthodes de fabrication. ÇONSERVATION À consommer de préférence avant le : voir sur le côté de l'emballage. A conserver de préférencp dans un endroit frais et sec. Une fois ouvert	173
1258	conserver dans : un récipient hermétique. Elaboré au Royaume-Uni. Weense boterkoekjes gedoopt in melkchocolade INGREDIÉNTEN Melkchocolade 32% suiker • cacaoboter • volle melkpoeder • i cacaomassa • weipoeder melk • magere melkpoeder • emulgator: sojalecithine • tarwebloem bevat gluten met tarwebloem	461
1259	calciumcarbonaat	328
1260	ijzer	251
1261	thiamine • boter melk 22% • suiker • maïszetmeel • zout • aroma. Melkchocolade bevat ten minste 28% cacaobestanddelen en ten minste 16% droge melkbestanddelen. allergenen	468
1262	zie de vetgedrukte ingrediënten. Niet geschikt voor mensen met een : pinda- of notenallergie vanwege de productiemethoden. BEWAARADVIES Ten minste houdbaar tot: zie zijkant verpakking. Bij voorkeur koel en droog bewaren. Eenmaal geopend	173
1263	bewaren in een luchtdichte verpakking. Geproduceerd in het Verenigd Koninkrijk.	431
1264	tato crisps With mint and salt marsh lamb Seasoning GREDIENTS Potatoes • Sunflower Oil • Rice Flour • Igar • Salt • Dried Yeast Extract • Dried Onions . Dried der Vinegar • Dried Garlic • Dried Mint Flavouring • itish Salt Marsh Lamb Seasoning Salt • Lamb Fat • semary Extract • Ground Black Pepper • Acidity Citric Acid • Colour: Paprika Extract. NFORMATION This product is sold by weight. }ettling of the contents may occur.	34
1265	Farine de riz • Fécule de maïs • Amidon de tapioca • Farine de pois chiches • Abricots déshydratés contiennent Conservateur : E220 Sulfites 8% • Dattes hachées 8% • Graines de lin 6% • Graines de tournesol 6% • Sucre • Noix de cajou 4% • Poudre à lever : Bicarbonate de soude	138
1266	E450 • Sirop de sucre • Huile de tournesol • Sel • Romarin déshydraté • Stabilisant : Gomme xanthane.	546
1267	whole soya flour	547
1268	caramel sugar syrup	1
1269	sunflower lecithin	185
1270	invertase	548
1271	soya bean oil	243
1272	arti	549
1273	low fat cocoa	118
1274	vanilla extract.	186
1275	hazelnut flavor	300
1276	coffee and other natural flavors	550
1277	cocoa mass dextrose	118
1278	artif	549
1279	partly hydrogenated vegetable fats palm	201
1280	shea	551
1281	rapeseed	90
1282	soy	142
1283	sunflower	151
1284	coconut; in varying proportions	552
1285	fat reduced cocoa powder	118
1286	whey powder from milk	193
1287	emulsifiers	292
1288	100% Soja-Protein-Isolat Soja	276
1289	Apple Juice 50% Coconut Water 15% ? Cucumber Purée 15% Apple Purée 14% ? Spinach Purée 3% ? Lemon Juice ? Spirulina Extract ? Antioxidant: Ascorbic Acid.	213
1290	Water Peach Juice 12%	499
1291	Sugar White Tea Infusion 3% White Tea Sugar . Acidity Regulator: Citric Acid Antioxidant: Ascorbic Acid. Suitable for vegetarians and vegans	1
1292	bourbon vanilla extract.	186
1293	full cream milk powder	7
1294	emulsifier lecithin soy	185
1295	dates	159
1296	natural vanilla flavor	186
1297	and sea salt.	148
1298	Grapefruit juice water	553
1299	grapefruit juice concentrate.	553
1300	Glucose fructose syrup	554
1301	apricots dried passed	555
1302	raising agents: disodium diphosphate	556
1303	sodium hydrogen carbonate	24
1304	potassium carbonate; pure butterfat	557
1305	lacto	295
1306	spices raising agents; disodium diphosphate	556
1307	potassium carbonate; caramel sugar syrup	452
1308	potato starch	519
1309	butterfat	393
1310	edible gelatine	459
1311	emulsifier; soya lecithins.	185
1312	légumes 38% jus de tomates à base de concentré	240
1313	pomme de terre	279
1314	oignon	9
1315	poireau	558
1316	potiron 3%	559
1317	céleri	27
1318	petit pois	560
1319	lait écrémé reconstitué	472
1320	amidon transformé de maïs	561
1321	beurre de cuisine	2
1322	vitamine A bêta-carotène	562
1323	beef braising steak	33
1324	sulfur dioxide as a preservative to promote color retention	306
1325	Chips dehydrated potato	279
1326	soluble corn fiber	563
1327	pea protein isolate	564
1328	inulin	418
1329	seasoning sugar	170
1330	tomato powder	240
1331	paprika color	55
1332	citric acid and sunflower oil.	565
1333	rich flour	131
1334	seasoning whey	193
1335	nonfat dry milk	472
1336	sour cream cultured cream	473
1337	nonfat milk	472
1338	buttermilk	72
1339	y	431
1340	Crisps wheat flour	131
1341	pea fiber	566
1342	cinnamon powder	15
1343	coating sugar	170
1344	skim dry milk solids	7
1345	salt and natural flavor.	567
1346	Crisps rice flour	138
1347	natural & artificial marshmallow flavor	568
1348	palm kernel oil cocoa powder	118
1349	skim milk powder	445
1350	soy lecithin and natural vanilla f	394
1351	chocolate cocoa liquor	118
1352	caramelized sugar syrup	1
1353	wheat gluten	326
1354	potassium carbonate	569
1355	ammonium bicarbonate	141
1356	pyrophosphates	570
1357	agar-agar	342
1358	Reduced fat milk	7
1359	cocoa processed with alkali	571
1360	carrageenan	206
1361	artificial flavors	196
1362	vitamin a palmitate and vitamin d3 added.	572
1363	tomato puree tomato paste	240
1364	assorted chiles and peppers	195
1365	apple cider vinegar	480
1366	distilled vinegar.	480
1367	tomato concentrate	240
1368	red pepper and spices.	195
1369	jalapenos	195
1370	Crushed wheat	143
1371	soy flour whole wheat flour. wheat flour	131
1372	maltitol syrup	398
1373	bran	573
1374	oatmeal	78
1375	multigrains	574
1376	rye chops	217
1377	malted barley	287
1378	gluten	326
1379	eggs.	14
1380	Tomato	240
1381	red pepper	75
1382	jalapeno pepper	195
1383	special spices.	575
1384	cream	473
1385	eggs	3
1386	dark chocolate sugar	170
1387	milkfat	393
1388	vanilla extract	21
1389	enriched wheat flour wheat flour	131
1390	riboflav	248
1391	dextrose.	315
1392	vegetable fats palm	201
1393	defatted cocoa powder	118
1394	stabilizer sorbitan tristearate emulsifier soy lecithin.	576
1395	vegetable oils palm	201
1396	modified starch	139
1397	s	1
1398	Pure maple syrup.	170
1399	cane sugar syrup	170
1400	blueberry flavor with other natural flavors	411
1401	modified corn starch and citric acid.	577
1402	light brown sugar	170
1403	natural flavorings	316
1404	vegetable gum	578
1405	celery seed.	579
1406	Pure maple syrup	170
1407	Pure organic maple syrup.	102
1408	iron ferrous lactate	251
1409	folic acid.	252
1410	iron ferrous lactate. thiamin mononitrate	251
1411	anhydrous milk fat	2
1412	soy lecithin emulsifier	185
1413	nougat invert sugar	471
1414	artificial vanilla flavor	186
1415	salted butter sweet cream	2
1416	ev	14
1417	nougat invertase salted butter sweet cream	2
1418	evaporated milk milk	7
1419	dipotassium phosphate & carrageenan stabilizers	580
1420	vitamin d3	581
1421	white coating sugar	170
1422	partially hydrogenated palm kernel oil	286
1423	monoglycerides	292
1424	artificial color titanium dioxide	369
1425	ar	582
1426	nonpareils sugar	1
1427	cornstar	263
1428	pretzels enriched wheat flour	131
1429	vegetable oil may contain one or more of the following: corn	307
1430	canola	187
1431	cottonseed	583
1432	sodium bicarbo	24
1433	Mint cream sugar	170
1434	tapioca starch modified	139
1435	dried egg whites	584
1436	citric acid peppermint oil	200
1437	and vanilla	20
1438	anhy	585
1439	Coconut dough invert sugar	170
1440	desiccated coconut	68
1441	pure vanilla extract	186
1442	artificial coconut flavor. salt	140
1443	sodium metabisulfate preservative	426
1444	caramel corn syrup	344
1445	dipotassium phosphate &	194
1446	Peanut butter center peanut butter dry roasted peanuts	137
1447	hydrogenated cottonseed and rapeseed oil	26
1448	cocoa butt	118
1449	Confectionery coating sugar	1
1450	vegetable oil palm kernel and hydrogenated palm	201
1451	sorbitan monostearate	586
1452	polysorbate 60	587
1453	pretzel enriched wheat flour wheat flour	131
1454	niacin reduced i	250
1455	vanillin artificial flavoring	186
1456	mini pretzel enriched wheat flour wheat flo	131
1457	vegetable oil palm kernel and hydrogenated palm. whey powder milk	201
1458	confectioner's	1
1459	cookie unbleached enriched flour wheat flou	131
1460	vegetable oil palm kernel	286
1461	hydrogenated palm and palm kernel	201
1462	m whole milk solids	7
1463	nonpa	588
1464	confectioner's glaze	289
1465	coloring includes red #3	428
1466	blue #1	375
1467	red #3	428
1468	anhydrous milk fat.	2
1469	cocoa nutter	123
1470	vanila	186
1471	Caramel corn corn syrup solids	344
1472	brown sugar	13
1473	popcorn	589
1474	butter cream	2
1475	beta carotene color	590
1476	chocolate flavored coating sugar	170
1477	co	135
1478	dry whey milk	193
1479	artificial flav	316
1480	Caramel corn brown sugar	170
1481	cane sugar	170
1482	butter pasteurized sweet cream {milk}	2
1483	cheese corn popcorn	589
1484	cheddar cheese pasteurized milk	7
1485	cheese culture	532
1486	sa	346
1487	sorbitan monosterate	591
1488	chocolate sandwich cookie sugar	1
1489	enriched flour wheat flour	131
1490	whole milk solids	7
1491	reduced mineral whey	193
1492	monoglyce	592
1493	soy lecithin emulsifie	185
1494	pretzel enriched wheat flour	131
1495	vegetable oil may contain corn	307
1496	artificial color	593
1497	so	594
1498	graham cracker whole wheat flour	283
1499	thiamin mononitrate vitamin b1	247
1500	riboflavin vitamin b2	248
1501	folic	252
1502	whipping cream	100
1503	butter	2
1504	egg albumen	584
1505	roasted in sunflower oil	147
1506	vitamin	494
1507	pecans roasted in peanut and/or cottonseed oil	49
1508	dipotassium phosphate & carrageenan stabili	206
1509	dipotassium phosphate & carrageenan {stabili	206
1510	thiamin mononitrate {vitamin b}	247
1511	riboflavin {vitamin b2}	248
1512	folic a	252
1513	pretzels enriched wheat flour wheat flour	131
1514	f	231
1515	Red coating sugar	1
1516	vegetable oil palm kernel and hydrogenated palm kernel oil	201
1517	nonfat dry milk solids	7
1518	artificial color red lake #40	416
1519	Yogurt coating sugar	170
1520	palm kernel oil and palm oil	201
1521	reduced mineral whey powder	193
1522	titanium dioxide	369
1523	yogurt powder cultured whey and nonfat milk soy lecithin an emulsifier	109
1524	salt and vanilla and pretzels enriched wheat flour	595
1525	soy lecithin an emulsfier	185
1526	and pretzels enriched wheat flour	131
1527	flour	8
1528	and artificial falvor vanillin and peanuts.	186
1529	malted milk balls corn syrup	596
1530	malt syrup	176
1531	coc	118
1532	raisins usa	233
1533	confectioner's polish modified corn starch	263
1534	sorbic acid	401
1535	confectioner's glaze.	289
1536	gum arabic corn syrup	390
1537	and certified confectioners glaze.	597
1538	cocoa butter anhydrous butter oil	171
1539	sugar and certified confectioners glaze food grade lac resin.	598
1540	pie shell flour unenriched	131
1541	unbleached	131
1542	vegetable shortening partially hydrogenated soybean oil	599
1543	lemon flavor	382
1544	palm oil with tbhq for freshness	201
1545	leavening agent sodium bicarbonate	24
1546	thickeners gum arabic	390
1547	carboxymethyl cellulose	600
1548	artificial color caramel.	357
1549	dried potato flakes	279
1550	oat fibres	601
1551	dextrose maltodextrin	197
1552	anti caking agent silicon dioxide	309
1553	sodium diacetate	602
1554	humectant glycerol	603
1555	artificial flavours	196
1556	flavour enhancers monosodium glutamate	541
1557	disodium guanylate	541
1558	disodium inosinate	604
1559	artificial colour beta carotene.	478
1560	Small red beans	605
1561	bell peppers	195
1562	jalapeno peppers	195
1563	coriander	106
1564	oregano	42
1565	paprika.	195
1566	tapioca syrup	315
1567	pineapple juice from concentrate	497
1568	and artificial color blue 1.	375
1569	okra	606
1570	green bell peppers	195
1571	thyme and bay leaves.	607
1572	Raspberry puree	208
1573	guar	475
1574	Coconut cream	135
1575	dutch cocoa	571
1576	guar.	475
1577	Mixed berry puree	449
1578	raspberries	433
1579	lemon pulp	378
1580	natural lemon flavor.	29
1581	Mango puree	190
1582	Organic tomato puree	240
1583	organic diced tomatoes	19
1584	organic mushrooms	46
1585	organic garlic powder	4
1586	organic onion powder	9
1587	organic minced onion	9
1588	organic basil	48
1589	organic parsley	22
1590	organic oregano	42
1591	organic black pepper.	10
1592	vegetable oil and fat non-hydrogenated palm oil	201
1593	jam of mixed fruits invert sugar syrup	608
1594	sour cherry puree	371
1595	apricot puree	275
1596	gelling agent: pectin	337
1597	low fat cocoa powder	118
1598	gluco	315
1599	not hydrogenated vegetable fat and oil palm oil	201
1600	mixed fruit jam invert sugar syrup	220
1601	jelling agent: pectin	337
1602	acidifier: citric acid	200
1603	low fat cocoa powd	118
1604	non-hydrogenated vegetal fats and oils palm oil	201
1605	sugar cherry puree	371
1606	fat-reduced cocoa powder	118
1607	vegetal non-hydrogenated fats and oils palm oil	201
1608	semi-finished product in cocos 18% sugar	609
1609	non-hydrogenbated vegetal fat	610
1610	fat-reduced cocoa powder 16%	118
1611	aromas	196
1612	rice flour 5%	138
1613	rising age	294
1614	artificial colors red 40	416
1615	red 30	416
1616	titanium dioxide.	369
1617	wheat flour and salt.	611
1618	Vegetable fat palm	201
1619	chocolate 11% sugar	118
1620	butter fat	2
1621	emulsifiers: sunflower lecithins; lactose	185
1622	low-fat cocoa	118
1623	emulsifier: sunflower lecithins; powdered eggs	185
1624	table salt	148
1625	Cucumbers	122
1626	red bell pepper	84
1627	0.1% sodium benzoate preservative	454
1628	alum	612
1629	calcium chloride	340
1630	polysorbate 80	613
1631	and yellow 5.	403
1632	slat	148
1633	dehydrated onions	9
1634	prepared mustard water	95
1635	and polysorbate 80.	613
1636	Cucumber	122
1637	and maltol.	614
1638	sucralose splenda brand	399
1639	yellow 5 and maltol.	615
1640	propylene glycol	616
1641	potassium metabisulfite preservative	397
1642	mustard seeds	395
1643	onion flakes	9
1644	0.1% sodium benzoate preservatives	454
1645	celery seeds	617
1646	calcium chloride 0.1% sodium benzoate preservative	340
1647	Imported peppers water	195
1648	sodium bisulfite preservative	426
1649	Banana peppers	195
1650	Imported peppers	195
1651	and natural flavors.	210
1652	and turmeric.	280
1653	calcium cholride	340
1654	xathan gum	265
1655	garlic flakes	4
1656	extractives of chipotle chilies and other natural flavors	618
1657	and yellow 5	403
1658	calcium chloride firming agent	340
1659	and turmeric for color.	175
1660	and turmeric for color	175
1661	potassium chloride	619
1662	magnesium chloride	457
1663	texas pete hot sauce peppers	195
1664	and benzoate of soda to preserve freshness and flavor	354
1665	natural flavors polysorbate 80	613
1666	Roasted red bell peppers	195
1667	citric acid and calcium chloride.	620
1668	potassium sorbate preservative	338
1669	YELLOW 5.	403
1670	light cream milk	473
1671	coriander cumin fenugreek leaves	106
1672	cloves.	621
1673	Sugar and/or fructose	170
1674	fd&c yellow #5 and #6	622
1675	fd&c red #40 and less than 0.1% of sodium benzoate as preservative.	416
1676	Invert sugar caramel color	357
1677	Tumeric	175
1678	allspice	124
1679	fenugreek	232
1680	cumin	43
1681	nutmeg	37
1682	thyme	44
1683	and spices.	198
1684	Butter beans	228
1685	escallion	623
1686	pimento	536
1687	calcium bicarbonate to prevent caking and other spices.	624
1688	and other spices.	575
1689	red pepper garlic	195
1690	hot peppers	195
1691	Pork snouts	534
1692	pork tongues	534
1693	pork	534
1694	pork livers	625
1695	sodium lactate	295
1696	sodium diacetate.	602
1697	Mechanically separated chicken pork	626
1698	bacon cured with; water	627
1699	sodium erythorbate	363
1700	sodium nitrate. wheat flour	628
1701	flavoring	407
1702	sodium benzoate	354
1703	fd&c red #40	416
1704	fd&c blue#1	375
1705	fd&c blue #1.	375
1706	aspartame	549
1707	fd&c red #40 and fd&c blue #1.	629
1708	beef stock flavor	630
1709	and less than 2% silicone dioxide to prevent caking.	631
1710	lemon peel.	317
1711	Orange juice water	5
1712	soy beans	256
1713	and sodium benzoate added as preservative	354
1714	spices and color	632
1715	sesame seed	153
1716	sesame seed oil	112
1717	salted mirin water	633
1718	sugar.	170
1719	lemon peel..	317
1720	artificial flavor.	407
1721	orange pieces orange	103
1722	vegetable oil coconut	135
1723	cream wheat flour	131
1724	leavening ammonium hydrogen carbonate	634
1725	sodium bicarbonate potassium carbonate. artificial flavor	24
1726	barley malt powder.	635
1727	chocolate vegetable oil palm	201
1728	skim milk yogurt	109
1729	strawberry pieces emulsifier soya lecithin	185
1730	cream cheese	30
1731	glucose fructose syrup from wheat	1
1732	milk protein	291
1733	leavening sodium bicarbonate	24
1734	ammonium hydrogen carbonate	634
1735	barley malt powder	635
1736	caramelized sugar.	1
1737	milk chocolate	461
1738	vegetable oil palm	201
1739	condensed milk	523
1740	emulsifier soya lecithin	185
1741	Dark sweet chocolate sugar	1
1742	natural raspberry flavor	636
1743	soya lecithin emu	185
1744	artificial flavors.	637
1745	caramel paste sugar	1
1746	sal	148
1747	sweetened condensed milk	523
1748	natural and artificial fla	316
1749	soya lecith	638
1750	crisp rice wheat	143
1751	. milkfat	639
1752	glucose fru	315
1753	coconut powder coconut	68
1754	sodium caseinate	640
1755	natural coconut flavor	641
1756	Sugars	1
1757	caramel pieces sugar	1
1758	soya lecithin	470
1759	natural and artificial flavors.	196
1760	Caramel tapioca syrup	642
1761	sweetened condensed skim milk	523
1762	heavy cream	52
1763	cocoa nibs	118
1764	vanilla seeds	20
1765	pal kernel	286
1766	artificial flavo	643
1767	citrus pieces sugar	1
1768	pineapple fibers	644
1769	sodium alginate	645
1770	dicalcium phosphate	646
1771	tripotassic citrate	647
1772	color added	648
1773	White chocolate sugar	1
1774	soya lecithin emulsifie	185
1775	coco butter	171
1776	orange oil	649
1777	natural an	650
1778	glucose syrup from wheat	176
1779	soy a lecithin emulsifier	185
1780	malt powder	204
1781	low fat cocoa powder processed with alkali	118
1782	ammonium hydr	462
1783	chocolate condensed milk	651
1784	ammoniu	652
1785	cocoa powder proc	118
1786	demerara sugar	170
1787	bourbon vanilla beans.	20
1788	pineapple pulp	63
1789	thickening agents: sodium alginate	645
1790	calcium monophosphate	381
1791	artificial flavoring	653
1792	natural orange flavoring.	654
1793	caramel paste sugar. cocoa butter	171
1794	v	494
1795	peppermint pieces sugar	1
1796	beet juice concentrate	409
1797	peppermint o	458
1798	White chocolate. sugar	1
1799	a peppermint	458
1800	vanillin artificial flavoringj	186
1801	soya lecithin emulsfier	185
1802	cocoa butte	171
1803	milk skim milk	7
1804	peppermint oil	458
1805	cocoa powder pro	118
1806	barley malt pow	635
1807	leavening potassium carbonate	655
1808	hydrogen carbonate.	656
1809	high fructose	344
1810	cara	452
1811	cocoa butter milk	171
1812	barley malt p	635
1813	su	1
1814	vegetable oil coconut palm kernel	135
1815	soya lacithin emulsifier	185
1816	artific	643
1817	kernel	134
1818	peppermint	458
1819	turmeric color	175
1820	vanilla seed	20
1821	salted butter	2
1822	Caramel sweetened condensed skim milk	657
1823	natural a	650
1824	lac	295
1825	crisp rice rice	64
1826	palm kerner	286
1827	skim milk. condensed milk	472
1828	soya lecithin emulsifier milkfat	185
1829	va	562
1830	Milk chocolate sugar milk	1
1831	milk soya lecithin emulsifier	185
1832	soya lecithin emulcifier	185
1833	natural and artif	549
1834	blackberry pieces blackberry juice concentrate	658
1835	blackberry puree	658
1836	rice meal	202
1837	citrus fiber	659
1838	acai powder	264
1839	soya lecithin emulsifier.	185
1840	pretzel pieces corn starch	263
1841	cellulose gum	600
1842	cocoa butter chocolate	171
1843	toffee pieces sugar	1
1844	shellac.	502
1845	mint pieces sugar	1
1846	citr	200
1847	soya lecit	394
1848	chocolate soya lecithin emulsifier	185
1849	vanillin artificial flavouring	186
1850	sugar chocolate	1
1851	a	660
1852	sugar cocoa butter	171
1853	palm kemel	286
1854	soya lecithi	394
1855	barely malt powder	635
1856	vanilla artificial flavoring	20
1857	barley malt powd	635
1858	chocolate soy lecithin emulsifier	185
1859	natural and artificial flavor.	316
1860	caramelized sugar	1
1861	crumbled wafer wheat flour	131
1862	artificial flavors. Milk chocolate contains: Cocoa solids 30% min.	661
1863	Milk Solids 20% min.	7
1864	almond and hazelnut praline almonds	60
1865	coffee	550
1866	natural mint flavor	458
1867	vanillin artificial flavor.	186
1868	fat reduced cocoa	118
1869	milkat	640
1870	popcorn pieces corn	134
1871	glucose from wheat	662
1872	rapeseed lecithin emulsifier	185
1873	sunflower lecithi	185
1874	vanilla seeds.	20
1875	artifici	643
1876	White chocolate  sugar	1
1877	soya leci	394
1878	pomegranate pieces apple concentrate	213
1879	pomegranate juice concentrate	406
1880	vani	186
1881	cherry juice	500
1882	natural and art	663
1883	fat reduced cocoa powder processed with alkali	96
1884	pretzel pieces potato flour	664
1885	leavening sodium pyrophosphate	518
1886	potato	279
1887	lychee pieces sugar	1
1888	lychee juice	665
1889	peppermint oi	458
1890	soya lecithinemulsifier	185
1891	pumpkin powder pumpkin	559
1892	vanillin artificial flavoring. cookie pieces tapioca starch	186
1893	cocoa powder p	118
1894	mango powder	190
1895	lemon juice concetrate	200
1896	rose water.	666
1897	natural and artificial flavors salt.	148
1898	wafer pieces potato starch	519
1899	chickpea flour	667
1900	butterfat.	668
1901	barle	255
1902	palm kermit	286
1903	art	549
1904	vanillin artificial flavoring}	186
1905	vegetables oil coconut	135
1906	barl	255
1907	Black beans	669
1908	Dehydrated onion and garlic	670
1909	black pepper and sea salt	10
1910	100 % extra virgin olive 0% soy lecithin	6
1911	and propellant. no chlorofluorocarbons	671
1912	rice starch	138
1913	natural and artificial flavors milk	196
1914	magnesium stearate	672
1915	carmine	673
1916	beta-carotene.	590
1917	butterroil	674
1918	vanillin: an artificial flavor	186
1919	sodium bicarbonate as leavening agent	24
1920	fructose	344
1921	dried grape juice	150
1922	dried lychee	675
1923	shellac and carnauba wax as glazing agents	676
1924	surcalose	399
1925	red 40.	677
1926	dextrin	678
1927	dried strawberry	448
1928	beet-red	174
1929	dried lemon juice	200
1930	yellow 6.	403
1931	dried acerola extract	650
1932	dried green apple	679
1933	Orange: sugar	1
1934	beta carotene. strawberry: sugar	478
1935	natura	680
1936	isomalt	681
1937	dried passionfruit	682
1938	gun arabic	683
1939	dried lychee carnauba wax	415
1940	dried banana	136
1941	dried green apple carnauba wax	415
1942	magnesium	457
1943	carnauba mix.	415
1944	dried strawberries	448
1945	Fruit adventure: sugar	1
1946	dried lemon juice powder	684
1947	beta carotene.	590
1948	carnuba wax.	415
1949	Wintergreen 3 pks: sugar	1
1950	blue 1. orange 6 pks: sugar	1
1951	gum ara	390
1952	powder	685
1953	palm iol	201
1954	sodium	594
1955	butteroil	674
1956	sodium bi	594
1957	lowfat cocoa powder lecithin as emulsifier soy	185
1958	vnillin: an artificial flavor.	186
1959	wheat flaour	131
1960	lecithin as emulsifier soy sodium bi	185
1961	lowfat powder	686
1962	sodium bicarbona	24
1963	Ingredients- milk chocolate sugar	1
1964	butterfoil	2
1965	lecithin as emulsifier soy. vanullin: an rttificial flavor	185
1966	pal oil	201
1967	low fat leavening agent	17
1968	lecithin as emulsifier soy sodium bicarbonate as leavening agent	258
1969	wheatflour	131
1970	lowfatcocoapowder	96
1971	sodium bicar	24
1972	vanillin: artificial flavor	186
1973	Dry coconut	68
1974	vegetable oils palm and sheanut	687
1975	Vegetable oils palm and sheanut. dry coconut	135
1976	sodium bicarbonate as leavening agent.	24
1977	sheanut and sunflower	688
1978	n	689
1979	Ferrero rondnoir - semisweet chocolate sugar	690
1980	vegetable oils palm and sunflower	691
1981	whey proteins milk	387
1982	sodium bicarbonate and ammonium bicarbonate as leavening agents	24
1983	vanillin: an artificial flavor. ferrero rocher - milk chocolate sugar	186
1984	vanillin: an artificial flavor. confetteria raffaello - vegetable oils palm and sunflower	186
1985	Semisweet chocolate sugar	1
1986	vanillin: as artificial flavor	186
1987	vegetables oils palm and sunflower	691
1988	coca butter	171
1989	wheypowdermilk	692
1990	mi	7
1991	lecit	185
1992	Ingredients: semisweet chocolate sugar. cocoa mass	118
1993	Rondnoir ingredients: semisweet chocolate sugar	1
1994	milk ch	640
1995	sugar vegetable oils palm and sunflower	693
1996	milk chocolate suga	1
1997	sheanut	694
1998	natu	695
1999	Hazelnut spread with cocoa sugar	300
2000	malt extract powder	391
2001	an artificial flavor	637
2002	tara gum a	696
2003	palm o	201
2004	Nutella ingredients: sugar	170
2005	reduced minerals whey milk	697
2006	Hazelnut spread: sugar	170
2007	coca	585
2008	sodium bicarbonate and disodium diphosphate as leavening agents	24
2009	baker's yeast.	698
2010	Thailand coconuts	68
2011	cane sugar and salt	170
2012	chicken dices chicken meat	57
2013	egg noodle durum semolina flour wheat	451
2014	iron ferrous sulfate	251
2015	chicken broth	41
2016	dehydrated onion	699
2017	beta carotene color.	478
2018	Sun dried roma tomatoes	700
2019	pure olive oil	6
2020	sulfur dioxide for color retention.	426
2021	Tomato puree	487
2022	fresh onions	9
2023	roasted garlic	4
2024	garlic puree	4
2025	red wine vinegar	110
2026	natural roasted garlic flavor	4
2027	Superfino arborio rice	701
2028	mushroom	702
2029	autolyzed yeast	209
2030	soy sauce soybeans	277
2031	chablis wine	703
2032	whey milk protein	387
2033	chicken fat	704
2034	chervil	705
2035	natural flavor nonhydrolyzed fermented yeast	209
2036	celery extract.	706
2037	organic banana.	136
2038	organic figs	707
2039	pepper mint oil.	458
2040	organic puffed quinoa	167
2041	salt sodium benzoate less than 1/10 of 1% as a food preservative lard	140
2042	monosodium glutamate.	708
2043	Beef	33
2044	gluten free soy sauce water	5
2045	chili garlic sauce salted chili peppers chili peppers	709
2046	rice vinegar	480
2047	lime chili seasoning cane sugar	1
2048	natural f	421
2049	organic soybeans	277
2050	chili garlic sauce salted chili pepperschili peppers	709
2051	contains 2% or less of chili pepper	710
2052	salt paprika	148
2053	natural flavor.	316
2054	Porx	711
2055	browin sugar	13
2056	sugar gluten free soy sauce  water	1
2057	may contains rice	64
2058	chili pepper	710
2059	srracha powder spice including chili	195
2060	chili powder red pepper powder	195
2061	korean inspired seasoning {sugar	1
2062	toasted sesame seeds	266
2063	what free soy sauce powder soy sauce fermented soybeans and salt	39
2064	and salt	148
2065	black peeper	12
2066	salt}	148
2067	contains 2% or less of salt	140
2068	chili powder red pepper	195
2069	sesame oil.	112
2070	may contain rice	64
2071	contains 2% or less: soybean oil	243
2072	rice wine	712
2073	acetic acid 4% acidity.	73
2074	Ingredients: parmesan cheese made from pasteurized part-skim cow's milk	62
2075	casein	640
2076	protein	713
2077	partially hydrogenated soybean oil	599
2078	disodium phosphate	194
2079	trisodium phosphate	714
2080	sodium aluminum phosphate	715
2081	calcium propionate and powdered cellulose.	716
2082	Tomato concentrate water	717
2083	olive oil.	6
2084	Fresh vine-ripened tomatoes	240
2085	carrot puree	119
2086	black pepper and spice.	12
2087	Organic tomato puree water	487
2088	organic tomato paste	83
2089	organic soybean oil	243
2090	salt organic onion organic garlic powder	148
2091	organic garlic.	4
2092	Filling: milk	7
2093	cheddar cheese cultured milk	32
2094	microbial rennet annotta color	718
2095	broccoli	116
2096	half and half milk	473
2097	seasoning salt	148
2098	dehydrated garlic. pastry: enriched wheat flour wheat flour	4
2099	nia	466
2100	lard colored with annatto pork fat	719
2101	bha	720
2102	bht	721
2103	monoglyceride citrate	200
2230	Almonds. cashews	60
2104	annatto extract in vegetable oil	722
2105	autolyzed yeast extract	209
2106	silicon dioxide added to prevent caking	309
2107	na	594
2108	Beef blood	723
2109	pork fat	719
2110	rice water	724
2111	seasoning fresh peppers	725
2112	sweet pepper	536
2113	bread enriched wheat flour	131
2114	niacin iron	726
2115	fol	727
2116	Glucose syrup derived from wheat	176
2117	brazil nuts 18%	728
2118	sweetened condensed milk from whole milk 18%	1
2119	vegetable oil sustainable palm oil	201
2120	butter 3%	2
2121	emulsifier e471	729
2122	sweetened condensed milk from whole milk 22%	405
2123	Enriched bleached flour wheat flour	131
2124	yellow corn flour	165
2125	turmeric.	175
2126	Enriched bleached wheat flour wheat flour	131
2127	baking soda.	258
2128	Stone ground white corn meal	730
2129	Enriched white corn meal white corn meal	149
2130	Stone ground yellow corn meal	730
2131	Soft wheat flour	131
2132	durum wheat semolina. filling: butternut squash	451
2133	breadcrumbs	242
2134	natural yeast	294
2135	amaretti biscuits sugar	1
2136	apricot kernels	731
2137	leavening: sodium hydrogen carbonate	24
2138	Salted roasted peanuts	173
2139	pecans and brazil nuts.	146
2140	Pecans.	732
2141	bht 0.02% added to preserve freshness.	721
2142	Walnuts.	733
2143	bht 0.02% in corn oil added to preserve freshness	721
2144	Vanilla granola rolled oats	78
2145	wheat flakes	143
2146	whole oat flour	274
2147	mixed tocopherols to preserve freshness	154
2148	rice extract	734
2149	distilled monoglycerides	592
2150	honey roasted peanuts dry roasted peanuts	173
2151	sugar cane syrup	170
2152	dehydrated honey	36
2153	yogurt flavored raisins yogurt coating sugar partially hydrogenated palm kernel oil	1
2154	yogurt powder cultured whey protein concentrate	387
2155	cultured skim milk	735
2156	and yogurt culture	736
2157	soy lecithin {an emulsifier}	185
2158	infused dried cranberries sliced cranberries	737
2159	apple cinnamon glazed walnuts walnuts	58
2160	dried apple pieces apples	738
2161	sodium sulfate {a preservative}	306
2162	dusted with: maltodextrin	197
2163	mannitol	739
2164	modified cellulose.	740
2165	artificial flavor salt	148
2166	cocktail peanuts peanuts	173
2167	peanut and/or cottonseed oil	741
2168	yogurt flavored raisins yogurt coating sugar	1
2169	yogurt powder {cultured whey protein concentrate	387
2170	and yogurt culture}	736
2171	glazed walnuts walnuts	733
2172	soy lecithin an emulisifier	185
2173	infused dried blueberry flavored cranberries sliced cranberries	411
2174	blueberry juice	400
2175	Sea salt caramel flavored glazed almonds lightly roasted almonds	60
2176	mocha roast almonds almonds	60
2177	spray dried coffee powder	550
2178	acesulfame potassium	742
2179	chocolate covered espresso beans dark confectioners coating sugar	1
2180	partially hydrogenated vegetable oil palm kernel	286
2181	roasted coffee beans	550
2182	dusted with:maltodextrin	197
2183	methylcellulose.	743
2184	puffed quinoa	167
2185	puffed spelt	302
2186	puffed khorasan wheat	744
2187	poppy seeds	745
2188	dried bananas	136
2189	pumpkin seed kernels	161
2190	vegetable oil safflower	181
2191	rosemary extract to preserve freshness.	89
2192	rosemary extract to preserve fresh	89
2193	soy lecithin an emulsifier.	185
2194	Glazed almonds almonds	60
2195	cinnamon roast almonds almonds	15
2196	modified fo	746
2197	bht 0.02% added tom preserve freshness.	747
2198	conola oil	90
2199	natural flavors soy	142
2200	sucralose.	399
2201	Almonds. sugar	60
2202	rosemary extract to preserve freshness	89
2203	clarified red raspberry juice concentrate	748
2204	strawberry powder	448
2205	natural flavors including raspberry	208
2206	Almonds.	160
2207	cottonseed oil	583
2208	hickory smoke seasoning salt	148
2209	natural hickory smoke flavor	749
2210	hydrolyzed soy protein	276
2211	trice flour	131
2212	ground vanilla beans and seeds	20
2213	seasoning maltodextrin	197
2214	and/or canola oil.	90
2215	seasoning dextrose	750
2216	jalapeno powder	195
2217	roast flavor maltodextrin	197
2218	autolyzed yeast extract modified food starch	209
2219	tricalculm phosphate	751
2220	modified food starch.	139
2221	Natural almonds.	60
2222	Cashews.	145
2223	Natural almonds	60
2224	sliced.	752
2225	Macadamia nuts.	753
2226	Blanched	754
2227	slivered almonds.	60
2228	tricalcium phosphate	751
2229	Ingredients: walnuts	733
2231	honey roasted p	755
2232	cocktail peanut	137
2233	Ingredients: walnuts sugar	1
2234	sacralose	756
2235	Cracker coated peanuts peanuts	173
2236	canola and/or safflower and/or sunflower oil	26
2237	tapioca flour	757
2238	organic dried cane syrup	170
2239	canola and/or safflower and/or su	26
2240	parsley powder	22
2241	mu	176
2242	vegetable oil cottonseed and/or canola oil. salt	148
2243	cinnamon spice	15
2244	maltodex-trin	197
2245	yeast extra	294
2246	spices chili pepper	195
2247	red chili	195
2248	cayenne pepper	69
2249	red bell pepper powder	195
2250	dried red pepper sauce aged red pepper	75
2251	natural flower.	758
2252	cocoa roast almonds almonds	60
2253	glazed pecans pecans	49
2254	dusting blend maltodextrin	197
2255	methylcellulose	743
2256	rosemary e	89
2257	spices chilli pepper	195
2258	red chili. cayenne pepper	195
2259	natural flavors. vegetable oil safflower	181
2260	Spanish peanuts.	173
2261	Virginia peanuts	173
2262	cayenne pepper sauce salt	148
2263	hot sauce powder maltodextrin	197
2264	vinegar solids	480
2265	paprika extract	759
2266	smoked paprika powder	55
2267	cayenne pepper powder	195
2268	rosemary	89
2269	honey powder	36
2270	salt. safflower and/or sunflower oil.	140
2271	hot sauce pepper	195
2272	parsley vegetable oil safflower	22
2273	yest extract	760
2274	chili peppers	709
2275	garlic salt	148
2276	white wine vinegar	480
2277	Garbanzo beans	222
2278	natural lemon flavor	382
2279	herbs and spices.	761
2280	salted butter 13% butterfat	2
2281	vegetable fat palm oil	201
2282	emulsifier: polyglycerol esters of fatty acids; flavoring	762
2283	colors: annatto	722
2284	curcumin	175
2285	raw can sugar	170
2286	invert sugar syrup suga	471
2287	raw cane sugar	170
2288	invert sugar syrup sug	1
2289	vegetable oils p oil	26
2290	emulsifier: polyglycerol esters of fatty acids	762
2291	flavoring colors annatto	722
2292	dark chocolate chips 14% sugar	1
2293	cocoa mass cocoa butter	118
2294	Flour wheat flour	131
2295	vegetable oils palm oil	201
2296	rapeseed oil	187
2297	emulsifier: e475	729
2298	flavouring	407
2299	colours: annatto	236
2300	dark chocolate chips 12% sugar	763
2301	emulsifier: soya lecit	185
2302	emulsifier: polyglycerol esters of fatty acids. flavoring. colors: annatto	762
2303	invert sugar syrup sugar syrup	1
2304	cane molasses	156
2305	mixed spice coriander	106
2306	sweetened dried cranberries 5% cranberries	737
2307	pasteuris	764
2308	emulsifier	292
2309	polyglycerol esters of fatty acids	762
2310	raisins 4% raisins	67
2311	sultanas 4% sultanas cotton seed oil	765
2312	nibbed almonds	60
2313	cranberry juice from concentrate	766
2314	organic hibiscus flower extract	767
2315	fruit and vegetable juice for color	768
2316	gum acacia	390
2317	glycerol ester of wood rosin	769
2318	phosphoric acid.	770
2319	apple juice from concentrate	322
2320	carrot juice from concentrate	119
2321	ascorbic acid vitamin c.	329
2322	wheat flour bleached	131
2323	cream cheese cultured cream and milk	30
2324	xanthan	265
2325	carob bean and guar gums	475
2326	shortening palm oil	201
2327	vegetable mono & diglycerides	729
2328	dehydra	771
2329	whole wheat flour	283
2330	margarine palm oil	201
2331	natural flavor milk	7
2332	vitamin a palmitate	562
2333	canola and/or palm oil	90
2334	sour cream cultured milk	25
2335	eggs dried	772
2336	molasses and caramel color	156
2337	apocarotenal color.	773
2338	strawberry filling water	774
2339	erythorbic acid	775
2340	calcium carrageenan	206
2341	fd&c red 40 & blue 1	776
2342	cocoa alkalized	118
2343	sour cream cream	25
2344	non-fat milk solids	777
2345	starch modified	778
2346	sodium citrate and natural culture	477
2347	chocolate chips sugar	1
2348	dipotassium phosphate	779
2349	modified tapioca starch	757
2350	cream carrageenan	206
2351	mono & diglycerides	729
2352	baking powder sodium acid pyrophosphate	780
2353	glucose solids	315
2354	cream cream	473
2355	enriched wehat flour wheat flour	131
2356	canola and/or	90
2357	vitamin a p	562
2358	while wheat flour	131
2359	sour cream cultured milk and cream	25
2360	white chocolate chips sugar	1
2361	chocolate curls sugar	1
2362	red 40 lake color	677
2363	natural vanilla extract	20
2364	carrageenam	206
2365	natural flavors water	5
2366	praline pecan grind sugar	1
2367	natural and artificial flavors water	196
2368	vitamin a palmitat	562
2369	natural and	781
2370	c	782
2371	cream filling water	5
2372	glucon	516
2373	carob bean and guar gum	783
2374	soy lecithin carotene color	185
2375	vitamin a palpitate	590
2376	enriched wheat flour what niacin	784
2377	c enzymes	785
2378	la bean gum	475
2379	cinnamon apocarotenal color.	15
2380	artificial color water	648
2381	fd&c yellow 5 & 6	786
2382	margarine	610
2383	sugar modified food starch	778
2384	salt glucono delta lactone	516
2385	methylhydroxypropylcellulose	743
2386	potassium sorbate and potassium benzoate preservatives	787
2387	fd&c yellow 5 and yellow 6	786
2388	ethyl alcohol	384
2389	fruit juice grape	150
2390	pear	788
2391	natural grain dextrin	678
2392	guar & xanthan gums	789
2393	powdered sugar dextrose	750
2394	vegetable shortening palm oil	201
2395	egg whites dried	244
2396	egg yolks dried	185
2397	vegetable shortening canola and/or palm oil	790
2398	oat fiber	601
2399	soy protein isolate	276
2400	sunflower/safflower oil	147
2401	gum gum acacia	390
2402	ammonium and calcium alginate.	791
2403	modified foods starch	778
2404	glucono delta lactone	516
2405	methylhydroxypropylcellulsoe	792
2406	potassium sorbate and potassium benzoate preservatives natural and artificial flavors fd&c yellow 5	793
2407	and yellow 6	794
2408	artificial colors eater	795
2409	glycerine	234
2410	glycerin guar & xanthan gums	789
2411	vegetables shortenning palm oil	201
2412	egg yolks fried	796
2413	cellulose fiber	740
2414	camola oil	90
2415	carob cream and guar gums	797
2416	citric canola and/or palm oil	200
2417	mango filling fructose	344
2418	passion fruit puree	798
2419	mixed berry filling sugar	1
2420	strawberry puree	448
2421	fd&c red 40 and blue 1	799
2422	wheat flou	131
2423	orange flavored filling water	5
2424	cream cheese pasteurized nonfat milk and cream	30
2425	whey protein concentrate	387
2426	carob bean	800
2427	and guar gums	475
2428	cultured non-fat dry	801
2429	potassium sorbate and potassi	338
2430	wat	5
2431	whole wh	802
2432	carob bean and and guar gums	205
2433	fruit fillings peaches	444
2434	lemons	200
2435	blueberries water	130
2436	lemon puree	18
2437	agar agar	342
2438	potassium sorbate and sodium benzoate preservatives	803
2439	soybean oil salt	148
2440	eggs 9fried	14
2441	xantahan gum	265
2442	locust bean fum	339
2443	cinnamom	15
2444	artificial color fd7c yellow 5 and blue 1	804
2445	sour cream culture	805
2446	cream cream milk	473
2447	carageenan	206
2448	graham crumb enriched flour wheat flour	131
2449	rib	806
2450	caramel spread milk	7
2451	applesauce apples	807
2452	Wild caught salmon	808
2453	seafood stuffing wheat flour	131
2454	imitation crab {fish protein	809
2455	wheat/corn/tapioca starch	139
2456	crab flavor	810
2457	natural crab extract	810
2458	and paprika}	55
2459	gre	811
2460	Flounder	812
2461	spinach artichoke seafood stuffing imitation crab fish protein	809
2462	spinach	79
2463	pasteurized milk and cream	813
2464	creamer water	5
2465	Tilapia	814
2466	crab mix crabmeat	815
2467	bleached wheat flour	131
2468	bread crumbs enriched flour {flour	816
2469	niacin a "b" vitamin	817
2470	ferrous sulfate	251
2471	thiamine mononitrate b1	468
2472	riboflavin b2	818
2473	folic acid}	819
2474	high fruct	344
2475	Cod. seafood mix imitation crab {fish protein	809
2476	creamer {water	473
2477	sodium tripolyphosphate to retain moisture	820
2478	fully cooked applewood smoked bacon cured with water	50
2479	sodium nitrite	367
2480	spice blend salt	148
2481	Imitation crab fish protein	821
2482	and paprika	195
2483	bread crumbs wheat flour	131
2484	creamer	473
2485	spices and garlic.	4
2486	Indian purple corn prepared with	822
2487	citric acid and hydrated lime to enhance flavor.	200
2488	Holy basil	823
2489	spearmint	824
2490	indian sarsaparilla	825
2491	licorice	826
2492	marshmallow flower	827
2493	malabar nut	828
2494	hyssop	829
2495	long pepper pippali	830
2496	oil	35
2497	vinegar powder ip maltodextrin	73
2498	white distilled vinegar	480
2499	evaporated cane sugar	170
2500	chili picante seasoning tomato	240
2501	chili pepper including jalapeno	195
2502	extractives of paprika	55
2503	sea salt and butter seasoning natural flavors	148
2504	extractives of annatto	722
2505	asiago ranch seasoning buttermilk	831
2506	natural disod	832
2507	vegetable oil may contain cottonseed	26
2508	corn sunflower or safflower oils	147
2509	red chili seasoning spice	195
2510	sunflower or safflower oils	833
2511	seasoning spices	834
2512	natural fla	835
2513	natural flav	835
2514	habanero chili seasoning maltodextrin	197
2515	green bell pepper	129
2516	jalapeno chili pepper	836
2517	habanero chili pepper	836
2518	and soy lecithin.	185
2519	soy lecithin.	185
2520	butter flavored corn oil corn oil	307
2521	beta carotene added for color	590
2522	natural butter flavor	2
2523	cheese blend whey	193
2524	reduced lactose whey	193
2525	salt disodium phosphate	148
2526	blue cheese cultured milk	837
2527	enzymes nonfat dry milk	801
2528	Blue popcorn	838
2529	high oleic sunflower oil	147
2530	inactive yeast	839
2531	dill	840
2532	dehydrated kale flakes	841
2533	Red popcorn	842
2534	alderwood smoked sea salt.	98
2535	white wine	384
2536	olive and soybean oils	6
2537	artificial and natural flavors	663
2538	calcium disodium edta retains product freshness	843
2539	annatto.	236
2540	vinegars white wine	480
2541	white distilled	5
2542	red wine and balsamic	420
2543	fruit juices orange	65
2544	tangerine and lemon	844
2545	oranges	845
2546	annatto	722
2547	citric and tartaric acids	846
2548	paprika red chili peppers.	195
2549	unbleached enriched wheat flour wheat flour	131
2550	vitamin c ascorbic acid as a dough conditioner	329
2551	enzyme	330
2552	sat	594
2553	white distilled vinegar.	480
2554	cocoa powder dutch process	118
2555	creamer coconut oil	135
2556	com syrup solids	596
2557	sodium caseionate	847
2558	dipotassum phosphate	848
2559	natural and artificial flavores	196
2560	fd&c red#3.	849
2561	guar gum.	475
2562	solids	850
2563	tea	851
2564	tri-calcium phosphate.	751
2565	non dairy creamer canola or coconut oil	135
2566	fd & c yellow #5	403
2567	f d & c blue #1.	852
2568	beet powder. fd & c red #40	853
2569	beta carotene	478
2570	fd & c red # 40.	677
2571	cornsyrup solids	750
2572	non dairy creamer coconut or canola oil	135
2573	whey instant coffee	550
2574	tricalcium phosphate.	751
2575	natural and artificial favor	316
2576	a preservative	854
2577	yellow #6	403
2578	peaches	444
2579	less than 1% of: citric acid	200
2580	sodium citrate. potassium sorbate maintains freshness	477
2581	aspartame acesulfame potassium	855
2582	less than 1% of: salt	140
2583	potassium sorbate to maintain freshness	338
2584	carrageenan.	206
2585	Pure water	5
2586	aloe vera juice aloe vera pulp	856
2587	calcium lactate	857
2588	sodium citric	200
2589	gellan gum	858
2590	stevia	859
2591	b-carotene	590
2592	pineapple flavor.	860
2593	white grape flavor.	861
2594	corn oil or coconut oil	307
2595	lime.	200
2596	corn oil or coconut oil or vegetable oil	668
2597	or vegetable or	35
2598	vegetable oil peanut and/or sunflower seed.	741
2599	sunflower and/or safflower oil; dextrose; nonfat milk; reduced protein whey milk; chocolate; contains 2% or less of: brown sugar; whey milk; mono and diglycerides; sodium bicarbonate; milk f	7
2600	SUGAR; CORN SYRUP; PARTIALLY HYDROGENATED PALM KERNEL OIL; WHEY MILK; COCOA; CONTAINS 2% OR LESS OF: MALTED MILK BARLEY MALT; WHEAT FLOUR; MILK; SALT; SODIUM BICARBONATE; RESINOUS GLAZE; sorbitan tristearate; SOY LECITHIN; SALT; NATURAL AND ARTIFICIAL FLAVORS; CALCIUM CARBONATE; TAPIOCA DEXTRIN.	862
2601	Milk chocolate sugar; cocoa butter; chocolate; nonfat milk; milk fat; lactose; salt; soy lecithin; vanillin	1
2602	Milk chocolate sugar; cocoa butter; chocolate; nonfat milk; milkfat; lactose; salt; soy lecithin; vanillin	1
2603	artificial flavor; sugar; palm oil; dairy butter milk; almonds roasted in cocoa butter and/or sunflower oil; contains 2% or less of: salt; ar	148
2604	Dextrose; sugar; corn syrup; partially hydrogenated palm kernel oil; whey milk; cocoa; malted milk barley malt; wheat flour; milk; salt; sodium bicarbonate; contains 2% or less of: tapioca dextrin; artificial color red 40 lake; blue1 lake; yellow 5 l	863
2605	vegetable oil cocoa butter	171
2606	Milk chocolate sugar; cocoa butter: chocolate; nonfat milk; milk fat; lactose; salt; soy lecithin; vanillin	1
2607	Self-rising enriched flour bleached wheat flour	131
2608	leavening sodium aluminum phosphate	864
2609	chgeddar cheese p	32
2610	unbleached wheat flour wheat flour	131
2611	cocoa and chocolate chips sugar	118
2612	soy lecithin added as an emulsifier and vanilla.	185
2613	white confectionery baking chips sugar	1
2614	english toffee sugar	1
2615	margarine liquid and partially hydrogenated soybean oil	243
2616	whey s	193
2617	dried cherries red tart cherries	865
2618	sugar and natural and artificial flavoring.	1
2619	Organic Grade A Pasteurized Milk	7
2620	Organic Pasteurized Cream	473
2621	Organic Nonfat Pasteurized Milk	7
2622	Organic Strawberries Organic Cane Sugar	1
2623	Organic Locust Bean Gum	339
2624	Organic Fruit & Vegetable Juice color	174
2625	Organic Cane Sugar	170
2626	Organic Corn Starch	866
2627	Live Active Cultures.	867
2628	Filling: cabbage	113
2629	chicken	57
2630	green onions	91
2631	expeller pressed vegetable oil soybean and/or canola	243
2632	organic whole wheat flour	283
2633	contains less than 2% of the following: salt	140
2634	expeller pressed sesame seed oil	112
2635	wrapper: water	5
2636	organic wheat flour	131
2637	fried in expeller pressed vegetable oil soybean and/or canola. sauce: water	243
2638	vermicelli green mung beans	868
2639	shiitake mushrooms shiitake mushrooms	869
2640	contains less than 2% of: green onions	870
2641	evaporated cane syrup	871
2642	vegetable oil soybean and/or canola. wrapper: water	872
2643	vegetable oil soybean and/or canola	872
2644	contains less than 2% of: soy lecithin	185
2645	salt. prefried in vegetable oil soybean and/or cottonseed.	148
2646	sauce: water	5
2647	dehydrated cane syrup	873
2648	red chili pepper contains salt	148
2649	garlic garlic juice	4
2650	phosphoric acid	770
2651	chili pepper flakes	195
2652	dehydrated red bell pepper	84
2653	sugar white & brown	170
2654	non-dairy creamer	874
2655	sodium steroyl lacrylate	875
2656	sodium calcium alginate	791
2657	caram	452
2658	lecithin and artificial flavor	185
2659	and certified confectioners glaze gum arabic	390
2660	sugar white and brown	170
2661	non dairy creamer	876
2662	partially hydrogenated soy bean oil	599
2663	calcium alginate	791
2664	artificial color & flavor	877
2665	artificial flavor spice	637
2666	less than 2% silicon dioxide	309
2667	and natural bourbon flavor.	878
2668	emulsifier soy lecithin and artificial vanilla flavor.	185
2669	Cake mix sugar	170
2670	enriched wheat flour	784
2671	bleached flour	16
2672	dry egg whites	244
2673	leavening baking soda	24
2674	tetrasodium pyrophosphat	879
2675	Cured with: water	5
2676	natural applewood smoke flavoring	880
2677	sodium nitrite.	367
2678	bleached enriched wheat flour flour	131
2679	modified cornstarch	561
2680	partially hydrogenated vegetable oil soybean and/or cottonseed	881
2681	mono- and diglycerides	729
2682	sodium carboxymethylcellulose	882
2683	sodium stearoyl lactylate	875
2684	datem	883
2685	calcium stearoyl-2-lactylate	884
2686	red 40 lake	677
2687	yellow 5 lake	863
2688	yellow 6 lake	794
2689	blue 1 lake	885
2690	bleached wheat flour flour	131
2691	sodium acid pyr	780
2692	leavening sodium acid pyrophosphate	780
2693	baki	886
2694	soybean palm kernel	286
2695	canola and/or palm kernel	286
2696	nonfa	887
2697	canola oils	90
2698	may also contain palm kernel oil	286
2699	food starch modified	778
2700	aluminum sulfate	612
2701	wheat protein	514
2702	lake	888
2703	leaveni	889
2704	canola and/ir palm kernel bleached enriched wheat flour flour	131
2705	natural & ar	650
2706	leavening sodium acid pyropho	780
2707	coca processed with alkali	890
2708	leaven	294
2709	food starch-modified eggs	14
2710	corn syrup m	596
2711	and/or palm kernel	286
2712	sodium acid pyropho	780
2713	palm soybean	201
2714	dry whole milk	891
2715	sweetened condensed milk sucrose	170
2716	milk fat and milk solids nonfat	7
2717	butter pasteurized cream	473
2718	salt. propylene glyco	148
2719	milk fat & milk solids nonfat	7
2720	butter pasteurize	892
2721	chocolate liquor processes w/ alkali	118
2722	100% pure organic blue agave nectar.	893
2723	Fish protein threadfin bream and/or alaska pollock and/or goatfish and/or pacific whiting and/or lizardfish and/or big eye	809
2724	natural & artificial flavor sardine	894
2725	egg whole	14
2726	Fish protein pollock and/or pacific whiting	809
2727	rice wine water	5
2728	contains 2% or less of: natural & artificial flavors	895
2729	Pollock	896
2730	snow crab meat	897
2731	contains 2% or less of: natural crab & lobster flavor	898
2732	marine oil source of omega-3	899
2733	sea	98
2734	snow crabmeat	897
2735	sea s	98
2736	Ingredients: tomatillos	900
2737	nopales cactus	901
2738	serrano pepper	902
2739	pineapple juice	497
2740	Jasmine rice.	903
2741	potassium benzoate preservative	490
2742	potassium citrate	904
2743	and caffeine.	585
2744	sweetened coconut flakes coconut	68
2745	sodium metabisulfite	397
2746	natural flavors lactic acid	295
2747	starter distillate	905
2748	vitamin d	581
2749	mascarpone cheese p	906
2750	Brownie mix powdered sugar	907
2751	bleached enriched wheat flour wheat flour	131
2752	contains 2% or less of the following: dried egg whites	908
2753	corn s	134
2754	bleached enriched wheat flour	131
2755	Graham crumb enriched wheat flour	131
2756	graham flour	131
2757	modified palm oils	201
2758	water ammonium bicarbonate	634
2759	margarine soy oil	243
2760	w	5
2761	modified palm oil	201
2762	lemon lemon peel	909
2763	lemon oil	910
2764	mod	507
2765	ENRICHED WHEAT FLOUR FLOUR	131
2766	CALCIUM PROPIONATE	911
2767	DIGLYCERIDES	729
2768	GRAIN VINEGAR	480
2769	CALCIUM IODATE	912
2770	POTASSIUM IODATE	913
2771	CALCIUM PHOSPHATE. CONTAINS: SOY	194
2772	WHEAT. I	143
2773	Whole wheat flour malted barley	635
2774	whole spelt flour	262
2775	whole white wheat flour	131
2776	whole bulgur wheat	914
2777	yeast. contains 2% or less of: molasses	294
2778	buckwheat grits	297
2779	wheat bran	301
2780	soybean flour	547
2781	ethoxylated mono- and diglycerides	729
2782	calcium propionate preservative	911
2783	ammonium sulfate	915
2784	flaxseeds	207
2785	flax flour	916
2786	millet. contains 2% or less of: inulin chicory root fiber	298
2787	sodium stearoyl	917
2788	lactylate	295
2789	yeast. contains 2% or less of: soybean oil	294
2790	ammonium phosphate	918
2791	vital wheat gluten. contains 2% or less of: steel cut wheat	919
2792	steel cut oats	78
2793	triticale flakes	253
2794	soybean seeds	277
2795	potato flakes	519
2796	oat flour	274
2797	corn meal	730
2798	enzymes.	920
2799	high fructose cor syrup	344
2800	yeast. contains 2% or less of: honey	294
2801	sodium st	594
2802	cellulose	740
2803	contains 2% or less of: soybean oil	243
2804	cracked wheat	914
2805	dough conditioners monoglycerides	921
2806	polydextrose	922
2807	corn grits	134
2808	rebaudioside a	923
2809	vital wheat gluten	919
2810	yeast. contains 2% or less to: soybean oil	294
2811	calcium su;fate	924
2812	RYE FLOUR	235
2813	CARAWAY SEEDS. CONTAINS 2% OR LESS OF: SALT	148
2814	CORNMEAL	149
2815	date	925
2816	sodium benzoate as preservative	454
2817	Unbleached enriched flour wheat flour	131
2818	wheat bra	143
2819	Ingredients: high fructose corn syrup	344
2820	contains less than 2% of: caramel color	357
2821	sodium benzoate and potassium sorbate preservatives.	926
2822	soybean oil. contains 2% or less of: salt	243
2823	vital wheat gluten sodium stearoyl lactylate	919
2824	ca	203
2825	calcium stearate anticaking agent	927
2826	calcium stearate and silicon dioxide anticaking agents	928
2827	acacia gum	929
2828	bha antioxidant	720
2829	yellow lake 5. dehydrated.	930
2830	spices including chili and red pepper	195
2831	celery seed	931
2832	partially hydrogenated soybean oil. dehydrated	599
2833	spices black pepper	12
2834	dill seed	932
2835	coriander seed	106
2836	partially hydrogenated soybean and/or cottonseed oil	881
2837	extractive of dill	933
2838	extractive of paprika for color	934
2839	silicon dioxide anticaking agent.	309
2840	spices including paprika and turmeric	55
2841	tricalcium phosphate anticaking agent	751
2842	oleoresin paprika for color.	55
2843	papain tenderizer.	935
2844	riboflavin for color	818
2845	soybean oil and silicon dioxide anticaking agents	243
2846	oleoresin carrot for color.	590
2847	partially hydrogenated vegetable oils coconut	936
2848	soybean oils	243
2849	propylene glycol monostearate	937
2850	sodium caseinate milk derivative	640
2851	acetylated monoglycerides	938
2852	mono-and diglycerides	729
2853	propylene glycol monoesters	939
2854	cellulose gel	740
2855	natural and artificially flavors	940
2856	vanilla bean	20
2857	egg yolks	796
2858	annatto for color.	236
2859	Ice cream - milk	7
2860	coca-processed with alkali	118
2861	mono - and diglycerides	729
3310	Ingredients: pine nuts.	1012
2862	vegetable oil peanut and/or cottonseed and/or palm oil	741
2863	natural flavor. fudge cups - sugar	1
2864	whey salt	140
2865	annatto for color. pecans - pecans	722
2866	mon- and diglycerides	921
2867	carrageenan. caramel swirl - corn syrup	206
2868	partially hydrogenated soybean oil.	243
2869	partially hydrogenated soy bean oil.	243
2870	polypropylene glycol monoesters	941
2871	salt. cookie dough - unbleached flour	140
2872	raspberry juice concentrate	748
2873	. chocolate chunk - sugar	1
2874	sugar corn syrup	596
2875	sweetened condensed skim milk condensed skim milk	942
2876	corn syrup sweetened condensed milk milk	596
2877	salt palm kernel oil	943
2878	Peanut butter roasted peanuts	173
2879	fully hydrogenated vegetable oil rapeseed	187
2880	cottonseed and soybean oils	944
2881	White cooking wine	945
2882	potassium sorbate and potassium sulfite preservatives.	338
2883	Red cooking wine	946
2884	salt potassium sorbate and potassium sulfite preservatives.	338
2885	Sherry cooking wine	947
2886	diluted with water to 4.2% acidity 42 grain.	200
2887	diluted with water to 4% acidity 40 grain.	200
2888	Balsamic vinegar grape must	104
2889	grape wine vinegar	480
2890	ester gum.	948
2891	caffeine.	585
2892	Turkey breast	949
2893	contains 2% or less of seasoning spices	834
2894	chipotle pepper	836
2895	dehydrated parsley	22
2896	lemon juice concentrat	200
2897	Solution ingredients: water	5
2898	contains 2% or less of: sea salt	98
2899	seasoning brown sugar	13
2900	maple sugar	950
2901	contains 2% or less of: salt	140
2902	canola oil and/or soybean oil	26
2903	leavening yeast	294
2904	and/or ammonium bicarbonate	634
2905	l-cysteine.	951
2906	contains 2% or less of: palm oil	201
2907	potato fla	279
2908	sodium benzoate and potassium sorbate preservatives	454
2909	and yellow 6.	403
2910	glycerol	234
2911	ester of wood rosin	769
2912	soybean oil with tbhq anti - oxidant	243
2913	dairy whey.	193
2914	Carbonated water.	356
2915	caffeine	585
2916	Brownie- sugar	1
2917	iron thiamine	468
2918	mononitrate	952
2919	contains 2% or less of: artificial flavor	637
2920	cor	134
2921	partially hydrogenated soybean and cottonseed oils	881
2922	high fructose corn wi syrup	344
2923	Ingredients: water	5
2924	corn starch-modified	332
2925	cultured nonfat milk	735
2926	beta-apo-8 carotenal for color	953
2927	calcium disodium edta to protect flavor. ingredients not in regular mayonnaise	843
2928	contains less than 2% of propylene ycol	616
2929	trigl ycerides	668
2930	tocopherols	169
2931	titanium dioxide for color	369
2932	sodium benzoate and potassium sorbate and edta preservatives.	954
2933	wheat gluten. contains 2% or less of: honey	955
2934	crystalline fructose	344
2935	Enriched flour unbleached wheat flour	131
2936	thiamine mononi	468
2937	vegetable oil peanut	741
2938	and/or sunflower oil	147
2939	soybean oil. contains 2% or less of: wheat gluten	243
2940	yeast. contains less than 2% of: salt	140
2941	calcium iodat	912
2942	soybean and/or sunflower oil.	26
2943	vegetable oil peanuts	741
2944	yeast soybean oil	243
2945	contains 2% or less of: wheat gluten	955
2946	filberts	144
2947	Ingredients: peanuts	137
2948	contains less than 2% of: salt	140
2949	calcium c	203
2950	extractives of tu	956
2951	maltodextrin. contains 2% or less of: vital wheat gluten	197
2952	extractives of paprik	55
2953	extractives of paprika and turmeric for color	934
2954	sucralose natural and artificial flavors	399
2955	calcium propionate preservative.	911
2956	palm oil soybean oil	957
2957	defatted soy flour	547
2958	mo	630
2959	soybean oil. contains 2% or less of: jalapeno	243
2960	sourdough f	958
2961	bleached enriched flour wheat flour	131
2962	reduced iron thiamine mononitrate	251
2963	folic acid soybean oil	819
2964	whole eggs	14
2965	whole milk milk vitamin d3	7
2966	contains 2% or less of each of the following: whey milk	193
2967	textured vegetable protein soy flour	959
2968	white pepper.	960
2969	Ground beef.	33
2970	Spices and herbs including rosemary	89
2971	parsley. dehydrated.	22
2972	Ingredients:water	5
2973	dijon mustard water	5
2974	beta carotene for color	590
2975	oleoresin paprika for color	55
2976	calcium disodium edta to protect flavor.	455
2977	contains 2% less of: salt	140
2978	red raspberry juice concentrate	961
2979	dried onion	962
2980	fruit and vegetable juices for color	963
2981	potassium sorbateand sodium benzoate preservatives	803
3195	ammonium bi	634
2982	canola and/or soybean and/or palm oil with tbhq {preservative}	243
2983	sugar. contains 2% or less salt	170
2984	calcium phosphate	381
2985	sodium sulfite.	426
2986	hydrolyzed corn gluten	964
2987	extractives of turmeric	956
2988	whole egg	14
2989	egg yolk	796
2990	bha preservative. dehydrated.	720
2991	parmesan cheese pasteurized milk	62
2992	extractive of basil	965
2993	partially hydrogenated vegetable cottonseed	881
2994	soybean oil. dehydrated	243
2995	unsweetened belgium chocolate	118
2996	Unbleached enriched wheat flour flour	131
2997	potato flour	664
2998	calcium propionate and sorbic acid	966
2999	carrageenan. graham cookies - sugar	206
3000	soybean and/or cottonseed oil	243
3001	Ice cream - milk and skim milk	7
3002	mono- an diglycerides	729
3003	ma	345
3004	turmeric extract color	383
3005	and yellow 6. chocolate butter toffee - sugar	794
3006	and soy lecithin. caramel fudge variegate - corn syrup	185
3007	salt sodium bicarbonate	258
3008	White corn	134
3009	vegetable oil corn	307
3010	canola and/or sunflower oil	26
3011	sugar syrup	310
3012	ground vanilla bean	20
3013	Milk and skim milk	7
3014	maltodextrin cream	197
3015	poydextrose	922
3016	celllulose gel	740
3017	vitamin a palmitate.	562
3018	mono- & diglycerides	729
3019	chocolate flavored chips - sugar	1
3020	partially hydrogenated coconut oil	967
3021	Chocolate ice cream - milk	7
3022	carrageenan. candy blend - sugar	206
3023	roasted almonds almonds	60
3024	partially hydrogenated soybean and/or safflower oil and/or almond oil and/or canola oil	881
3025	salt coconut oil	968
3026	milk solids	777
3027	natural cocoa butter cream	171
3028	non fat dry milk	801
3029	powdered sugar sugar	170
3030	soy lecithin emlusifier	185
3031	Cultured pasteurized milk and skim milk	7
3032	pineapple corn syrup	344
3033	natural and artificial flavoring	407
3034	polycorbate 80	613
3035	xanthan gum.	265
3036	caramel color. p	357
3037	Crushed tomatoes water	240
3038	crushed tomato concentrate	717
3039	diced tomatoes in tomato juice	240
3040	dried garlic	4
3041	dried onions	9
3042	romano cheese cultured part-skim milk	969
3043	dried garlic.	4
3044	soy-bean oil	243
3045	mushrooms	46
3046	dried green bell pepper	66
3047	dried celery	27
3048	roasted red bell pepper puree	536
3049	dried onion and basil.	970
3050	cooked beef	33
3051	parmesan cheese cultured part-skim milk	62
3052	romano and parmesan cheese cultured part-skim milk	62
3053	ricotta cheese pasteurized whole milk	971
3054	asiago cheese cultured part-skim milk	972
3055	fontina and provolone cheese cultured part-skim milk	973
3056	basil and citric acid.	200
3057	hydrolyzed corn gluten. contains 2% or less of garlic	974
3058	natural grill flavor grill flavor	975
3059	smoke flavor	268
3060	partially hydrogenated vegetable soybean	599
3061	sunflower oil. dehydrated	147
3062	anhydrous dextrose	750
3063	water. contains 2% or less of: molasses	5
3064	corn starch.	263
3065	chocolate pieces chocolate liquor	118
3066	soya lecithin an emulsifier	185
3067	water. contains 2% or less of: baking soda	5
3068	peanut butter flavored chips partially defatted peanuts	173
3069	partially hydrogenated vegetable oils palm kernel oil	286
3070	reduced minerals whey	697
3071	partially hydrogenated soybean oil and/or cottonseed oil	243
3072	chocolate chunks sugar	1
3073	hydrogenated vegetable oil rapeseed	187
3074	cottonseed oils	583
3075	water. contains 2% or less of: whey	5
3076	confectionery chips sugar	1
3077	partially hydrogenated palm kernel and palm oil	201
3078	milk chocolate flavored candy pieces sugar	1
3079	partially hydrogenated palm kernel oils	286
3080	artificial coloring includes yellow 5 lake	976
3081	blue 2 lake	977
3082	confectioner's glaze carnauba wax	415
3083	beeswax	502
3084	partially hydrogenated soybean and/or cottonseed oils	881
3085	contains 2% or less of: whey	193
3086	natural cocoa powder	118
3087	glycerine.	234
3088	canola and/or soybean with tbhq preservative and/or pam oil	978
3089	dextrose. contains 2% or less of: high fructose corn syrup	750
3090	natural and artificial chocolate flavor	56
3091	natural and artificial vanilla flavor.	20
3092	Roasted peanuts	173
3093	contains 2% or less of: molasses	156
3094	fully hydrogenated vegetable oils rapeseed	187
3095	cottonseed and soybean and salt.	148
3096	cottonseed and soybean	243
3097	and salt.	148
3098	Ingredients: rolled oats	78
3099	dehydrated apple flakes treated with sodium sulfite and sulfur dioxide to promote color retention	213
3309	Ingredients: almonds	60
3100	natural flavor. contains less than 2% of: cinnamon	210
3101	ferric orthophosphate	251
3102	niacinamide	466
3103	acesulfame potassium. phenylketonurics: contains phenylalanine.	855
3104	contains less than 2%: butter cream	2
3105	caramel color.	357
3106	neotame.	979
3107	concentrated orange juice	65
3108	brominated vegetable oil	980
3109	neotame	979
3110	calcium disodium edtato protect flavor.	981
3111	Reverse osmosis water	982
3112	erythritol	983
3113	calcium pantothenate b5	496
3114	magnesium lactate	984
3115	pyridoxine hcl b6	525
3116	monopot	985
3117	vegetable juice for color	768
3118	zinc picolinate	527
3119	vitamin e	169
3120	calcium pantothenat	986
3121	citric acid acid	200
3122	yellow 5 and 6	786
3123	yellow 5 and 6.	786
3124	locust bean gu	205
3125	cookies: enriched flour wheat flour	131
3126	concentrated raspberry juice	961
3127	concentrated lime juice	61
3128	orange pulp	65
3129	mono- a	630
3130	sucralose. wafers - bleached wheat flo	399
3131	Brownie-sugar	1
3132	enriched wheat flour bleached flour	131
3133	corns	134
3134	Brownie: sugar	170
3135	irion	251
3136	contains 2% or less: artificial flavor	637
3137	cornst	263
3138	corn maltodextrin	197
3139	cultures	987
3140	lime juice solids	200
3141	lemon juice solids.	200
3142	fully hydrogenated coconut oil	135
3143	contains less than 2% of: dipotassium phosphate	779
3144	and artificial flavor	637
3145	Dairy dessert - milk	7
3146	mono- & diglyceride	729
3147	g	498
3148	Grape juice from concentrate filtered water	150
3149	citric acid for tartness	200
3150	grape juice concentrate from concentrate	150
3151	potassium metabisulfate preservative.	988
3152	and blue 2	989
3153	calcium stearate anticaking agent.	927
3154	yellow 5 lake.	976
3155	maltodextrin. contains less than 1% of: spices including turmeric and red pepper	197
3156	papain tenderizer	935
3157	yellow lake 5 and 6	930
3158	red lake 40	677
3159	blue lake 2	990
3160	vegetable oil contains one or more of the following: palm	201
3161	soybean with tbhq	991
3162	contains 2% or less of: corn flour	165
3163	artificial colors yellow 5 and yellow 6	786
3164	soybean with tbhq {preservative}	256
3165	contains 2% or less of: cocoa processed with alkali	118
3166	soybean with tbhq preservative	256
3167	reduce iron	251
3168	peanut butter peanuts	137
3169	partially hydrogenated vegetable oil contains one or more of the following: rapeseed	881
3170	Enriched bleached wheat rom went flour	131
3171	folic ac	727
3172	10	1
3173	soybean with tbhq preservatives	256
3174	dextr	678
3175	Enriched flour bleached wheat flour	131
3176	niacin reduced iron	466
3177	canola and/ or soybean and/or palm oil with tbhq preservative	243
3178	cocoa contains 2% or less of: cocoa pro	118
3179	vegetable oil palm kernel and palm oils	201
3180	vegetable shortening partially hydrogenated soybean and cottonseed oils	881
3181	Enriched flour what flour	816
3182	folic cid	727
3183	sodium aluminum phosphate monocalcium phosphate	715
3184	modified soy protein.	276
3185	soy lecithin modified soy protein.	992
3186	vegetables shortening partially hydrogenated soybean and cottonseed oils	790
3187	water chocolate chips sugar	5
3188	chocolate liquor anhydrous dextrose	118
3189	vaniall extract	21
3190	wehy	193
3191	soybean oil with tbhq antioxidant	243
3192	sodium sulfite	426
3193	soybean oil with tbhq anti-oxidant	243
3194	natural and artificial flavor contains milk	7
4761	contains less than 2% of:celery sugar	1
4762	cooked with	5
4763	Tomato puree mater	487
4764	contains less than 2 of. sugar	1
4765	chicken stock once opened	97
4766	pomace olive flour heat flour	1277
4767	chicken flavorcontains lactose	1278
4768	contains less than 2% of: celery	27
4769	chic	1279
4770	Pasta: durum wheat semolina	1280
4771	filling: cheese ricotta	971
4772	romano	969
4773	parmesan	537
4774	fontina whey	193
4775	lipase	1281
4776	toasted wheat crumbs enriched durum wheat flour fl	131
4777	egg yolks. filling: cheese ricotta	796
4778	mozzarella	531
4779	parmesan whey	193
4780	breadcrumbs enriched wheat flour wheat flour	131
4781	parmesan cheese flavor parmesan cheese milk	62
4782	starter culture	1274
4783	Paste: durum wheat semolina	1280
4784	egg yolks. filling: cooked cured italian sausage pork	796
4785	seasoning corn syrup solids	750
4786	cheese parmesan	62
4787	swiss	1282
4788	provolone milk	7
4789	microbial enzyme	1283
3196	canola and/or palm and/or soybean oil with tbhq preservative	243
3197	contains 2% or less of: baking soda	258
3198	malted barley flour.	993
3199	vegetable shortening partially hydrogenated soybean and/or cottonseed oils. contains 2% or less of: leavening baking soda	243
3200	peanut and/or cottonseed oils	741
3201	fruit pectin	337
3202	sodium citrate.	477
3203	Ingredients: soybean oil	243
3204	water.egg yolk	796
3205	mustard powder	95
3206	buttermilk cultured lowfat and skim milk	994
3207	contains 2% or less of: sour cream powder cream	25
3208	maltodectrin	197
3209	tapioca dextrin	862
3210	contains 2% less of: dried garlic	4
3211	dried bell peppers	195
3212	calcium disodium edta to preserve freshness.	455
3213	raisins coated with partially hydrogenated soybean and/or cottonseed oil	881
3214	contains 2% or less of: walnuts	58
3215	Ingredients: high fructose corn	344
3216	Enriched bleached flour bleached wheat flour	131
3217	soybean oil. contains 2% or less of salt	243
3218	mono	630
3219	nuts	146
3220	m&m's milk chocolate candies milk chocolate sugar	461
3221	contains less than 1% of: corn syrup	596
3222	whole eggs and egg yolks	14
3223	Ice cream: milk	7
3224	strawbe	448
3225	grape juice from concentrate	150
3226	ammonium	652
3227	soybean oil with tbhq	243
3228	an antioxidant	650
3229	cheese cultured pasteurized milk	7
3230	contains 2% or less of: sal	594
3231	calcium chloride. contains 2% or less of: sal	340
3232	Apple juice from concentrate water	322
3233	cranberry juice concentrate	188
3234	ascorbic acid vitamin c. natural flavors.	329
3235	alcohol to preserve freshness.	384
3236	eggs and egg yolks	14
3237	natural	995
3238	flavors	940
3239	Enriched long grain rice rice	996
3240	enriched orzo pasta wheat flour	131
3241	cheddar cheese cultured pasteurized milk	32
3242	enzyme modified butter	997
3243	silicon dioxide	631
3244	shortening powder partially hydrogenated soybean oil	599
3245	blue cheese cultured pasteurized milk	837
3246	xanthan and guar gums	998
3247	parsley. dehydrated	22
3248	Ingredients: enriched long grain rice rice	999
3249	enriched vermicelli durum semolina niacin	1000
3250	onion and garlic	670
3251	partially hydrolyzed cottonseed and soybean oil	1001
3252	disodium guanylante	1002
3253	dehydrated	1003
3254	Enriched macaroni product wheat flour	131
3255	hydrolyzed vegetable protein soy	276
3256	chicken and other natural flavors	57
3257	autolyzed yeast extracts	209
3258	partially hydrogenated vegetable oil soybean	243
3259	butter butter cream	2
3260	bha to protect flavor	720
3261	shortening partially hydrogenated soybean oil	243
3262	oleoresin turmeric for color.  dehydrated.	383
3263	Ingredients: enrichedmacaroni product wheat flour	131
3264	roboflavin	248
3265	butter  cream	393
3266	authorised yeast extract	209
3267	natural flavors including annatto and turmeric  for color	1004
3268	sodium caseinate dehydrated	640
3269	parmesan cheese powder parmesan cheese pasteurized milk	62
3270	romano cheese powder romano cheese from sheep's and cow's milk	969
3271	shortening powder whey powder	193
3272	cream cheese powder cream cheese cream	30
3273	disoidum gyanylate	1005
3274	spices.  dehydrated.	198
3275	Ingredients: enriched macaroni & spinach product wheat flour	131
3276	parmesan cheese milk cheese culture	62
3277	cream cheese cream	30
3278	whet	143
3279	tocopherols and ascorbyl palmitate preservatives0	154
3280	green onion	870
3281	disodium guanylate.	1006
3282	THIAMINE MONONIRATE	468
3283	MONOCALCIUM PHOSPHATE.	259
3284	Asiago cheese cultured milk	972
3285	red peppers	195
3286	provolone cheese cultured pasteurized milk	1007
3287	cellulose to prevent caking	740
3288	natamycin a mold inhibitor.	1008
3289	Asiago cheese pasteurized milk	972
3290	basil.	48
3291	Cheese pasteurized milk	1009
3292	seasoning blend spice including ginger	28
3293	spice extractive	199
3294	oleoresin paprika.	55
3295	dehydrated peach juice concentrate	499
3296	2% or less of: acesulfame potassium	855
3297	mixed triglycerides	668
3298	calcium silicate	1010
3299	gum ac	390
3300	yeast. contains 2% or less of soybean oil	294
3301	mon	630
3302	molasses. contains 2% or less of soybean oil	156
3303	calcium citrate	1011
3304	enzymes. calcium propionate	911
3305	potassium sorbate and sorbic acid preservatives	854
3306	Carbonated water malic acid	345
3307	acesulfame potassium sucralose	855
3308	cottonseed and/or sunflower oils	243
4790	roasted red peppers red peppers	75
4791	starch culture	139
4792	egg yolks. filling: breadcrumbs enriched wheat flour wheat flour	796
4793	cooked chicken bacon pork	534
3311	feta cheese milk	7
3312	dried greek	1013
3313	yogurt fat free milk	7
3314	contains 2% or less of the following: sugar	1
3315	dried basil	48
3316	dried oregano	42
3317	calcium caseinate	1014
3318	potassium sorbate and sodium benzoate as preservatives.	803
3319	lowfat buttermilk cultured lowfat and skim milk	72
3320	chili sauce aged red peppers	75
3321	sour cream powder cream	1015
3322	non fat milk	7
3323	contains 1% or less of: salt	140
3324	phosphoric monosodium glutamate	630
3325	maltodextrain	197
3326	citric and malic acid.	200
3327	potassium benzoate and potassium sorbate preservatives	1016
3328	medium chain triglycerides	1017
3329	sucrose acetate isobutyr	1018
3330	medium chain trigl	1019
3331	sucrose acetate isobutyrate	1018
3332	natural flavor and artificial flavors	316
3333	calcium disod	203
3334	lime juice from concentrate	200
3335	contains 2% or less of the following: spices	834
3336	degermed yellow corn meal	149
3337	caraway seeds	521
3338	yeast nutrients	1020
3339	Steel cut oats.	78
3340	salad mustard water	95
3341	contains less than 2% of: molasses	156
3342	chili powder chili pepper	195
3343	dehydrated garlic.	4
3344	lime juice from concentrate water	61
3345	contains less than 2% of: maltodextrin	197
3346	toasted seasame oil	112
3347	contains less than 2% of each of the following: egg whites	1021
3348	natural and artificial flavors includes caramel color and sea salt.	940
3349	grape juice concentrate added for color fruit pectin	1022
3350	Butter toffee peanuts sugar	173
3351	and caramel color with sulfites to promote color retention	357
3352	banana chips banana	136
3353	dried sweete	1023
3354	Salted caramel seasoned almonds and cashews almonds	60
3355	milk chocolate covered caramels caramel sugar	452
3356	liquor sugar	170
3357	butterscotch chips sugar	1
3358	dry buttermilk	1024
3359	yogurt flavored waffle cone pieces yogurt flavored coating sugar	1
3360	sweet whey	1025
3361	nonfat yogurt powder cultured whey	193
3362	waffle cone pieces unbleached wheat flour	131
3363	vegetable shortening soybeans and/or palm oil	790
3364	Steel cut and rolled oatmeal	1026
3365	freeze-dried fruits strawberries	88
3366	dried sweetened cranberries cranberries	126
3367	walnuts walnuts	58
3368	dehydrated apples apples	738
3369	sodium sulfite and sulfur dioxide for color retention	426
3370	dried apples apples	1027
3371	sug	170
3372	golden raisins raisins	1028
3373	sulfur dioxide for color retention	426
3374	slivered almonds	60
3375	dried tomatoes in tomato juice	1029
3376	wafers: bleached wheat f	1030
3377	relish cucumbers	122
3378	peppers	195
3379	sweet red peppers	536
3380	dried horseradish	212
3381	contains less than 2% of: propylene glycol	616
3382	triglycerides	668
3383	titanium doixide for color	369
3384	sodium benzoate and potassium sorbate and calcium diosodium edta preservatives.	954
3385	Roasted and salted peanuts peanuts	173
3386	cottonseed soybean and/or sunflower oil	243
3387	candy corn sugar	1
3388	sesame oil	112
3389	contains less than 2% of: calcium carbonate	328
3390	artificial and natural flavors maltodextrin	197
3391	caramel color sulfites	357
3392	Enriched unbleached flour wheat flour	131
3393	partially hydrogenated soybean &/or cottonseed oil	881
3394	contains less than 2% of eac	1031
3395	passion fruit concentrate	1032
3396	annatto color.	722
3397	Cherries	189
3398	modified food starch. contains less than 2% o	778
3399	contains less than 2 % of each of the following: marga	1033
3400	coffee concentrate	550
3401	Chiles	195
3402	seaweed	1034
3403	ginger.	28
3404	cream.	473
3405	dried peaches peaches	444
3406	sulfur dioxide	306
3407	Maltodextrin salt	148
3408	paprika oleoresin	55
3409	disodium inosinate and disodium guan	1035
3410	sherry wine solids	1036
3411	malt syrup corn syrup	596
3412	leavening monocalcium phosphate	259
3413	contains 2% or less of: spices	834
3414	sodium benzoate preservative.	454
3415	soybeans oil	243
3416	salt. contains 2% or less of dried garlic sundried tomato	140
3417	dried carrots	119
3418	dried red bell pepper	195
3419	dried green pepper	66
3420	balsamic vinegar	104
3421	paresan cheese cultured part-skim milk	62
3422	enzyme modified cultured romano cheesecultured milk	735
3423	enzyme modified cultured cream	1037
3424	potassium sorbate ad sodium benzoate preservatives	803
3425	calcium disodium edta to preserve freshness	455
3426	salt. contains 2% or less of: dried garlic	140
3427	sun dried tomato	1038
3428	contains 2% or less of: smoke flavor	268
3429	buttermilk solids	72
3430	vinegar powder maltodextrin	197
3431	paprika extract color	934
3432	disodium inosinate and disodium guanylate	1039
3433	cheddar cheese milk	7
3434	turmeric extract and paprika extract for color	1040
3435	carrots.	119
3436	cauliflower.	1041
3437	Organic broccoli.	116
3438	Organic broccoli	116
3439	organic cauliflower.	1041
3440	organic carrots	119
3441	cauliflower	1041
3442	Snow peas.	1042
3443	sugar snap peas.	1043
3444	Green beans.	1044
3445	Cauliflower florets.	1041
3446	red cabbage	113
3447	Raisins.	233
3448	snap peas	1045
3449	and broccoli.	116
3450	Sliced almonds.	60
3451	Blanched slivered almonds.	60
3452	Walnut halves and pieces.	58
3453	Walnut pieces.	733
3454	Pecan halves.	732
3455	Pecan pieces.	732
3456	turmeric extract for color	175
3457	blue cheese milk	1046
3458	contains 2% or less of: dried garlic	4
3459	natural and artificila flavors	895
3460	sodium and calcium casenites	640
3461	gum	578
3462	sodium benzoate and potassium sorbate preservative	354
3463	disodium inocinate	1002
3464	calcium disodium edts to protect flavor.	455
3465	Macadamia nuts	753
3466	maltodextrin.	197
3467	egg yolk. contains 2% or less of: dried garlic	796
3468	sodium and calc	140
3469	apple juice concentrate.	322
3470	yeast. contains 2% or less of salt	140
3471	bread mix cracked purple wheat	143
3472	flax seeds	207
3473	cracked triticale	253
3474	cracked kamut khorasan wheat	1047
3475	enrich	1048
3476	contains less than 2% of each of the following: soybean oil	243
3477	sodi	594
3478	contains less than 2% of each of the following: sugar	1
3479	wheat fl	143
3480	soy flour. sorbic acid and calcium propionate preservatives	547
3481	soy fiber	1049
3482	yeast. contains 2% or less of: salt	294
3483	calcium propionate and sorbic acid preservatives	966
3484	lactic and citric acid	295
3485	beef gelatin	459
3486	mayonnaise soybean oil	243
3487	potassium sorbate preservative.	338
3488	Cooked enriched macaroni water	5
3489	semolina wheat wheat	451
3490	american and swiss and enzyme modified cheeses part skim and whole milk	38
3491	wheat f	143
3492	contains 2% or less of water	1050
3493	pickle relish cucumbers	122
3494	mustard distilled vinegar	73
3495	lactic and acetic acids	1051
3496	cider vinegar	480
3497	sodium ascorbate	329
3498	potassium sorbate and sodium benzoate preservatives.	803
3499	contains less than 2% of each of the following: dextrose	750
3500	azodicarbonamide	1052
3501	preservatives calcium propionate	911
3502	ascorbic acid added as a dough conditioner	329
3503	titanium dioxide color	369
3504	contains 2% or less of each of the following: yeast	294
3505	pasteurized cultured cream and milk	1053
3506	modified corn and tapioca starch	778
3507	gums guar	475
3508	locust bean	205
3509	sodium hexametaphosphate titanium dioxide color	369
3510	Enriched flavor wheat flour	131
3511	palm oil and fractionated palm oil	201
3512	hydrogenated vegetable oil palm kernel oil	286
3513	contains less than 2% of each of the following: cocoa processed with alkali	118
3514	soy flavor	1054
3515	propylene glycol mono-and diesters of fats and fatty acids. sodium stearoyl lactylate	939
3516	sorbic acid and sodium propionate and potassium sorbate preservatives	854
3517	beta-carotene color	590
3518	alpha-tocopherols preservative.	169
3519	Cake: sugar	170
3520	enriched whet flour wheat flour	131
3521	soybean and canola oil	243
3522	enriched bleached wheat flour flour	131
3523	contains 2% or less of: mono- & diglycerides	729
3524	calcium disodium edta preservative	843
3525	artificial	637
3526	contains less than 2% of: soybean oil	243
3527	mono & digl	1055
3528	Organic chicken stock	97
3529	organic diced tomatoes in organic tomato juice	240
3530	organic chicken breast with rib meat	117
3531	organic onions	9
3532	organic corn	134
3533	organic red peppers	195
3534	organic white corn tortilla chips organic white corn	134
3535	organic vegetable oil	26
3536	contains less than 2% of: organic jalapeno peppers	195
3537	organic white corn masa	263
3538	organic garlic	4
3539	organic wheat starch organic chicken fat	662
3540	organic spice	198
3541	organic concentrated lime juice	61
3542	organic cilantro	47
3543	organic cultured dextrose	750
3544	organic chicken flavor contains sea salt	98
3545	organic paprika	55
3546	organic dehydrated onions	9
3547	organic carrot juice concentrate	1056
3548	organic yeast extract	209
3549	organic onion juice concentrate	9
3550	organic potato flour	519
3551	organic dehydrated carrot	119
3552	organic dehydrated garlic	4
3553	organic turmeric for color	175
3554	organic canola oil	90
3555	organic flavoring.	407
3556	organic heavy cream from organic milk	52
3557	organic long grain rice	1057
3558	organic wheat starch	662
3559	contains less than 2% of: organic celery	27
3560	organic vegetable stock water	5
3561	organic celery	27
3562	organic salted butter organic cream	2
3563	contains less than 2% of: organic wheat starch	662
3564	organic spices	834
3565	organic dehydrated onion	9
3566	organic molasses	156
3567	celery seed oil flavor	1058
3568	organic onion extract	1059
3569	organic celery seed	931
3570	organic black pepper oil	1060
3571	organic canola oil.	90
3572	Egg whites with triethyl citrate for whipping	1021
3573	bleached enriched flour bleached wheat flour	131
3574	adipic acid	1061
3575	wheat and corn starch	139
3576	sodium diacetate preservative.	1062
3577	bleached enriched flour	816
3578	Pasteurized milk	1009
3579	microbial enzymes.	1063
3580	Pasteurized part-skim milk	1009
3581	Chicken stock	97
3582	white chicken meat	117
3583	corn chips ground white corn treated with lime	134
3584	cooked black beans	669
3585	contains 2% or less of: chicken meat	57
3586	roasted g	550
3587	Whipped topping water	5
3588	non-hydrogenated palm kernel oil	286
3589	non-hydrogenated coconut oil	135
3590	enriched flour wheat flour with niaci	131
3591	contains 2% or less of: sugar	1
3592	butternut squash	1064
3593	chicken stock concentrate	97
3594	unbleached enriched wheat flour w	131
3595	contains 2% or less of: corn syrup	596
3596	oleoresin of paprika	55
3597	chicken meat	57
3598	enriched egg noodles wheat flour	131
3599	ferrous sulfate thiamine mononitrate	251
3600	contains 2% or less of: celery	27
3601	chicken flavor contains lactose	405
3602	Corn starch. contains 2% or less of: partially hydrogenated soybean and/or cottonseed and/or canola oils	263
3603	monoand diglycerides	729
3604	stearolyl lactylate	1065
3605	sodium aluminium phosphate	1066
3606	corn oil. toppins: walnuts.	307
3607	contains 2% or less of: partially hydrogenated soybean and/or cottonseed and/or canola oil	881
3608	mono- and diglyceries	729
3609	topping: sugar.	1
3610	wheat bran. contains 2% or less of: modified corn starch	301
3611	partially hydrogenated soybean and/or cottonseed and/or canola oils	881
3612	mono- and di-glycerides	1067
3613	propylene glycol monoesters of fatty acids	939
3614	xanthan gum. topping: oats	265
3615	raw sugar.	170
3616	Chicken chicken white meat	57
3617	potassium lactate	1068
3618	sodium tripolyphosphate	820
3619	cayenne pepper sauce aged cayenne red peppers	69
3620	and garlic powder	4
3621	egg yolks egg yolks	796
3622	celery powder.	1069
3623	Chicken breast	117
3624	Roast beef rubbed with sea salt and black pepper.	33
3625	Chocolate-chocolate chip cookies contain: sugar	1
3626	leeks	1070
3627	dehydrated potatoes	279
3628	contains 2% or less of: garlic	4
3629	egg yolk flavor	1071
3630	whey protein concentr	387
3631	Peaches peaches	444
3632	ascorbic and/or citric acid	329
3633	liquid whole egg	14
3634	cultured	1072
3635	heavy whipping cream cream	1073
3636	sodium ci	140
3637	contains 2% or less of: beef	33
3638	sodium ascorbate vitamin c	329
3639	Cooked shrimp. cocktail sauce: water	86
3640	horseradish	212
3641	ground onion	9
3642	ground garlic	4
3643	natural horseradish flavor horseradish	212
3644	invert syrup	471
3645	enriched wheat flour bleached wheat flour	131
3646	Cake- sugar	1
3647	enriched bleached wheat flour bleached wheat flour	131
3648	contains 2% or less of nonfat milk	7
3649	leavening sodium	258
3650	Cake - sugar	170
3651	modified corn starch contains 2% or less of nonfat milk	561
3652	le	295
3653	sunflower oil and/or canola oil contains ascorbic acid and rosemary	650
3654	contains less than 2 % of each of the follow	140
3655	evaporated apples apples	1074
3656	sodium sulfite preservative	1075
3657	sulfur dioxide pre	306
3658	vegetable shortening soybean oil	243
3659	hydrogenated cottonseed oil	1001
3660	polysorbat	1076
3661	enriched flour wheat	131
3662	canola and/or soybean with tbhq preservative and/or palm oil	978
3663	cocoa processed with alkali. contains 2% or less of: high fructose corn syrup	118
3664	Filling: corn syrup	344
3665	peacans	173
3666	margarine canola oil	90
3667	modified palm and palm kernel oil	201
3668	soybean lecithin	185
3669	natural cocoa	118
3670	cocoa treated with alkali	118
3671	oat flour. contains 2% or less of: salt	274
3672	ammonium bicarbonate.	634
3673	water. contains 2% or less of: cinnamon	5
3674	natural and artificial flavors contains milk	7
3675	water. contains 2% or less of: malted barley flour	5
3676	contains 2% or less of: canola oil and/or soybean oil	26
3677	and/or ammonium bicarbonate.	634
3678	cracked wheat flour	1077
3679	nalted barley flour	993
3680	malted corn flour	1078
3681	soy lecthin	394
3682	sodium sulfate	1079
3683	whey.	193
3684	extractives of turmeric and paprika color	1080
3685	contains less than 2% of the following: natural flavoring	210
3686	celery powder	1069
3687	oleoresin of paprika.	55
3688	wine	384
3689	lactic acid starter culture.	295
3690	water. contains less than 2% of: salt	5
3691	Enriched flour wheat flour wheat flour	131
3692	Ingredients: enriched flour wheat flour	131
3693	niacian	466
3694	dehydrated cheddar	32
3695	parmesan and romano cheese whey	193
3696	buttermilk pasteurized cultured milk	735
3697	sodium saseinate	847
3698	yeast. contains 2% or less of wheat glauten	294
3699	dough conditioners may contain one or more of the following: sodium steqroyl lactylate	875
3700	calciumstearoyl lactylate	884
3701	calcium peroxide	1081
3702	chives	99
3703	tbhq to preserve freshness.	1082
3704	whole grain wheat flour	131
3705	canola and/or soybean oil	978
3706	citric acid and tbhq preservatives. contains 2% or less of molasses	200
3707	baking soda and/or calcium phosphate	258
3708	natural cinnamon flavor	15
3709	vegetable oil shortening palm	201
3710	canola and modified palm oil	90
3711	soybean lecithin.	185
3712	Whole wheat graham flour	283
3713	leavening yeast sodium bicarbonate	258
3714	skim milk. contains 2% or less of: glycerin	234
3715	blue cheese milk cheese cultures	1083
3716	artificial color yellow 5 and 6	786
3717	Pork rinds and salt.	148
3718	Pork rinds	1084
3719	spices including chili peppers	195
3720	red 40 lake.	677
3721	vegetable oil canola corn	90
3722	soybean and/or sunflower	185
3723	vegetable oil shortening soybean oil or canola oil	243
3724	Ingredients: bleached enriched wheat flour wheat flour	131
3725	Ingredients: enriched wheat flour wheat flour	131
3726	thiamin flour	1085
3727	vegetable oil contains one or more of the following: canola oil	90
3728	artificial colo yellow 5	403
3729	disodium phosphate.	194
3730	leavening sodium bi	258
3731	contains 2% or less of: high fructose corn syrup	344
3732	romano and parmesan cheeses blend pasteurized cultures milk	1086
3733	buttermilk cultured milk	735
3734	natural flavors milk	7
3735	dehydrated disodium inosinate	1002
3736	extractive of annatto and turmeric for color	1087
3737	romano and blue cheese blend cultured milk	1088
3738	pasteurized cultured milk	7
3739	anchovy extract	1089
3740	extractives of annatto & turmeric for color	1090
3741	wheat berries	143
3742	roasted pumpkin seeds pumpkin seeds	177
3743	mill	309
3744	vegetables oil corn	307
3745	and/or canola	187
3746	cottonseed and/or canola	26
3747	contains 2% or less of each of the following: cinnamon	15
3748	calcium stearoyl lactylate	884
3749	cinnamic aldehyde	419
3750	colored with extractives of turmeric and annatto seed	1091
3751	calcium propionate and sodium propionate to retard spoilage.	1092
3752	Multigrain sub roll enriched wheat flour wheat flour	131
3753	grain blend fermented wheat flour	1093
3754	wheat grain	143
3755	rye grain	217
3756	oat grain	254
3757	rye sourdough	217
3758	Sub roll enriched wheat flour wheat flour	131
3759	contains 2% or less of: yeast	294
3760	malted barley extract	1094
3761	vegetable oil canola and/or soyb	26
3762	Turkey breast with turkey broth	1095
3763	grain	1096
3764	Ham cured with water	148
3765	sodium nitrite; coated with caramel color	367
3766	sub roll enriched wheat and malted barley flour contains niacin	131
3767	Roast beef beef	33
3768	contains less than 2% of: sodium lactate	1097
3769	coated with dextrose	750
3770	onion and garlic powder	1098
3771	sub rol	1099
3772	Sub roll enriched wheat flour wheat and malted barley flour	131
3773	wheat gluten vegetable oil canola oil or soybean	955
3774	flat bread enriched unbleached wheat and malted barley flour contains niacin	131
3775	coated with caramel color	357
3776	contains less than 2%: sodium lactate	1097
3777	flavorings; coated with dextrose	196
3778	flat bread	1100
3779	Egg salad hard cooked eggs with water	3
3780	monosodium phosphate	1101
3781	potassium sorbate {preservative}	338
3782	dressing mayonnaise {soybean oil	243
3783	calcium disodium edta to protect fl	843
3784	Chicken breast meat with water	117
3785	croissant enriched wheat flour contains niacin	784
3786	reduc	295
3787	unsalted butter	23
3788	milk with vitamin d add	7
3789	Roll enriched wheat and malted barley flour contains niacin	131
3790	natural wheat sour	143
3791	cultured wheat starch and w	662
3792	White chicken meat with water	57
3793	ciabatta roll unbleached enriched wheat flour wheat flour	131
3794	Romaine and iceberg lettuce	324
3795	yellow peppers	195
3796	red onions	1102
3797	ranch dressing: soybean oil	243
3798	carrage	206
3799	eggs with water	1103
3800	turkey breast turkey breast meat	1104
3801	turkey broth	1105
3802	ham	128
3803	blue cheese pasteurized milk	837
3804	cheese cultur	1106
3805	salt spices	148
3806	eggs wuth water	5
3807	Vegetables carrots	119
3808	ranch dip sour cream cream	25
3809	locust bean gum and/or xanthan gum and/or guar gum	578
3810	ph	1107
3811	sodium erythobate	363
3812	swiss cheese part-skim milk	1108
3813	thiamine m	468
3814	pretzel roll enriched wheat flour wheat flour	131
3815	ribofl	818
3816	pie crust enriched flour wheat flour	131
3817	contains 2% or less of: dextrose	750
3818	cal	203
3819	ketchup tomato concentrate	717
3820	high fructose syrup	344
3821	contains less than 2% of: spice	198
3822	eggs with citric acid	1109
3823	crackers enriched flour wheat flour	131
3824	thi	1085
3825	Salmon filet pink and/or keta salmon	808
3826	sodium phosphates	570
3827	dehydrated garlic and onion	1110
3828	spice extractives	199
3829	fresh parsley.	22
3830	Sauce base tomatoes	487
3831	sauteed onions	9
3832	extra virgin olive and sunflower oils	1111
3833	pasta sheet enriched durum wheat flour contains niacin	239
3834	Macaroni durum semolina	1000
3835	annatto color	722
3836	powdered cellulose	740
3837	processed cheese product milk	640
3838	Brussels sprouts	1112
3839	pancetta pork	534
3840	contains less than 2% of:dextrose	750
3841	syrup corn syrup	596
3842	high fructose corn syr	344
3843	Green beans	1044
3844	pepper.	10
3845	garlic with water	4
3846	white balsamic vinegar wine vinegar	480
3847	concentrated grape juice	150
3848	potato starch and cellulose powder	519
3849	natamycin preservative	1008
3850	milk cheddar cheese pasteurized milk	1009
3851	emzymes	192
3852	potato starch corn starch	263
3853	wh	5
3854	pasta durum semolina	451
3855	mozzarella cheese pasteurized	531
3856	italian sausage pork	534
3857	Tuna with water	1113
3858	dressing lite mayonnaise water	5
3859	beta-apo-8'-carotenal f	1114
3860	Cabbage	113
3861	cole slaw dressing dressing soybean oil	243
3862	calcium disodium edta {preservative}	455
3863	buttermilk cultured lowfat milk	994
3864	sodium c	594
3865	yeast extract garlic powder	1115
3866	dressing mayonnaise soybean oil	243
3867	Hard cooked eggs with water	14
3868	must	650
3869	Pasta durum semolia	451
3870	niacin ferrous sulfate	466
3871	dressing salad dressing soybean oil	243
3872	natuarl flavor	210
3873	calcium disodium edta	843
3874	dressing sour cream cream	25
3875	Edamame	256
3876	black beans with water	1116
3877	ferrous gluconate	251
3878	garbanzo beans with water	1117
3879	disodium edta for color retention	455
3880	seasoned rice vinegar rice vinegar	73
3881	red on	1102
3882	Green cabbage	113
3883	roasted red peppers with water	75
3884	vinaigrette water	5
3885	agave syrup	344
3886	lime juice water	61
3887	lime oil	1118
3888	lime puree	1119
3889	Beets	174
3890	orange vinaigrette vegetable oil soybean and/or canola oil	872
3891	orange blossom honey	1120
3892	white balsamic vinegar	1121
3893	orange puree concentrate	1122
3894	candied orange peel orange peel	366
3895	caesar dressing soybean oil	243
3896	white win	1123
3897	water distilled vinegar	480
3898	Pasta semolina enriched with iron	451
3899	tomato solids	1124
3900	dried spinach	79
3901	italian dressing water	5
3902	lemon ju	200
3903	cultured wheat starch and	662
3904	cracked 10 grain blend purple whole wheat	802
3905	red wheat	1125
3906	buckwheat	297
3907	brown flax	157
3908	amaranth	168
3909	kamut khorasan wheat	296
3910	cracked purple wheat flakes	143
3911	brown flax seed	157
3912	cracked triticale flakes	253
3913	contains 2% or less of: dark rye flour	1126
3914	dough conditioner	911
3915	and folic acid	727
3916	sliced cranberries	188
4037	natural flavors contains maltodextrin	197
3917	emulsifier blend propylene glycol mono- and diesters of fats and fatty acids	1127
3918	apples apples	213
3919	emulsifier blend propylene glycol mono- a	1128
3920	contains 2% or less of artificial flavor	643
3921	e	384
3922	soybean and/or canola oil	1129
3923	monoc	1130
3924	oat hull fiber	601
3925	soybean and / or canola oil	243
3926	cultured wheat flour	131
3927	Enriched wheat flour bleached flour bleached flour	131
3928	iron thiamine mononitrate	468
3929	food starch-modified corn	332
3930	monocalcium	203
3931	Dark corn syrup dark corn syrup	156
3932	refiner's syrup	1131
3933	caramel flavor	452
3934	enriched flour wheat flour with niacin	131
3935	soybe	256
3936	Cream cheese milk	30
3937	carob bean gum	783
3938	sour cream cultured pasteurized light cream and nonfat milk	473
3939	m	630
3940	milk protein concentrate	291
3941	potassium sorbate and sorbic acid and sodium propionate preservatives	854
3942	toasted wheat germ	180
3943	corn dextrin	678
3944	karaya gum	1132
3945	enzymes.powder coating: dextrose	750
3946	natural and artificial flavor. cinnamon coating: dextrose	316
3947	blueberry filling blueberries	411
3948	flavor bits sugar	1
3949	modified corn and/or wheat starch	778
3950	corn cereal	134
3951	blue 2	989
3952	green 3	888
3953	guar gum artificial flavor	475
3954	cornsyrup	750
3955	disodium inosinate and guanylate	1133
3956	extractives of annatto and turmeric	1134
3957	artificial color red 40	677
3958	cheddar and romano cheese pasteurized milk	1135
3959	spice and spice extractives including extractives of paprika	55
3960	reduced lactose	405
3961	Surimi fish protein pollock and/or pacific whiting	1136
3962	rice winewater	1137
3963	sauce	76
3964	eggs white	244
3965	sorbatol	854
3966	contains 2% less of: natural & artificial flavors includes crab	940
3967	wheat starc	662
3968	Cooked white meat chicken	57
3969	egg yolk distilled	185
3970	contains 2% or less of: mustard seed	1138
3971	water chestnuts	1139
3972	contains 2% or less of: bread crumb	1140
3973	red raspberries	208
3974	blackberries. contains 2% or less of: modified corn starch	1141
3975	distilled monoglyce	234
3976	riboflavin. folic acid	727
3977	cherry flavored bits sugar	1
3978	partially hydrogenated cottonseed and/o	1142
3979	orange peel. contains 2% or less of: modified corn starch	366
3980	water. contains 2% or less of: mangos	5
3981	sodium stearoyl l	917
3982	contains 2% or less of: almonds	60
3983	ferrous sulphate	251
3984	modified corn starch. contains 2% or less of each of the following: partially	778
3985	contains 2% or less of: partially hydrogenated soyb	599
3986	ground vanilla beans	20
3987	poppy seed	745
3988	modified corn syrup	596
3989	contains 2% or less of each of the following: pa	1143
3990	pumpkin cheese filling sugar	1
3991	cream cheese cultured pasteurized milk and cream	30
3992	pumpkin puree	559
3993	contains less than 2% of: carrot juice	1056
3994	celeriac juice concentrate	1144
3995	vegetables car	1145
3996	seasoning spice	198
3997	kale	841
3998	chicken flavor contains lactose milk	405
3999	cooked navy beans	1146
4000	dark chicken meat	1147
4001	green peppers	195
4002	contains less than 2% of: chicken fat	1148
4003	roasted corn	134
4004	roasted poblano chili peppers	1149
4005	Organic chickpeas chickpeas	1150
4006	organic sesame tahini	1151
4007	Organic chickpeas chickpeas & water	1150
4008	organic red bell pepper	84
4009	organic olive oil	6
4010	organic vinegar	480
4011	organic crushed red pepper.	1152
4012	Organic cnickpeas cnickpeas	222
4013	organic sesame tanini	153
4014	organic lemon juice	18
4015	modified corn starch. contains 2% or less of: nonfat milk	561
4016	leavening sodium acid pyroph	780
4017	contains 2% or less of: nonfat milk	7
4018	leavening sodium acid	780
4019	modified cornstarch. contains 2% or less of: nonfat milk	561
4020	spaetzle dumpling water	5
4021	oleoresin turmeric for color	383
4022	white chicken meat carrots	1153
4023	contains less than 2% of: modified cornstarch	778
4024	salt xanthan gum	265
4025	soy protein concentrate	276
4026	modified rice starch	1154
4027	dehydrated chicken	57
4028	nisin preparation.	1155
4029	Powdered sugar	907
4030	liquid sucrose	170
4031	Cookie: enriched flour wheat flour	131
4032	palm and/or cottonseed and/or canola oil	26
4033	contains 2% or less of: agar	342
4034	Chicken breast with rib meat. contains up to 20% of a solution of: water	1156
4035	carrageenan. pred	206
4036	contains 2% or less of: sodium lactate	1097
4038	oleoresin capsicum	195
4039	corn oil processing aid	307
4040	calcium stearate anti-caking	927
4041	silicon dioxide anti-caking.	309
4042	dough conditioner salt	140
4043	soy oil	243
4044	l-c	951
4045	purple garlic	4
4046	pasteurized egg yolk	796
4047	Iberico pork	1157
4048	milk and soy isolate proteins	1158
4049	potassium nitrite	1159
4050	carminic aci	673
4051	trisodium citrate	647
4052	potassium nitrate	1159
4053	sodium nitrate	952
4054	sodium ascorbate.	329
4055	Pork ham	534
4056	preservatives potassium nitrate	1159
4057	Pasteurized organic milk	7
4058	organic green and red jalapeno peppers	1160
4059	Sheep's milk	441
4060	rennet	1161
4061	cheese cultures.	1162
4062	Pasteurized cow's milk	1163
4063	egg white lysozyme	1164
4064	natamycin a natural mold inhibitor.	1008
4065	Enriched flour wheat flour niacin	131
4066	partially hydrogenated soybean & cottonseed oil	881
4067	contains 2% or less of the following: soy flour	547
4068	calci	203
4069	vegetable shortening partially hydrogenated soybean & cottonseed oils	1165
4070	esters of fatty acids	1166
4071	mono & diglyceride	729
4072	contains 2% or less of: oat bran	191
4073	raisin juice concentrate	1167
4074	yellow corn meal	149
4075	contains 2% or less of: partially hydrogenated soybean and cottonseed oils	881
4076	emulsifier propylene glycol monoesters	1168
4077	sodium aluminosilicate	309
4078	sorbic acid preservative	854
4079	Brownie- bleached enriched flour bleached wheat flour	131
4080	egg white. contains 2% or less of: salt	376
4081	partially hydrogenated soybean oil and cottonseed oils	243
4082	maltiol	1169
4083	modified waxy corn starch	561
4084	maltitol syrup. contains less than 2% of: salt	1169
4085	nu	308
4086	contains 2% or less of: partially hydrogenated soybean and/o	599
4087	eggs. contains less than 2% of: modified corn starch	3
4088	leavening sodium aluminum phospahte	864
4089	baking sod	24
4090	modified corn starch. contains 2% or less of each of the following: whey milk	561
4091	emulsifier mono- and diglycerides	729
4092	propylene glycol ester of fatty acids	1170
4093	soybean oil corn syrup	243
4094	almonds. contains 2% or less of each of the following: veg	60
4095	blackberries	1141
4096	modified corn starch. contains 2% or less of e	561
4097	modified corn starch. contains less than 2% of dextrose	561
4098	maragarine liquid and partially hydrogenated soybean oil	599
4099	vitamin a palmitate. contains less than 2% of: dextrose	1171
4100	l-cysteine	951
4101	maltitol syrup. contains 2% or less of: salt	1169
4102	sorbic acid and potassium sorbate preservatives	854
4103	malitotol syrup	1169
4104	sodium tripolyphosphate.	820
4105	maltitol syrup. contains 2% or less salt	1169
4106	sorbic acid and potassium sorbate preservative	854
4107	Brownie: bleached enriched flour bleached wheat flour	131
4108	corn starc	263
4109	Brownie - bleached enriched flour bleached wheat flour	131
4110	leavening	294
4111	sodium acid	200
4112	palm kernel oil and cottonseed oil	1172
4113	dextrose. contains 2% or less of nonfat milk	750
4114	algin	1173
4115	pal	1174
4116	Sweet potatoes	370
4117	milk milk	7
4118	concentrated lemon juice	18
4119	glucono-delta-lactone	516
4120	sorbic acid preservative.	854
4121	sodium aluminum phosph	715
4122	ferous sulfate	1175
4123	soyabean oil	243
4124	riboflavin folic acid	818
4125	contains less than 2% of salt	140
4126	emulsifiers glycerin	234
4127	dextrose calcium sulfate	750
4128	beta carotene for color. glaze also contains: corn syrup	478
4129	mono & diglycerides.	341
4130	enriched bleached flour	816
4131	bananas with ascorbic acid and citric acid	1176
4132	modified corn starch. contains 2% or less of whey	561
4133	emulsifier monoglycerides	921
4134	banana emulsion artificial flavor	136
4135	tragacanth gum	1177
4136	cake flour bleached wheat flour	131
4137	acidic sodium aluminum phosphate with aluminum sulfate	1178
4138	caramel color almond flour.	377
4139	modified food starch corn. contains 2% or less of each of the following: whole milk milk	332
4140	vit	494
4141	milk chocolate chips sugar	1
4142	grah	1096
4143	pineapple pineapple	63
4144	and clarified pineapple juice concentrate	1179
4145	contains less than 2% of dextrose	750
4146	Whole grain brown rice	305
4147	corn with germ removed	165
4148	cheese flavor blend salt	148
4149	butter milk powder	1180
4150	white cheddar and cheddar cheese solids milk	32
4151	whey permeate	1181
4152	hydroxylated soy lecithin	185
4153	Yogurt coating evaporated cane syrup	871
4154	yogurt powder cultured whey	193
4155	yogurt powder  cultured whey	193
4156	nonfat milk powder. soy lecithin  an emulsifier	1182
4157	pretzels enriched wheat flour {wheat flour	131
4158	leavening contains one or more of the following: yeast	294
4159	Organic peas	132
4160	peas	132
4161	Organic strawberries.	448
4162	Organic blueberries.	411
4163	semolina wheat enriched with ferrous sulfate	143
4164	enzymes. c	1183
4165	Yogurt coating evaporated cane sugar	1
4166	Organic mango.	190
4167	evaporated cane syrup.	871
4168	ORGANIC ROASTED SOY NUTS ORGANIC SOYBEANS	142
4169	Organic whole raw sunflower seeds.	151
4170	Unbleached wheat flour malted barley flour	131
4171	bulghur wheat	914
4172	beet powder and turmeric added for color	174
4173	organic extra virgin olive oil	6
4174	organic black pepper	12
4175	organic fennel.	231
4176	Semi-sweet chocolate	118
4177	waster	5
4178	light whipping cream cream	473
4179	mono and diglyce	234
4180	cinnamon drops sugar	15
4181	cont	263
4182	vitamin d3.	1184
4183	margarine soybean oil	243
4184	Ultrafiltered nonfat milk	1185
4185	lactase enzyme	1186
4186	vitamin a palmitate and vitamin d3.	1187
4187	vitamin a palmitate and vitamin d3	1187
4188	Pasteurized homogenized milk and vitamin d3.	7
4189	Pasteurized homogenized reduced fat milk	1188
4190	Pasteurized nonfat milk	887
4191	Cultured milk	735
4192	and vitamin d3.	1189
4193	Organic milk	7
4194	organic skim milk and vitamin d3.	7
4195	organic skim milk	7
4196	organic cocoa processed with alkali	118
4197	whole organic soybeans	256
4198	carragenan	206
4199	vitamin d2	1190
4200	vitamin b12.	1191
4201	Pasteurized homogenized lowfat milk	994
4202	vit. a palmitate and vit. d3.	1187
4203	carrageenan and artificial flavors.	206
4204	cultured cream	1037
4205	cultured dextrose	750
4206	sorbic acid to maintain freshness	854
4207	less than 2% corn starch	263
4208	sorbic acid to preserve freshness	854
4209	sorbic acid to maintain freshness.	854
4210	Ingredients: cultured skin milk	735
4211	carraceenan	206
4212	polysorbate 80 and vitamin a palmitate.	1171
4213	milk protein isolate	291
4214	and active cultures with l acidophilus and b. bifidum.	867
4215	key lime puree	1119
4216	whey protein isolate	387
4217	turmeric for color gelatin	383
4218	cultured dext	750
4219	and active cultures with l. acidophilus and b. bifidum.	867
4220	Cultured lowfat milk	735
4221	pomegranate juice	406
4222	and vitamin d3 and active cultures l active cultures l acidophilus and b. bifidum.	1189
4223	and active cultures with l. acidophilus and b. bifidum	867
4224	concentrated peach puree	1192
4225	natural and artificial modified corn starch	561
4226	turmeric and annatto extract for color	175
4227	and active cultures with l acidophilus and b. bifidum	867
4228	annatto and turmeric extract for color	236
4229	and active cultures with l. acidophillus and b. bifidum	867
4230	banana puree	136
4231	vitamin a	562
4232	palmitate	1174
4233	and active cultures with acidophilus and b. bifidum.	867
4234	ad active cultures with l acidophilus and b. bifidum.	867
4235	cultures milk and nonfat milk modified corn starch	1193
4236	natural flavor gelatin tricalcium phosphate	459
4237	sucralsoe	399
4238	asesulfame potassium	306
4239	and active cultures with l . acidophilus and b. bifidum.	867
4240	turmeric and annatto extracts for color	175
4241	vitamin a palamitate	1171
4242	black cherries	1194
4243	blue and active culture l acidophilus and b. bifidum.	295
4244	and active cultures l. acidophilus and b. bifidum	867
4245	yellow 5 and active cultures l. acidophilus and b. bifidum	976
4246	citric aicd	200
4247	blueberry puree	411
4248	agar cultured dextrose	750
4249	acesulfate potassium	1195
4250	and active culture with l acidophilus and b. bifidum.	867
4251	Cultured ultrafiltered nonfat milk	7
4252	vitamin a palmitae	562
4253	and active cultures with l. acidphilus and b. bifidum.	867
4254	and active cultured with l. acidophilus and b. bifidum.	295
4255	sucralose neotame	399
4256	Cultured ultrafiltered nonfat	7
4257	rebaudioside-a	923
4258	and active cultures with l acidophlus and b. bifidum.	295
4259	contains 2% or less of each of the following: baking powder sodium acid pyrophosphate	780
4260	sodium bica	1196
4261	Heavy cream heavy cream	52
4262	cream cheese pasteurized milk and cream	30
4263	stabilizers carob bean and/or xanthan and/or guar gums	390
4264	colored with annatto	722
4265	calcium dis	203
4266	peanut butter cups milk chocolate sugar	1
4267	soy lecithin and pgpr {emulsifiers}	185
4268	yellow cake sugar	170
4269	sodium acid pyrophosph	518
4270	Cake sugar	170
4271	folic acid egg whites	727
4272	cocoa alkali processed	118
4390	active cultu	1216
4273	contains less than 2% of the following: leavening baking	17
4274	modified corn starch. contains 2% or less of partially hydrogenated soybean and c	561
4275	and skim milk	472
4276	calcium sulfate and locust bean gum.	924
4277	Ingredients: cultured cream	473
4278	Cultured cream and skim milk enzymes.	295
4279	Cultured pasteurized skim milk and cream	7
4280	corn starch modified	561
4281	potassium sorbate to maintain freshness.	338
4282	Cultured skim milk and cream	735
4283	propylene glycol monoester	1128
4284	anhydrous milkfat	1197
4285	rosemary extract	89
4286	vitamin a palmitate. adds a trivial amount of fat	1171
4287	Cultured cream and skim milk. whey	640
4288	minced onion	9
4289	calcium stearate	927
4290	and citric acid.	200
4291	Cultured cream and skim milk	1198
4292	partially hydrogenated vegetable oil soybean and/or canola oil	881
4293	monosodium glutamate and potassium sorbate preservatives.	708
4294	milk isolate cream	1199
4295	gleatin	459
4296	sodium malic acid	345
4297	vitamin a palimite cultures with l. acidophilus and b. befitin.	1171
4298	skim milk modified corn starch	332
4299	concentrated orange juice.	65
4300	Reduced acid orange juice	65
4301	and beta carotene.	590
4302	not from concentrate orange juice calcium citrate	65
4303	beta-carotene for color	590
4304	Grapefruit juice.	200
4305	ascorbic acid vit. c	329
4306	vit d3.	1189
4307	ascorbic acid lemon pulp	329
4308	concentrated orange and pineapple juice.	1200
4309	orange pulp.	65
4310	vit. d3.	1189
4311	decaffeinated cut black tea concentrate	365
4312	decaffeinated cut black tea	365
4313	and carrageenan.	206
4314	sucralose acesulfame potassium	399
4315	quinine	1201
4316	potassium sulfate.	1202
4317	phophoric acid	770
4318	dextrose and calcium sulfate added to prevent caking	750
4319	natamycin  a natural mold inhibitor.	1008
4320	Pasteurized part -skim milk	1203
4321	Pepper jack cheese pasteurized milk	1009
4322	pasteurized process cheese food with jalapeno peppers monterey jack cheese pasteurized milk	1204
4323	swiss cheese pasteurized part-skim milk	1205
4324	enzymes. aged over 60 days	920
4325	sodium citrate water	477
4326	pimentos sorbic acid preservative	854
4327	pinnatto for color	383
4328	Reduced fat monterey jack	1206
4329	cheddar	32
4330	colby and mozzarella cheese pasteurized part-skim milk	1009
4331	if colored	174
4332	dextrose and calcium sulfate added to prevent caki	750
4333	Colby cheese pasteurized milk	1207
4334	monterey jack cheese pasteurized milk	1208
4335	Mild cheddar cheese pasteurized milk	32
4336	annatto for colon	722
4337	pastes/ed process american cheese american cheese pasteurized milk	1209
4338	low moisture part skim mozzarella cheese pasteurized part skim milk	531
4339	salt calcium chloride	340
4340	natanycin a natural mold inhibitor.	1008
4341	calcium chloride enzymes	340
4342	dextrose and calcium sulfate added to man' caking natamycin a natural mold inhibitor.	750
4343	Part-skim milk	1205
4344	natamycin a natural mold inhibitor	1008
4345	aged over 60 days.	1210
4346	turmeric extract	175
4347	cheese culture. salt	1106
4348	Montery jack cheese pasteurized milk	1211
4349	cheese culture salt	148
4350	cheddar cheese oasteurized milk	32
4351	queso quesadilla and asadero cheese pasteurized milk	1009
4352	potato strach	519
4353	corn strach	263
4354	dextrose and natamycin a natural mold inhibitor.	750
4355	Low moisture part-skim mozzarella pasteurized part-skim milk	531
4356	smoke flavor provolone cheese pasteurized milk	1007
4357	smoke flavoring	880
4358	romano cheese aged over 5 months pasteurize	969
4359	acesulfame 0 potassium	855
4360	vitamins d3.	1189
4361	vitamin a paumitate	430
4362	cocoa processes with alkali	118
4363	annatto for color. cookie	722
4364	polysorbate 80.	613
4365	mono & diglycerides polysorbate 80.	341
4366	carrageenan. mono & diglycerides	206
4367	calcium sulfate and locust bean gum	924
4368	vitamin a plamitate	1171
4369	skim milk vitamin a palmitate	1171
4370	modified corn and potato starch	519
4371	dextrose and cal	750
4372	Organic orange juice	65
4373	organic orange pulp.	1212
4374	Organic orange juice.	65
4375	potassium starch	1213
4376	edta to preserve freshness.	455
4377	organic cream	473
4378	active cultures with l. acidophilus and b. bifidum	867
4379	active cultures with l. acidophilus and b. bifidum.	867
4380	cherry cultured skim milk	7
4381	sugar juice	170
4382	pecin	337
4383	boysenberry puree	1214
4384	black carrot juice for color	590
4385	active cultures with l. acidophilus	867
4386	b. bifidum.	1215
4387	b. bifidum	1215
4388	mangoes	190
4389	active cultures with l. aci	295
4391	strawberry	448
4392	plum puree	1217
4393	ac	480
4394	modified corn starch and potato starch	519
4395	locustbean gum	339
4396	cream skim milk	472
4397	vitamin a palmitate. candy blend - sugar	1171
4398	partially hydrogenated soybean oil and/or safflower oil and/or almond oil and/or canola oil	243
4399	vitamin a palmitate cookie pieces - enriched flour wheat flour	131
4400	vegetable oil soybean	243
4401	palm oil with citric acid	201
4402	palm kernel with tbhq for freshness	286
4403	roasted pecans pecans	49
4404	propylene glycol monsters	616
4405	cream. maltitol	473
4406	vitamin a palmitate. chocolate peanut butter cup - coconut oil	1171
4407	lactitol	1218
4408	natural flavors. chocolate swirl - water	1004
4409	glycerol polydextrose	922
4410	sucralose enzymes	399
4411	hydrogenated coconut oil	135
4412	hydrolyz	1219
4413	Yogurt: cultured ultrafiltered nonfat milk	7
4414	chicory root extract inulin	1220
4415	and active cultures with l. acidophilus and b. bifidum. fruit and vegetable: water	867
4416	vitamin d3 and active cultures with l. acidophilus and b. bifidum. fruit and vegetable: water	1189
4417	red	1221
4418	zu	87
4419	acesulfame potassium sugar	855
4420	active cultures with l. acidophil	867
4421	cultures skim milk	472
4422	mango juice concentrate	425
4423	annatto and turmeric color	236
4424	lactase glycerol	234
4425	en	671
4426	vegetable juice color	768
4427	skin milk	472
4428	acesulfame potassiu	855
4429	acesulfame pota	855
4430	active cultures with l. acidoph	867
4431	vitamin 03.	650
4432	fructose corn syrup	344
4433	annatto and turmeric extractives color.	1222
4434	black walnuts	1223
4435	mono-and diclycerides	729
4436	blue 1. choco chip - sugar	1
4437	cocoa salt	148
4438	mono and diclycerides locust bean gum	1224
4439	polysorabate 80	613
4440	roasted almonds almonds partially hydrogenated soybean oil and/or safflower oil and/or almond oil and/or canola oil	60
4441	annatto extract color	722
4442	palm kernel oil with tbhq for freshness	286
4443	imvert sugar	471
4444	mono- and diglycerides locust bean gum	339
4445	celllulose gum	600
4446	natural flavor contains soy	142
4447	artificial and natural flavor	316
4448	ascorbic acid. nuts and fruit mixture - roasted pecans pecans	329
4449	red 40. choco fudge - high fructose corn syrup	344
4450	stabilizer modified corn starch	561
4451	modified buttermilk powder	1024
4452	carboxymethylcellulose.	600
4453	corn syrup concentrated lime juice	61
4454	methyl cellulose	1225
4455	polysorbate 80 pectin	337
4456	mono and diclycerides	729
4457	sweetened condensed milk milk	523
4458	salt soy lecithin	148
4459	whwy	193
4460	vegetable oil peanut and/or cottonseed palm oil	26
4461	fudge cups - sugar	1
4462	Ice cream-milk	7
4463	chocolate cookie crumb variegate - soybean oil	243
4464	cookie crumb enriched flour wheat flour	131
4465	palm and palm kernel oil	201
4466	soy lecithin sugar	185
4467	and vanillin.	186
4468	annatto for colo	722
4469	salt. brownie swirl - powdered sugar sugar	140
4470	soy lecithin. brownies - sugar	185
4471	unenriched wheat flour	131
4472	mono- and diclycerides	729
4473	carrageenan. french vanilla ice cream - milk	206
4474	blueberry	411
4475	mono-& diglycerides	729
4476	locust beans gum	205
4477	vanilla cream swirl - corn syrup	596
4478	sweetened condensed skim milk skim milk	523
4479	titanium oxide	369
4480	fudge pieces - sugar	1
4481	mango puree concentrate	1226
4482	Frozen dairy dessert - milk	7
4483	sugar cream	1
4484	corn syrup peanuts	173
4485	whey brown sugar	193
4486	partially hydrogenated palm oil	1143
4487	yellow 6. nestle baby ruth pieces - sugar	1
4488	coconut and soybean oils	1227
4489	milk cocoa	118
4490	salt monoglycerides	1228
4491	caramel color. caramel swirl - corn syrup	357
4492	Beef and natural flavorings.	33
4493	yellow 5and 6.	786
4494	modified starch corn	866
4495	tapioca	1229
4496	polysorbate	1076
4497	caramel color. ch	357
4498	caramel color. fudge swirl: h	357
4499	Nonfat sherbet: sim milk	887
4500	p	755
4501	cellose gum	600
4502	vitamin a pal	562
4503	vitamin a palmita	562
4504	ye	294
4505	pectin.	337
4506	sucralo	399
4507	peanut butter ground peanuts	123
4508	poly	1230
4509	partially hydroge	5
4510	ni	466
4511	non-hydrogenated palm kernel oil sugar	286
4512	enriched flour	816
4513	Nonfat sherbet - skim milk. sugar	1
4514	butter-milk	72
4515	Nonfat sherbet - skim milk	887
4516	Frozen yogurt - cultured pasteurized milk and skim milk	7
4517	annatto for color. chocolate fl	1231
4518	orange juice from concentrate	65
4519	beet juice extract and turmeric for color.	1232
4520	Strawberry pops: water	5
4521	strawberry juice concentrate	1233
4522	beet juice concentrate and turmeric for color. raspberry pops: water	1234
4523	blue 1. orange pops: water	5
4524	Ingredients: ice cream: milk	7
4525	buttermilk. maltodextrin	197
4526	mono- and diglycerides. guar gum	1235
4527	sucralose. wafers: bleached whea	399
4528	sucralose. chocola	399
4529	annatto for color. chocolate flavored coati	722
4530	sucralose. cgips - sugar	399
4531	Ice cream: - milk	7
4532	natural and artificial fl	316
4533	cellulose powder added to prevent caking	740
4534	potassium sorbate to protect flavor.	338
4535	romano cheese from cow's milk cultured part-skim milk	969
4536	salt enzymes	148
4537	penicillium roquefortii	1236
4538	Cheddar cheese pasteurized milk cheese culture	32
4539	aged over 60 days	1210
4540	cream jalapeno pepper	1160
4541	annato for color	236
4542	Pasturized milk	1009
4543	annatto for colo.	722
4544	.	1
4545	Pasteurized part skin milk	1009
4546	penicillium roquefortill	1236
4547	Colby and monterey jack cheeses pasteurized milk	1009
4548	anntto for color.	236
4549	dehydrated red and green bell peppers	536
4550	quesco quesadilla and asadero cheeses pasteurized milk	1237
4551	powdered cellulose to prevent caking.	740
4552	Skim milk cheese for manufacturing pasteurized skim milk	640
4553	sorbic acid preservative and carrageenan.	854
4554	American cheese pasteurized milk	1009
4555	low moisture part-skim mozzarella cheese pasteurized part-skin milk	531
4556	modified whey	193
4557	oleoresin capsicum.	195
4558	Swiss cheese part skim milk	1238
4559	monterey cheese pasteurized milk	1208
4560	preservative	401
4561	Colby	1239
4562	cheddar and monterey jack cheese pasteurized milk	1009
4563	contains 2% or less of: carob bean gum	205
4564	calcium propionate and potassium sorbate preservatives	1240
4565	less than 2% of potassium lactate	1068
4566	contains less than 2% sodium lactate	1097
4567	contains less than 2% of potassium lactate	1068
4568	seasoning yeast extract	209
4569	potassium acetate	1241
4570	potassium lactate. rubbed with: spices including allspice	1068
4571	thyme brown sugar	44
4572	Beef.	33
4573	Ground white turkey	1095
4574	natural flavoring.	407
4575	Uncured smoked ham contains 20% added solution of water	5
4576	crackers enriched wheat flour wheat flour	131
4577	Smoked turkey turkey	1242
4578	vinegar lemon juice concentrate	200
4579	spice extract. crackers enriched wheat flour wheat flour	199
4580	sunflower o	147
4581	Minced shrimp	86
4582	corn and/or cottonseed	243
4583	ribo	818
4584	Bison round.	1243
4585	Ground bison.	1244
4586	Bison chuck.	1245
4587	Bison ribeye	1246
4588	Bison sirloin.	1247
4589	Turkey	1095
4590	raw sugar	170
4591	modified corn starch. contains less than 2% of: wheat gluten	561
4592	cellulose gum. topping: chocolate chips sugar	600
4593	Organic beef.	33
4594	Both cheesecake flavors: cream cheese milk	30
4595	contains less than 2% of: hydrogenated coconut oil	1248
4596	strawberry swirl also contains: strawberries	448
4597	carrot and currant juices color	1056
4598	white chocolate flavored raspberry also contains: butter cream	208
4599	white confectionary drops sugar	170
4600	carrot and blueberry juices color	590
4601	sodium benzoate preservative. chocolate tuxedo also contains: margarine soybean oil	354
4602	microbial rennet	718
4603	annatto coloring.	722
4604	microbial enzymes	1063
4605	microbial rennet.	718
4606	maltodextrin. contains 2% or less of: salt	197
4607	monterey jack cheese pasteurized nonfat milk and milkfat	1204
4608	green chiles	66
4609	contains 2% or less sea salt	98
4610	dried vinegar powder	480
4611	sodium ph	594
4612	carotenal color	1249
4613	bacon cured with water	148
4614	hickory smoke flavor	749
4615	natural bacon flavor maltodextrin	197
4616	rendered bacon fat and bacon bits cured with water	140
4617	natural smoke flavor partially hydrogenated soybean oil	243
4618	natural flavor contains natural smoke flavor	268
4619	mango mango	190
4620	sulfur dioxide added for color retention and as a preservative	306
4621	Seared and seasoned chicken thigh chicken thigh meat	57
4622	cola syrup cane sugar	1
4623	flavor and lemon juice concentrate	316
4624	sodium carbonate	512
4625	verde sauce water	5
4626	green ch	1250
4627	contains 2% or less of aspartame	1251
4628	contains 2% or less of: aspartame	1251
4629	natural and artificial flavor with bha	316
4630	contains 2% or less of:aspartame	1251
4631	modified tapioca and corn starch	1252
4632	tetrasodium pyrophosphate	879
4633	contains 2% or less of: mono-and diglycerides	729
4634	disodium phosphate salt	1253
4635	tetrasodium pyrophoaphate	518
4636	color red 40	677
4637	Ground beef	33
4638	Beef and natural flavorings	33
4639	Decaffeinated black tea.	365
4640	calcium disodium edta preservatives	455
4641	sweet pickle cucumbers	122
4642	Cooked macaroni enriched semolina wheat flour	451
4643	folic acid egg white	727
4644	sweet pickl	1
4645	mustard water	1254
4646	xanthan gu	265
4647	Cooked macaroni semolina wheat flour enriched with niacin	131
4648	sweet	1
4649	turmeric and paprika annatto	383
4650	Cooked macaroni enriched semolina wheat flour flour	451
4651	swee	1
4652	mustard	95
4653	contains less than 2% of: xanthan gum	265
4654	Red potatoes	279
4655	sour cream milk	25
4656	car	529
4657	less than 2% of: vinegar	73
4658	buttermilk flavor sweet whey powder	1025
4659	salad dressing soybean oil	243
4660	less than 2% of: onion	9
4661	hard cooked eggs eggs	14
4662	sw	1
4663	hard cooked eggs	1255
4664	celer	27
4665	turmeric and pa	383
4666	Turkey stock water	5
4667	turkey base turkey meat including natural turkey juices	1095
4668	turkey stock	1256
4669	thiam	1085
4670	vegetable shortening palm and/or cottonseed and/or canola oil	26
4671	contains 2% o	1257
4672	contains 2%	401
4673	liquid invert sugar	471
4674	buttermilk partly skimmed milk	1258
4675	bacterial culture	1259
4676	modified ta	420
4677	partially hydrogenated palm kernel	286
4678	hydrogenated palm	201
4679	nonfat dry milk powder	801
4680	distilled monoglyceride	592
4681	enriched wheat	143
4682	greek yogurt confectionary sugar	1
4683	vegetable fat palm kernel and/or palm	201
4684	dry nonfat greek yogurt cultured skim milk	472
4685	milk prot	640
4686	Cookie: enriched wheat flour flour	131
4687	alpha-amylase enzyme	1260
4688	mint candy pieces: sugar	1
4689	colors titaniu	369
4690	Fully cooked beef water and binder slices beef	33
4691	soy sauce wheat	39
4692	dried vinegar po	480
4693	Potatoes mayonnaise soybean oil	34
4694	sodium b	594
4695	soybean/canola oil	26
4696	orange filling cor	103
4697	pasteurized process cheddar cheese cheddar cheese milk	32
4698	apocarotenal for color	773
4699	pasteurized processed cheese blend cheddar cheese milk	32
4700	canola oil enzyme modified cheese milk	38
4701	sodium phosphate contains less than 2% of: sodium hexametaphosphate	556
4702	cream onions	9
4703	butter cream salt	148
4704	contains less than 2% of: canola oil	90
4705	parmesan cheese part-skim milk	62
4706	granular and cheddar cheese milk	640
4707	enzymes whey	193
4708	dehydrated garlic annatto extract for color	1261
4709	tortilla chips ground white corn treated with lime	1262
4710	red peppers contains less than 2% of: celery	27
4711	roasted green chiles	1263
4712	cooked	1264
4713	Clam stock	1265
4714	clams in clam juice	482
4715	contains 2% or less of: unbleached enriched wheat flour wheat flour	131
4716	sodium phosphat	770
4717	sour cream cultured cream and milk	25
4718	cultured dairy solids	1266
4719	pasteurized process cheddar cheese cheddar ch	32
4720	contains less than 2% of: sugar	170
4721	pomace olive oil	6
4722	dehydrated tomatoes	1029
4723	egg yolk flavor eggs	796
4724	annatto extract for color	722
4725	soy protein concentrate sodium phosphate	1267
4726	seasoned cooked beef crumbles beef	33
4727	cooked kidney beans	229
4728	cooked pinto beans	1268
4729	contains 2% or less of: soy sauce water	39
4730	andouille sausage pork	534
4731	hickory char oil partially hydrogenated soybean oil	243
4732	natural woodsmoke flavor	1269
4733	contains less than 2 of: green peppers	66
4734	hot sauce vinegar	480
4735	. sodium phosphate	194
4736	worcestershire sauce distilled white vinegar	73
4737	molasses water	156
4738	anchovies	1270
4739	cloves	94
4740	tamarind extract	453
4741	chili pepper extract	725
4742	dehydrated chicken stock	97
4743	lobster	1271
4744	sherry wine	1036
4745	pasteurized processed cheese blend cheddar cheese milk cultures	32
4746	enzyme modified cheese milk	1272
4747	smoked gouda cheese milk	640
4748	pomace olive	1273
4749	pasteurized process cheese blend cheddar cheese milk	32
4750	culture	1274
4751	contains less than 2% of: sodium hexametaphosphate	1275
4752	parmesan cheese part-skim milk cultures	62
4753	sour cream cultured cream and milk modified cornstarch	25
4754	sorbic acid as a preservative	854
4755	uncured bacon pork	534
4756	tubinado sugar	13
4757	seasoning dehydrated cultured celery juice	27
4758	bancon-type flavor salt	1276
4759	natural flavor egg	14
4760	sesamel	153
4794	white cheddar cheese milk	1284
4795	salt starter culture	148
4796	chicken flavor chicken stock	97
4797	spinach powder	79
4798	paprika herbs. filling: cheese ricotta	55
4799	provolone whey	193
4800	egg yolks.	796
4801	romano milk	969
4802	reconstituted lemon juice	18
4803	pine nuts	1012
4804	cheese romano and parmesan milk	640
4805	green chili peppers	1285
4806	contains less than 2% of: chipotle chili peppers	836
4807	rich	1286
4808	wild rice	1287
4809	white corn masa	134
4810	red lentils	1288
4811	cooked garbanzo beans	222
4812	carrot juice	1056
4813	flavored fruit pieces dehydrated apples	213
4814	calcium stearate flow agent	927
4815	sodium sulfite to promote color retention	1289
4816	pyriddoxine hydrochloride	525
4817	contains less than 2% of: cellulose gum	600
4818	poppyseed	745
4819	propylene glycol alginate	1290
4820	and cinnamon	15
4821	contains 2% or less of: ascorbic acid	329
4822	vegetables onion	9
4823	red and green bell peppers	195
4824	soy protein and wheat gluten	1291
4825	thiamine hydrochloride. dehydrated	468
4826	caramel color sodium sulfite to protect color.	357
4827	citric acid. dehydrated	200
4828	Black tea.	365
4829	hydrolyzed corn and soy protein	1292
4830	calcium propionate preservative. dried	911
4831	Ingredients: degerminated white corn grits	134
4832	dehydrated cheese powder	38
4833	coconut and/or cottonseed	135
4834	ferric phosphate	251
4835	potassium phosphate.	848
4836	dried margarine partially hydrogenated soybean oil	243
4837	sodium caseinate mono-and diglycerides	847
4838	tbhq antioxidant	1082
4839	soy lecithin bha and citric acid as preservatives	185
4840	Ingredients: white hominy grits	134
4841	dried green chilies	1293
4842	dried onion.	9
4843	contains 2% or less of: natural smoke flavors	268
4844	fennel basil	231
4845	bay	114
4846	marjoram	42
4847	savory	1294
4848	spice extractives. less than 2% soybean oil added to prevent caking.	1295
4849	lemon oil. less than 2% soybean oil added to prevent caking.	910
4850	lemon juice powder	200
4851	less than 2% soybean oil added to prevent caking.	243
4852	contains 1% or less of: spice	198
4853	Ingredients: tomato puree water	487
4854	corn-cider vinegar	480
4855	contains 2% or less of: water	5
4856	mofified tapioca starch	757
4857	salt. contains less then 2% spices	148
4858	sour cream powder cultured cream and nonfat milk	1015
4859	phosporic acid	770
4860	potassium disidium inosinate and disodium guanylate	1296
4861	calcium disodium inodinate and disodium guanylate	1297
4862	Crushed tomatoes tomato concentrate	717
4863	partially hydrogenated soybean/cottonseed oil	881
4864	tetrasodium pyrophosphate. contains 2% or less of: disodium phosphate	879
4865	contains 2% or less of: tetrasodium pyrophosphate	879
4866	emulsifier mono- and diglycerides. nonfat milk	729
4867	sodium phosphate. contains less than 2% of adipic acid	194
4868	contains 2% or less of: adipic acid	1061
4869	contains 2% or less of: fumaric acid	421
4870	turmeric oleoresin for color	175
4871	CONTAINS 2% OR LESS OF: DISODIUM PHOSPHATE	1253
4872	COLOR YELLOW 6.	794
4873	red 40 and blue 1.	799
4874	Gelatin.	459
4875	salt. contains 2% or less of: nonfat milk	140
4876	salt. contains 2% or less of : dried garlic	1298
4877	dried red bell peppers	195
4878	tomato paste concentrate	83
4879	contains 2% or less of: modified corn starch	332
4880	propylene glycol algimate.	1290
4881	molasees	156
4882	caramel color. contains 2% or less of: natural smoke flavors	357
4883	dried onion and paprika.	9
4884	sorbic acid and sodium benzoate preservatives	854
4885	phosphate acid.	770
4886	orange juice	65
4887	citric acid and sodium citrate.	200
4888	Apple juice corn syrup	596
4889	and fruit pectin.	1022
4890	Blackberry juice	489
4891	Strawberry juice	1233
4892	and sodium citrate.	477
4893	citric acid and sodium citric.	200
4894	Sugar and cinnamon.	1
4895	soybean oil with tbhq added to protect freshness	243
4896	less than 2% of hydrolyzed soy protein	276
4897	dried yeast	698
4898	hydrogenated vegetable protein hydrolyzed soy and corn protein	1292
4899	partially hydrogenated vegetable oil cotton seed oil and soybean oil	881
4900	calcium propionate preservative. dried.	911
4901	hydrolyzed con protein	1292
4902	degermed cornmeal	149
4903	milk whey	193
4904	sodium a	594
4905	precooked tapioca	757
4906	Grapes	1299
4907	sugar citric acid	200
4908	Ingredients:soybean oil	243
4909	cucumber juice	1300
4910	clacium disodium edta to protect flavor.	455
4911	dehydratwd red bell pepper	84
4912	spice caramel color	357
4913	lemon juice concebtrate	200
4914	cultured buttermilk solids. contains 2% or less of: dried onion	1301
4915	alginate	1290
4916	monosodium gglutamate	630
4917	potassium calcium disodium edta to protect flavor.	455
4918	dried garlic and citric acid.	4
4919	with tbhq added to protect freshness	1082
4920	less than 2% of:hydrolyzed soy protein	276
4921	hydrolyzed vegetable protein hydrolyzed soy and corn protein	1292
4922	partially hydrogenated vegetable oil cottonseed oil and soybean oil	881
4923	contains 2% or less of: natural flavor	1302
4924	soy sauce	39
4925	green chili powder. dehydrated	195
4926	natural and artificial flavor carnauba wax	415
4927	blue 1 yellow 6	795
4928	blue 2.	507
4929	Lemon juice concentrate  water concentrate lemon juice	18
4930	sodium bisulfate preservative	1289
4931	Lemon juice concentrate water	18
4932	sodium benzonate preservative.	454
4933	Naturally brewed soy sauce water	39
4934	sesame sticks flour unbleached wheat flour	131
4935	partially hydrogenated cottonseed and/or soybean oils	881
4936	bulgur wheat	914
4937	Ingredients: tomato puree tomato paste	487
4938	contains less than 2% of spices	834
4939	sodium benzoate preservatives.	454
4940	calcium stearate.	927
4941	color paprika	55
4942	lowfat buttermilk cultured lowfat and milk	1303
4943	sugar. contains 2% or less of: salt	1
4944	cellulose gel and gum	740
4945	dried green onion	870
4946	dl-alpha tocopheryl acetate vitamin e	169
4947	calcium disodium edta to protect flavor.  contributes a trivial amount of fat.	455
4948	tapioca maltodextrin	197
4949	contains 2%n or less of: soy lecithin	185
4950	maltol	614
4951	colortitanium dioxide	369
4952	acesulfame potassium.	855
4953	tetrasodium pyrophosphate natural and artificial flavor	879
4954	color titanium dioxide	369
4955	tetrasodium phosphate	1304
4956	contains 2% or less of: cellulose gum	600
4957	em	796
4958	color caramel	357
4959	emulsifie	292
4960	sage	1305
4961	green bell pepper sulfur dioxide for color retention.	306
4962	hydrolyzed soy protein sodium erythorbate	363
4963	sodium ascorbate and sodium nitrate	1306
4964	beef extract	1307
4965	propylene glycol aldinate	1308
4966	calcium disodium	594
4967	edta  to protect flavor.	455
4968	dehydrated garlic and onions	1309
4969	less than 2% of: cottonseed oil and silicon dioxide anticaking agent.	631
4970	and less than 2% of silicon dioxide. dehydrated	309
4971	Seasoned salt	148
4972	contains 2% or less of: poppy seeds	1310
4973	potassium sorbate preservative preservative	338
4974	beta-apo-8' -carotenal for color.	1114
4975	Salt salt	148
4976	sodium silicoaluminate	1311
4977	potassium iodide	913
4978	Degerminated yellow corn	134
4979	Degerminated white corn	134
4980	sodium benzoate and sorbic acid preservatives	1312
4981	Made with roasted peanut and sugar	137
4982	contains 2% or less of molasses	156
4983	Made with roasted peanuts and sugar. contains 2% or less of molasses	156
4984	hydrolyzed soybean and corn protein	1292
4985	and less than 2% of silicon dioxide anticaking agent.	631
4986	natural flavor with oleoresin paprika for color	210
4987	disodium inosinate and disodium guanylate. dehydrated	1039
4988	natural flavors with oleoresin paprika for color	1313
4989	spices including chili pepper	710
4990	caramel color contains sodium bisulfite	357
4991	disodium guanylate. dehydrated	1006
4992	natural grill smoke and other natural flavors	1314
4993	spices including chili pepper. contains less than 2% of: citric acid	710
4994	partially hydrogenated cottonseed and soybean oil	881
4995	dehydrated lime juice concentrate	61
4996	lime oil.	1315
4997	malt vinegar	480
4998	raisin concentrate	1167
4999	apple concentrate	373
5000	sodium benzoate & potassium sorbate preservative	454
5001	white pepper	960
5002	Ingredients: prepared blackeyed peas	1316
5003	disodium edta added to promote color retention.	455
5004	Ingredients: prepared kidney beans	605
5005	disodium edta to promote color retention.	455
5006	Ingredients; prepared kidney beans water	605
5007	disoduim edta to promote color retention.	981
5008	Prepared white beans	1317
5009	disodium edta for color retention.	455
5010	Ingredients: prepared red beans	1318
5011	calcium disodium edta added to promote color retention.	455
5012	Prepared lima beans	228
5013	calcium disodium edta to promote color retention.	455
5014	rendered beef fat with citric acid and bha to protect flavor	1319
5015	yeast extract. contains 2% or less of soy sauce soybeans	209
5016	caramel color ammonia sulfite to protect color	357
5017	turmeric and oleoresin paprika for color	175
5018	silicon dioxide anti-caking agent. dehydrated	309
5019	Organic rolled oats.	78
5020	chicken fat. contains 2% or less of onion	1148
5021	sweet cream	473
5022	silicon dioxide added to make free flowing	309
5023	extractive of sage	1320
5024	soy lecithin. dehydrated.	185
5025	chicken fat powder rendered chicken fat	1148
5026	propyl gallate	1321
5027	and citric acid added to improve stability. contains 2% or less of disodium inosinate and disodium guanylate	200
5028	cream solids	473
5029	caramel color sodium sulfite to protect color	357
5030	and silicon dioxide anticaking agents. dehydrated	631
5031	hydrolyzed corn gluten and torula yeast extract	630
5032	beef fat shortening rendered beef fat	1319
5033	bha and citric acid	200
5034	onion and garlic. contains less than 2% of natural and artificial flavors	670
5035	caramel color sulfur dioxide used to protect quality	306
5036	partially hydrogenated soybean and cottonseed oil. dehydrated	881
5037	adds a trivial amount of fat.	668
5038	soy protein and whet gluten	1322
5039	garlic and onion. contains 2% or less of caramel color sodium sulfite to promote color retention	1323
5040	disodium guanylate. dehydrated adds a trivial amount of fat	1005
5041	turmeric. dehydrated	175
5042	Chili pepper and other spices	195
5043	extractive of paprika for color. dehydrated	55
5044	silicon dioxide anti-caking. dehydrated	631
5045	hydrolyzed corn gluten and soybean protein and wheat gluten	1292
5046	spices. contains 2% or less of autolyzed yeast extract	834
5047	partially hydrogenated soybean and cottonseed oil	1165
5048	caramel color sodium sulfite	357
5049	citric acid. dehydrated. adds a trivial amount of fat	200
5050	partially hydrogenated cottonseed and soybean oil. dehydrated adds a trivial amount of fat	881
5051	and black pepper	10
5052	mushrooms. contains 2% or less of paprika	46
5053	cultu	735
5054	red 40. dehydrated adds a trivial amount of fat	677
5055	parmesan cheese flavor parmesan cheese pasteurized milk	62
5056	tocopherols and ascorbyl palmitate to protect flavor	154
5057	partially hydrogenated vegetables cottonseed	1142
5058	soybean oil.	243
5059	salt. contains 2% or less of cultured buttermilk powder buttermilk	140
5060	natural and artificial flavor contains wheat	143
5061	and citric acid added to improve stability	200
5062	instant coffee	585
5063	caramel color sulfur dioxide used to protect quality.	306
5064	hydrolyzed corn gluten and soy protein and wheat gluten	1292
5065	chicken fat. contains 2% or less of whey	1148
5066	caramel color sodium sulfite to promote color retention	357
5067	propyl gallate added to improve stability	1321
5068	dipotassium phosphate. dehydrated. adds a trivial amount of fat.	779
5069	red bell peppers	836
5070	grill flavor from partially hydrogenated soybean oil	243
5071	Concord grapes	1324
5072	tapioca starch.	1325
5073	contains 1% or less of: parsley	22
5074	Unsalted almonds	60
5075	Ingredients: soybean oil water	243
5076	salt. contain	148
5077	Ingredients: prepared pinto beans	1326
5078	Ingredients: prepared black beans	1116
5079	contains less than 2% of: chili powder chili peppers	195
5080	mustard flour.	1327
5081	Lime juice rom concentrate water concentrate lime juice	61
5082	sodium aftertaste preservative	354
5083	sodium benzoate preservative natural flavor.	354
5084	ammonium bisulfite for color.	426
5085	lemon juice from concentrate	200
5086	dried minced onion	9
5087	and beta carotene for color.	478
5088	Fruit syrup	163
5089	grape juice concentrate for color	345
5090	calcium citrate.	1011
5091	and calcium citrate.	1011
5092	contains less than 2% of: tomato paste	83
5093	paprika coloring	55
5094	Ingredients: prepared white beans	1317
5095	artificial flavor. vitamins and minerals: calcium carbonate	637
5096	copper gluconate	1328
5097	manganese sulfate	1329
5098	and pyridoxine hydrochloride	525
5099	Ingredients: maltodextrin	197
5100	buttermilk  buttermilk	72
5101	whey  monosodium glutamate	630
5102	butter  butter cream	2
5103	xanthan and guar gum	265
5104	Ingredients: sugar	170
5105	bell pepper sodium sulfite to promote color retention	1075
5106	citric acid.  dheydarated	200
5107	and celery seed	931
5108	silicon dioxide a free flow agent.	309
5109	carboxymethylcellulose	882
5110	carboxymethycellulose	1330
5111	contains 2% or less of: orange juice concentrate	65
5112	apple juice	322
5113	tannic & citric acids	1331
5114	hickory smike	1314
5115	caramel color contains sulfur dioxide to promote color retention.	357
5116	contains 2% or less of the following	140
5117	cracked black pepper	12
5118	salt. contains less than 2% of: carrageenan	140
5119	papaya puree and juice contains less than 2% of dried onion	9
5120	dried cilantro	1332
5121	dried garlic modified corn starch	332
5122	spice including allspice	124
5123	and chili pepper	195
5124	tamarind sugar	453
5125	xanthan gum potassium sorbate and sodium benzoate preservatives	265
5126	pleoresin  parika for color	55
5127	artficial color	648
5128	ammonium bisulfite	426
5129	mandarin orange juice from concentrate	1333
5130	natural sesame flavor	153
5131	ammonium bisulfite for color	426
5132	mango juice from concentrate	425
5133	potassium sor-bate and sodium benzoate preservatives	803
5134	papaya puree	1334
5135	ginger puree	28
5136	dried bell pepper	536
5137	lowfat buttermilk enriched lowfat and skim milk	1335
5138	parmesan and cheddar cheese milk	640
5139	cheddar and blue cheese milk	640
5140	autolized yeast	1336
5141	yellow 5 & 6	786
5142	dried garlic acid	1337
5143	sodium banzoate and potassium sorbate preservatives	926
5144	contains less than 2% of: sea salt	98
5145	carrot juice concentrate	1056
5146	onions.	9
5147	chicken flavor contains other natural flavor	1278
5148	onion juice concentrate	9
5149	celery juice concentrate	1144
5150	beef broth	1338
5151	natural beef flavor	1307
5152	beef fat	1319
5153	beef extract.	1307
5154	Vegetable blend water	5
5155	carrot powder	119
5156	extract of carrot.	1339
5157	contains less than 2% of sodium caseinate milk derivative	847
5158	and sucralose	399
5159	Water soybean oil	243
5160	salt contains less than 2% of: parmesan cheese cultured part-skim milk. salt and enzyme modified cultured romano cheese cultured milk. salt	140
5161	tomatoes modified cultured cream	473
5162	gum phosphoric acid natural flavors. potassium	1340
5163	contains 2% or less of: buttermilk	295
5164	salt bha	354
5165	cultured skim milk sour cream powder cream	25
5166	fruit peaches	444
5167	pears	788
5168	sodium benzoate to preserve freshness	354
5169	salt. potassium sorbate preservative	140
5170	natural & artificial flavor dextrose	750
5171	carbohydrate gum	1341
5172	red 40. yellow 5	403
5173	Cultured sour cream pasteurized homogenized cultured cream	25
5174	milk solids nonfat	777
5175	potassium sorbate to retard spoilage	338
5176	parmesan cheese cultured milk	62
5177	cellulose anti-caking	740
5178	natamycin salt	1008
5179	lemon juice lemon juice concentrate	200
5180	sweet cream buttermilk	72
5181	Whipped cream cheese pasteurized cream and milk	473
5182	and guar gum	475
5183	sugar distilled vinegar	480
5184	artichokes artichoke hearts	1342
5185	cheeses mozzarella pasteurized part-skim milk	531
5186	provolone pasteurized milk	1009
5187	powdered cellulose anti-caking agent	740
5188	parmesan cheesecultured milk	62
5189	natamycin to protect flavor	1008
5190	cultured sugar	1
5191	water garlic	1343
5192	potassium sorbateto retard spoilage	338
5193	vitamin a palmitate added. contains 2% or less of: garlic powder	1171
5194	Tomato tomatoes	240
5195	tomato juicetomato juice	450
5196	salt seasoning dehydrated onion	148
5197	fresno pepper	1344
5198	lime	85
5199	juice	1345
5200	celery salt.	148
5201	tomato juice tomato juice	450
5202	seasoning dehydrated onion	9
5203	celery salt	148
5204	capsicum	195
5205	Tomatoes tomatoes	240
5206	tomato juice	450
5207	Fire roasted tomatoes tomatoes	1346
5208	fire roasted poblano peppers	1347
5209	capsicum.	725
5210	Avocado	111
5211	jalapeno puree water	1348
5212	serrano peppers	902
5213	carrots. contains 2% or less of: bell peppers bell peppers	31
5214	sugar. contains 2% or less of: vinegar	1
5215	beta carotene and turmeric color	590
5216	calcium disodium edta and potassium sorbate preservatives.	455
5217	folic acid. contains 2% or less of salt	727
5218	sweetened condensed milk sugar	1
5219	nonfat milk solids	777
5220	Dry roasted macadamia pieces.	1349
5221	Almonds slivered	60
5222	pink schinus terebinthifolius and green peppercorns	1350
5223	extractives of paprika for color.	934
5224	polysorbate 60.	587
5225	contains less than 2% of : sodium caseinate milk derivative	847
5226	salt carrageenan	206
5227	whey corn syrup solids	193
5228	marshmallows sugar	170
5229	artificial & natural flavors	940
5230	blue 1 partially hydrogenated coconut oil	135
5231	less than 2% of: salt	140
5232	contains 1% or less of : spice	198
5233	modified corn starch monosodium glutamate	630
5234	prepared horseradish horse-radish	212
5235	xan-than gum	265
5236	contains 2% less of:dried garlic	4
5237	xanthan gim	265
5238	and potassium sorbate preservatives	338
5239	dl-al-pha tocophyral acetate vitamin e	169
5240	Filing: sugar	170
5241	baker's cheese nonfat milk	887
5242	partially hydrogenated palm kernel oil and/or coconut oil	1351
5243	emulsifier propyleneglycol mono and diesters	939
5244	yellow 6. crust: enriched flour wheat flour	794
5245	malt syrup malted barley	204
5246	Ingredients: whole grain rolled oats.	78
5247	Whole grain rolled oats.	78
5248	vegetable oil canola	90
5249	and/or soybean	1352
5250	dried whey	193
5251	modified cellulose	740
5252	sodium tripolyphosphate to retain moisture.	820
5253	diced tomatoes	240
5254	hass avocado	111
5255	contains 1% or less of each of the following ingredients: cellulose gel	740
5256	dehydrated cilantro	1353
5257	extractives of black pepper	12
5258	garlic extractives	4
5259	sodium caseinate a milk derivative	640
5260	contains 2% or less of cultured skim milk	7
5261	contains 2% or less of each of the following ingredients: partially hydrogenated soybean oil	599
5262	partially hydrogenated cottonseed oil	1142
5263	distilled white vinegar	480
5264	contains 2% or less of each of the following ingredients: whey	193
5265	bcon cured with water	1354
5266	sodium erythorbate made from sugar	775
5267	sodium nitrate a preservative.	952
5268	Oregon marion blackberries	658
5269	Sliced apples	213
5270	erythorbic acidto maintain color.	775
5271	Toppings: organic mozzarella cheese pasteurized organic grade a milk	531
5272	cheese culture non-animal rennet	718
5273	organic alfredo sauce water	5
5274	organic alfredo sauce mix organic cheddar cheese {organic pasteurized milk	7
5275	cheese	38
5276	Ingredients: whole rolled wheat	143
5277	freeze dried blueberries	1355
5278	freeze dried strawberries	448
5279	freeze dried raspberries.	208
5280	Ingredients: whole rolled oats	78
5281	color annatto	722
5282	Ingredients: organic whole rolled oats	78
5283	organic milled cane sugar	170
5284	vegetable oil canola and/or saffolower and/or sunflower oil	26
5285	organic rice flour	138
5286	organic barley malt syrup	635
5287	organic baobab powder	1356
5288	vegetable oil canola and/or safflower and/or sunflower oil pumpkin seeds	26
5289	dried apples	1027
5290	cinnamon bark	15
5291	spice blend cinnamon	15
5292	Whole grain oat flour includes the oat bran	274
5293	bht preservative. vitamins and minerals: calcium carbonate	721
5294	zinc oxide and reduced iron	1357
5295	cyanocobalamin	526
5296	cholecalciferol.	1189
5297	Whole grain corn flour	165
5298	chocolate flavored bits sugar	1
5299	alkalized cocoa	118
5300	trisodium phosphate. vitamins and minerals: calcium carbonate	194
5301	cholecalciferol	1184
5302	cyanocobalamin. bht added to packaging material to help preserve freshness.	526
5303	canola oil. contains less than 0.5% of natural flavors	90
5304	vanillin an artificial flavor. vitamins and minerals: sodium ascorbate	186
5305	cooked white chicken meat	117
5306	contains 2% or less of modified corn starch	332
5307	salted butter milk	1358
5308	color	343
5309	onion juice	9
5310	spice and coloring turmeric	175
5311	potato maltodextrin	197
5312	potassium phosphate	848
5313	cultured wheat gluten	955
5314	mannitol.	739
5315	Grade aa butter	2
5316	butter stabilizer salt	140
5317	fully cooked roasted white meat chicken	57
5318	enriched egg noodles enriched wheat flour wheat flour	131
5319	contains 2% or less of corn starch	866
5320	isolated soy protein	276
5321	cultured wheat gluten.	955
5322	onion salt	148
5323	whole grain wheat	143
5324	wheat bran freeze dried strawberries	88
5325	soluble wheat fiber	1359
5326	malted barley syrup.	1360
5327	Crust: soft wheat flour	131
5328	yeast. cheeses: low moisture mozzarella cheese pasteurized mil	294
5329	mozzarella cheese pasteurized milk	531
5330	pesto sauce:	1361
5331	fontina cheese pasteurized milk	1362
5332	enzymes. sauce: water	192
5333	yeast. cheeses: low moisture mozzarella cheese pasteurized milk	294
5334	enzymes. sauce: wate	192
5335	Ingredients:filtered water	5
5336	organic jalapeno puree organic red jalapeno peppers	1348
5337	organic white vinegar	480
5338	organic habanero pepper powder	725
5339	xanth	265
5340	Ingredients: filtered water	5
5341	organic chipolte pepper puree	1363
5342	organic chili powder	59
5343	organic ch	200
5344	ascorbic acid to protect color.	329
5345	Almondmilk filtered water	1364
5346	d-alpha-tocopherol.	169
5347	puree	449
5348	confectioner's sugar sugar	170
5349	salted butter cream milk	2
5350	pumpkin pie flavor contains soy	142
5351	pum	559
5352	spice and coloring	632
5353	sodium bicarbonate.	24
5354	vegetable oil sunflower	147
5355	potato dextrin	519
5356	leavening sodium phosphate	556
5357	black pepper extract.	12
5358	Green chile peppers	1365
5359	contains 2% or less of: citric acid and calcium chloride.	620
5360	Whole wheat flatbread: whole wheat flour	283
5361	contains 2 or less of: soybean oil	243
5362	vegetable gums	578
5363	dough conditioners mono- and diglycerides	729
5364	wheat starch. egg patty: whole eggs	1366
5365	textured vegetable protein product soy protein concentrate	276
5366	calcium pantothenate	986
5367	bha. processed sharp american yellow cheese: cultured milk and skim milk	1367
5368	soy lecithin. ham: pork cured with water	185
5369	contains 2 or less of: sodium lactate	1097
5370	sodium nitrite. processed american sharp cheese: cultured milk and skim milk	1368
5371	Fruit oregon red raspberries	208
5372	marion blackberries	658
5373	ascorbic acid to maintain color.	329
5374	Apples enriched wheat flour flour	131
5375	vegetable oil shortening palm and modified palm oils	201
5376	heavy cream cream	52
5377	glaze agar	342
5378	blackstrap molasses	156
5379	organic cider vinegar	480
5380	organic raspberry juice concentrate	961
5381	organic stone ground stone ground mustard water	95
5382	organic mustard seed	1138
5383	organic spices orga	834
5384	Orange juice.	65
5385	monop	985
5386	calcium pantothenate b	986
5387	Mackerel	1369
5388	sugar snap peas	1370
5389	dehydrated potatoes.	279
5390	asparagus	1371
5391	yellow bell peppers	836
5392	vegetable oil canola oil and olive oil	668
5393	chives.	99
5394	organic tahini	1372
5395	organic tamari sauce water	5
5396	organic white wine vinegar	480
5397	organic lemon juice concentrate	18
5398	organic toasted sesame seeds	266
5399	organic balsamic vinegar	480
5400	organic garlic puree	4
5401	organic stone ground mustard water	1373
5402	organic spices organic cinnamon	15
5403	organic ginger	28
5404	or	1374
5405	Ingredients: organic soybean oil	243
5406	organic soy sauce water	5
5407	organic wheat	143
5408	organic alcohol	384
5409	organic toasted sesame oil	112
5410	organic rice vinegar	480
5411	organic sunflower and/or safflower oil	1375
5412	organic white cheddar seasoning organic cheddar cheese organic cultured pasteurized milk	7
5413	organic buttermilk	72
5414	chicory root extract	1220
5415	vegetable oil palm kernel oil	286
5416	high oleic canola oil	90
5417	contains less than 2% of: rice starch	1154
5418	roasted sunflower s	151
5419	Three meat cocktail frank sausage made with chicken and pork	1376
5420	beef added: mechanically separated chicken	1377
5421	sodium acetate	602
5422	sodium ni	367
5423	white confectionery chunks sugar	170
5424	vegetable oil palm kernel and/or palm oils	201
5425	macadamia nuts. contains 2% or less of each of the following: water	1349
5426	reb a	1378
5427	vegetable oil canola and/or soybean oil	978
5428	contains 2% or less of: leavening sodium acid pyrophosphate	780
5429	dairy product solids	405
5430	parmesan cheese milk	7
5431	modified egg yolk egg yolks	796
5432	phospholipase	1379
5433	roasted garlic powder	4
5434	autollyzed yeast extract	209
5435	romano cheese milk	969
5436	salt enzymes.	148
5437	Ingredients:organic ground toasted sesame seeds	266
5438	Organic pumpkin.	559
5439	Organic dried seaweed	1034
5440	Organic blue corn	838
5441	organic oil sunflower and/or safflower and/or canola	147
5442	Organic yellow corn	134
5443	organic expeller pressed oleic safflower and/or organic expeller pressed oleic sunflower oil	181
5444	Organic pears	788
5445	organic pear juice from concentrate.	284
5446	Organic peaches	444
5447	organic peach pulp and juice	444
5448	organic pear juice from concentrate	284
5449	ascorbic acid for color retention	329
5450	organic pear juice concentrate	284
5451	ascorbic acid vitamin c for color retention citric acid.	329
5452	ascorbic acid vitamin c for color retention	329
5453	Enriched bleached and unbleached flour wheat flour	131
5454	mono and di	630
5455	Distilled water	5
5456	electrolytes calcium chloride	340
5457	potassium bicarbonate	655
5458	raspberries.	208
5459	Boneless skinless chicken breast with rib meat	117
5460	water. contains 2% or less of: sea salt	5
5461	waxy rice starch	1154
5462	yeast extract. breaded with: whole wheat flour	209
5463	yea	294
5464	sea slat.	98
5465	organic palm oil	201
5466	cheddar and other natural cheese pasteurized milk	1009
5467	contains 2% or less of vegetable oil partially hydrogenated soybean oil and/or canola oil	881
5468	apo-carotenal for color	590
5469	mono- and diglycerides.	729
5470	mono-and diglycerides.	729
5471	Chicken breast with rib meat	1156
5472	contains 2% or less of: modified food starch	778
5473	Chicken breast meat with rib meat	1380
5474	extractives of paprika and annatto	934
5475	contains 2% or less of: chicken broth concentrated chicken broth	41
5476	grillflavor maltodextrin	197
5477	dehydrated chicken broth	41
5478	chicken meat cooked chicken meat	57
5479	contains less than 2% of: cream	473
5480	cooked mechanically separated chicken meat	1377
5481	beta carotene for color.	590
5482	Cooked grape must	150
5483	wine vinegar	480
5484	sulfur dioxide preservative.	306
5485	Concentrated white grape must	1381
5486	sodium metabisulfite antioxidant	426
5487	vegetable oil contains one or more of the following: corn	307
5488	sunflower and/or canola	1382
5489	vegetable oil contains one or more of the following: corn cottonseed	26
5490	seasoning maltosextrin	197
5491	sunflower and/ or canola	147
5492	malted barley powder	635
5493	natural mesquite smoke flavor	1383
5494	Cultured pasteurized milk	7
5495	Large brown eggs.	1384
5496	Fat free milk	7
5497	vanillin artificial flavor	186
5498	color annatto extract.	722
5499	less than 2% of the following: natural and artificial flavor	316
5500	Yellow popcorn	589
5501	partially hydrogenated soy oil	599
5502	beta-carotene for color.	590
5503	smoke flavoring.	880
5504	mechanically separated turkey	1385
5505	flavoring salt	148
5506	Bread enriched unbleached wheat flour flour	131
5507	dough conditioners sweet whey	1025
5508	ammonium sul	915
5509	Wild maine blueberries	411
5510	Fruit oregon marion blackberries	658
5511	Cooked chicken breast chicken breast meat	117
5512	sauce water	5
5513	lemon powder corn syrup	1386
5514	erythorbic acid to promote color retention.	775
5515	Sliced peaches	444
5516	Red tart pitted cherries	189
5517	erythorbic acid to help promote color retention	775
5518	Semolina niacin	466
5519	silicon dioxide anti-caking	309
5520	corn oil processing aid.	1387
5521	durum flour	239
5522	cheese sauce water	5
5523	soy and/or canola oil	243
5524	non-fat dry mi	801
5525	cheese sauce mix whey	193
5526	cheddar ch	1388
5527	Ice cream: milkfat and nonfat milk	7
5528	carrageenan. coating: sugar	206
5529	ascorbic acid vitamin c to protect color	329
5530	Ingredients: green beans	1044
5531	sat.	594
5532	Strained yogurt: grade a pasteurized skim milk	7
5533	live active cultures s. thermophilus	1389
5534	l. bulgaricus	1390
5535	l. acidophilus	1391
5536	b. lactis. lemon fruit preparation: sugar	295
5537	color turmeric.	175
5538	Ingredients: turnip green	1392
5539	diced white turnips	1393
5540	Ingredients: italian green bean	1044
5541	Ingredients: turnip greens	1392
5542	mustard greens	1394
5543	zinc chloride for color stabilization.	1395
5544	Wax beans	1396
5545	Green bean	1397
5546	wat.	5
5547	Beans	214
5548	pinto beans	1326
5549	calcium chlorite help maintain firmness.	1398
5550	Lima beans	228
5551	Dextrose with maltodextrin	750
5552	3.6% sodium saccharin	756
5553	cream of tartar	420
5554	calcium silicate anti-caking agent	309
5555	Sparkling water	356
5556	Pepperoncini	1399
5557	sodium bisulfite color protectant	1289
5558	Crust: enriched flour wheat flour	131
5559	baking powder cornstarch	17
5560	sodium aluminum sulfate	612
5561	monocalcium ph	381
5562	Ingredients: prepared chick peas	1150
5563	franks containing: mechanically separated chicken	1400
5564	sodium  nitrate	952
5565	contains less than 2% of: high fructose corn syrup	344
5566	less than 1/10 of 1% of sodium benzoate and potassium sorbate preservatives.	926
5567	Black tea	365
5568	fruit juice concentrate apple	373
5569	grape	348
5570	orange	103
5571	raspberry	208
5572	partially hydrogenated vegetable oil soybean and cottonseed. contains less than 2% of the following: malic acid	243
5573	white mineral oil	1401
5574	safflower oil	181
5575	quinoa seeds	167
5576	amaranth seeds	168
5577	sea salt and pepper seasoning sea salt	98
5578	tamari soy sauce powder tamari soy sauce soybeans	277
5579	maltodextr	197
5580	Cooked organic white quinoa organic white quinoa	167
5581	organic cooked barley organic barley	255
5582	Ingredients: corn syrup	315
5583	partially hydrogenated vegetable oil soybean and cottonseed	1142
5584	contains less than 2% of the following: malic acid	345
5585	white mineral and artificial flavors	1402
5586	cherry	371
5587	natural and artificia	1403
5588	Ingredients: beets	174
5589	whole grain rolled oats	78
5590	cornstrach. contains 2% or les of: corn syrup	263
5591	malted barley syrup	1360
5592	vegetable oil palm kernel and canola	26
5593	nonfat yogurt powder cultured nonfat milk	1182
5594	mixed tocopherols and bht added to preserve freshness	1404
5595	added color	648
5596	sodium sulfite to promote color retention. vitamins and minerals: sodium ascorbate	1289
5597	alpa tocopherol acetate	1405
5598	cyanocobalamin.	526
5599	contains 2% or less of: spice	198
5600	Ingredients: organic cane sugar	170
5601	organic vegetable oil palm	201
5602	organic cocoa	118
5603	organic skimmed milk powder	7
5604	emulsifier sunflower lecithin	185
5605	Prepared pinto beans	1268
5606	seasonings chili pepper and other spices	710
5607	calcium chloride firming agent.	340
5608	ascorbic acid to maintain color	329
5609	Prepared garbanzo beans	222
5610	sodium metabisulfite and disodium edta for color retention.	1406
5611	Cookies organic wheat flour	131
5612	organic brown sugar	170
5613	organic butter cream	2
5614	organic vegetable oil sunflower	147
5615	organic cane sug	170
5616	chocolate flavored chips sugar	1
5617	coconut and palm oils	201
5618	organic cannellini beans	1407
5619	Organic egg whites.	376
5620	Wheat flour  wheat flour	131
5621	cultured wheat flour.	131
5622	Diced peaches	444
5623	diced pears	788
5624	pineapple sectors	63
5625	maltodextrin sea salt	148
5626	malt vinegar powder	480
5627	Filtered water sugar	1
5628	Ingredients: carrots	119
5629	calcium chloride as a firming agent.	340
5630	Waters	5
5631	seasoning onion and garlic powders	1408
5632	vegetable oil contains one or more of: cottonseed oil. corn oil	26
5633	vinegar solids white	480
5634	balsamic	480
5635	extract of paprika	55
5636	Ingredients: corn	134
5637	Ground blue corn	838
5638	corn sunflower	147
5639	safflower and/or canola oil	1409
5640	Corn tortillas ground corn treated with lime water	1410
5641	propionic acid	1092
5642	benzoic acid	454
5643	phosphoric acid and enzymes to preserve freshness	770
5644	cooked rice water	724
5645	rice long grain parboiled rice	1411
5646	iron phosphate	251
5647	strawberry puree strawberries	448
5648	greek frozen yogurt base whey protein concentrate	387
5649	cultured dairy solids whey protein concentrate	387
5650	contains 2% or less of: egg yolks	1412
5651	beet juice color.	768
5652	blueberry base blueberries	411
5653	slat.	148
5654	mustard powder mustard distilled vinegar	95
5655	contains less than 2% of: cellulose gel	740
5656	cellulose gum. pro pellant: nitrous oxide.	600
5657	contains less than 2% of: natural and artificial flavor	316
5658	propellant: nitrous oxide.	1413
5659	salted butter cream	2
5660	elderberry juice concentrate	1414
5661	carrageenan. propellant: nitrous oxide.	206
5662	cellulose gum. propellant: nitrous oxide.	600
5663	thiamine mononitrate and folic acid	1415
5664	enriched orzo durum semolina wheat flour	131
5665	southwest seasoning dehydrated onion	9
5666	dehydrated tomato	240
5667	dehydrated green bell pepper	66
5668	chicken flavor	1416
5669	less than 2%: silicon dioxide to prevent caking	309
5670	Mandarin oranges	1417
5671	ascorbic acid to protect color	329
5672	tomato and basil seasoning dehydrated tomato	240
5673	lemon juice solids	200
5674	less than 2%: silicon dioxide to prevent caking.	309
5675	sodium metabisulfite for color retention	397
5676	Ingredients: prepared white corn	134
5677	sodium bisulfite added to help promote color.	1289
5678	bay leaves	114
5679	citric acid acidity regulator.	200
5680	grape must.	150
5681	blue cheese cow's milk	837
5682	p.roquefortii	1418
5683	cream cheese skimmed milk	1419
5684	lactic acid culture	867
5685	citric acid acidity regulator	200
5686	locust bean gum.	339
5687	pickled garlic	4
5688	pickled jalapeno peppers	1160
5689	Ingredients: cabbage	113
5690	Cut tomatoes	240
5691	Light yellowfin tuna	1420
5692	vegetable broth carrots	31
5693	Dough: enriched flour ls wheat flour	131
5694	contains less than 2% of: wheat gluten	955
5695	interesterified soybean oil	243
5696	malted at 35 barley with sulfites	255
5697	ascorbic acid dough conditioner	329
5698	lalue sorbitan monostearate	591
5699	soybean oil. 6 topping: interesterified soybean oil	243
5700	7 yo contains less than 2% of: water	5
5701	dried parmesan cheese pasteurized milk	62
5702	0 powdered cellulose	740
5703	8 seasoning dehydrated garlic	4
5704	black 8 pepper	12
5705	3 4 parsley	22
5706	Ground corn	134
5707	safflower and/or sunflower	1421
5708	orange peels	1118
5709	lima beans.	1422
5710	onion flavoring.	9
5711	vegetable oil sunflower and/or rice and/or canola and/or safflower oil	26
5712	parsley flakes	22
5713	avocado powder	1423
5714	vegetable oil sunflower and/or canola and/or safflower and/or rice oil	26
5715	guacamole seasoning whey milk	193
5716	sour c	200
5717	Fully cooked boneless acid rib-shaped pork patty with barbecue calcil sauce smoke flavor added: pork	534
5718	calcil barbecue sauce water	5
5719	starcf -sugar	170
5720	contai salt	148
5841	blackberry leaf and rosehips	1448
5721	Tomato juice from concentrate water	450
5722	reconstituted vegetable juice blend water and concentrated juice of carrots	1424
5723	lettuce	324
5724	watercress	1425
5725	vitamin c ascorbic acid	329
5726	natural fl	835
5727	Reconstituted vegetable juice blend water and concentrated juices of tomatoes	450
5728	contains less than 2% of: niacinamide	466
5729	vitamin b12	526
5730	ginseng extract panax	1426
5731	gurana extract	1427
5732	taurine	1428
5733	sucralose and acesulfame potassium sweetener	399
5734	contains 2% or less of: niacinamide	466
5735	potassium sorbate and sodium benzoate	803
5736	durum wheat flour	239
5737	cheddar and blue cheese pasteurized milk	1009
5738	emulsifiers acetic acid esters if mono-and diglycerides	729
5739	potassium	1340
5740	chloride	1429
5741	color annatto extract	722
5742	yellow 60	185
5743	sodium silicoaluminate.	1311
5744	Ingredients: peas	132
5745	sodium bicarbonate. monocalcium phosphate	1430
5746	artificial flavor butter derivatives salt	148
5747	magnesium oxide	1431
5748	d-calcium pantothenate	986
5749	vitamin 812. folic acid	727
5750	copper sulfate.	1432
5751	Prepared great northern beans	1433
5752	salt packet: salt.	148
5753	grapefruit juice	553
5754	Semolina	451
5755	Ingredients: potatoes	279
5756	calcium disodium edta for color retention.	455
5757	Chicken wing sections	57
5758	alt	1311
5759	butter flavor contains maltodextrin	197
5760	annatto extract and red #40 artificial color	722
5761	natural flavor contains soybean oil.	243
5762	enriched bleached wheat flour enriched with niacin	131
5763	contains 2% or less of: seasoning sugar	1
5764	textured soy flour	547
5765	potassium and sodium phosphate	194
5766	oleoresin paprika and annatto	1434
5767	Ingredients: spinach	79
5768	Prepared cabbage	113
5769	sodium pholufite to promote color retention.	313
5770	Corn masa flour	165
5771	vegetable oil cottonseed	583
5772	and/or sunflower	1435
5773	vegetable oil cottonseed oil	583
5774	canola oil seasoning maltodextrin	197
5775	barley malt extract.	1436
5776	contains 2% or less of: calcium chloride	340
5777	dehydrated celery	27
5778	dehydrated peppers	1437
5779	natural flavorings.	196
5780	chopped green jalapeno chili peppers	1160
5781	cilantro.	106
5782	mid-oleic sunflower oil	147
5783	jalapeno pepper powder	195
5784	Tomato from concentrate water	487
5785	natural flavorings and sweet bell pepper.	536
5786	Tomatoes.	240
5787	dehydrated bell pepper.	536
5788	concentrated crushed tomatoes	240
5789	fresh jalapeno peppers	195
5790	chipotle peppers	836
5791	coarse ground tomatoes	240
5792	roasted jalapeno peppers	1160
5793	Batter ingredients: water	5
5794	cooked in vegetable oil contains one or more of: corn o	307
5795	vegetable oil palm and soybean oils	26
5796	al	1438
5797	Ingredients: prepared cannellini beans	1439
5798	palm and palm kernel oil tbhq for freshness	201
5799	cocoa syrup. contains 2% or less of: molasses	1440
5800	palm and palm kernel oil with tbhq for freshness	201
5801	molasses. contains 2% or less of: salt	156
5802	leavening baking soda sodium acid pyrophosphate	1441
5803	turmeric extract for color.	175
5804	cranberry	188
5805	juice from concentrate	1442
5806	concopo grape juice from concentrate pear	150
5807	red grape juice from concentrate	150
5808	naturalflavors	196
5809	pumaric acid	1443
5810	sloralose.	399
5811	leavening glucono delta-lactone	1444
5812	sugar. contains 2% or less of: vegetable oils palm	1
5813	soybean and/or cottonseed oils	243
5814	Spinach water.	1445
5815	rehydrated potatoes	34
5816	kidney beans	605
5817	contains le	18
5818	magnesium oxide. contains 2% or less acesulfame potassium	1431
5819	contains less than 1% of: lactase enzyme	1186
5820	seasoning lactose	405
5821	leavening sodium b	258
5822	organic alcohol to preserve freshness.	384
5823	molasses.	156
5824	Ingredients: organic macaroni product organic wheat flour	131
5825	organic mild cheddar cheese sauce organic cheddar cheese	32
5826	organic butter	2
5827	organic soybean oil sodium phosphate organic non fat dry milk	243
5828	organic maltodextrin	197
5829	natural flavors colors added  lactic acid	295
5830	organic guar gum	475
5831	carnauba wax and mixed tocopherols.	415
5832	Honey.	36
5833	Organic macaroni product organic durum wheat semolina	1446
5834	organic mild cheddar cheese sauce organic cheddar cheese pasteurized organic milk	7
5835	organic butter pasteurized organic sweet cream	2
5836	organic soybean oi	243
5837	organic soybean	256
5838	pyridoxine ncl b6	525
5839	Green tea	501
5840	lemon grass	1447
5842	natural jasmine and natural lemon flavors.	1449
5843	corn and/or canola	26
5844	salt. contains 2% or less of: yeast	140
5845	sodium and/or calcium stearoyl lactylate	1450
5846	yeast nutrients ammonium sulfate	915
5847	malted barley niacin	466
5848	riborawn	818
5849	partially hydrogenated vegetable oil soybean cottonseed	881
5850	vegetable oil contains one or more of the following oils: canola	90
5851	corn and/or hydrogenated soybean oil with natural beef flavor wheat	1451
5852	citric acid to maintain freshness	200
5853	sodium acid pyrophosphate to maintain color.	780
5854	Green peas.	1452
5855	ascorbic acid vitamin c red 40	329
5856	Broccoli.	116
5857	green peas	1452
5858	Sunflower seed kernels	271
5859	monosodium glutamate flavor enhancer	630
5860	paprika and other spices	55
5861	garlic and onion powder.	1453
5862	Peanuts.	137
5863	white co	328
5864	white corn flour. contains 2% or less of: potassium chloride	165
5865	modified wheat starch	662
5866	potassium sorbate and citric acid and tbhq preservatives	1454
5867	soy flour.	547
5868	Chicken chicken	57
5869	machanically separated chicken	1455
5870	skin	1456
5871	textured soy protein concentrate	1457
5872	contains 2% or less of the following: dextrose	750
5873	extractives of paprika and turmeric	934
5874	oleoresin of turmeric	383
5875	yellow corn flour. breading set in vegetable oil.	165
5876	salt white distilled vinegar	140
5877	natural orange flavor	649
5878	dehydrated minced onion	9
5879	mechanically separated chicken	1385
5880	spice extractives. breaded with: bleached wheat flour	1295
5881	red grapes	1299
5882	Cultured nonfat milk milk	735
5883	contains less than 2% of artificial color	648
5884	carbon dioxide and potassium sorbate preservatives	529
5885	sodium phosphate tetrasodium pyrophosphate	556
5886	monopotas	1340
5887	Apple juice from concentrate filtered water	322
5888	Apple juice from concentrate filtered water apple juice concentrate	322
5889	cranberry juice cranberry juice and cranberry juice concentrate	188
5890	Grapefruit juice from concentrate filtered water	553
5891	grapefruit juice concentrate	553
5892	White grape juice from concentrate filtered water	150
5893	white grape juice	150
5894	potassium metabisulfite preservative.d	988
5895	Pitted ripe olives	1458
5896	ferrous gluconate.	251
5897	Ripe olives	1459
5898	Granulated sugar.	170
5899	enriched bleached wheat flour bleached flour	131
5900	animal shortening and vegetable oil tallow and/or soybean oil	1460
5901	preservatives bht	747
5902	Filling: water	5
5903	canola or corn oils	90
5904	thiamine monon	468
5905	cereal corn	134
5906	rice flours	138
5907	vitami	494
5908	diced green chile green chile peppers	1365
5909	calcium panthothen	986
5910	contains less than 1% of: tricalcium phosphate	751
5911	Ingredients: enriched bleached wheat flour bleached flour	131
5912	egg white.	244
5913	Milled corn	134
5914	vitamins and minerals: sodium ascorbate	1461
5915	Ingredients: onions	9
5916	canola and palm	90
5917	heat flour	1462
5918	vegetable oil canola and palm	26
5919	Sugar free strawberry parait: water	5
5920	polyglycerol esters of fat	762
5921	Strawberry gelatin: water	1463
5922	orange gelatin: water	459
5923	lemon gelatin: water	1464
5924	whole grain oat flour	274
5925	natural flavors orange	103
5926	lime and other natural flavors	200
5927	bht a preservative. vitamins and minerals: calcium carbonate	721
5928	reduces iron	251
5929	cholecaliferol	1189
5930	oat extract	1465
5931	tripotassium phosphate	194
5932	natural almond flavor	1466
5933	vitamin e mixed tocopherols added to preserve freshness. vitamins and minerals: calcium carbonate	169
5934	reduced iron and zinc oxide	251
5935	Ingredients: whole grain corn flour	165
5936	trisodium phosphate. vitamin and minerals: calcium carbonate	194
5937	Sugar free strawberry banana gelatin: water	5
5938	acesulfame potassium salt	855
5939	sugar free orange gelatin: water	5
5940	yellow6.	403
5941	sugar free lime gelatin: water	459
5942	Ingredients: corn flour	263
5943	natural and artificial flavors contains strawberry juice concentrate	448
5944	bht preservative.	721
5945	thiamine mononitrate vitamin b1	468
5946	whey permeate.	193
5947	precooked yellow corn meal	730
5948	potassium sorbate a preservative	338
5949	modified soy protein	992
5950	pyridoxine hydrochloride vitamin b6	525
5951	thiamine mononitrate vitamin b1.	468
5952	lard and hydrogenated lard with bht added to protect flavor	1467
5953	citric acid and sodium propionate and potassium sorbate preservatives	1468
5954	Green tea.	501
5955	Tempura chicken: chicken white meat	57
5956	coating: water	5
5957	miso soybean	1469
5958	rice koji-aspergillus oryzae	1470
5959	contains 2% or less of: white wine wine	1123
5960	black bean paste black soybeans	1471
5961	koji	278
5962	sweet potato powder.	370
5963	contains less than 2% of: honey	36
5964	extractives of paprika.	759
5965	White grape and peach juice from concentrate filtered water	5
5966	white grape	420
5967	peach juice concentrates	499
5968	Unbleached enriched flour	131
5969	powdered corn & potato starch added to preven	519
5970	low fat mozzarella cheese pasteurized part skim milk	531
5971	non-fat milk	7
5972	carrot fiber	1472
5973	four cheese blend parmesan cheese pasteurized milk	62
5974	romano cheese pasteurized milk	969
5975	ricotta cheese pasteurized whey	193
5976	mozzarella cheese pasteurized part skim milk	531
5977	reb a natural flavors.	1004
5978	Capers	1473
5979	yellow prussiate of soda anti-caking agent.	780
5980	salt sugar.	1474
5981	Kalamata olives	1475
5982	grape juice concentrate.	150
5983	Olive medley may contain green manzanilla olives	486
5984	green queen olives	1476
5985	and natural black olives	1477
5986	Spanish olives	486
5987	minced pimiento water	1478
5988	pimiento	195
5989	potassium sorbate as preservative	338
5990	Spanish olives water	1479
5991	potassium sorbate as preservatives	338
5992	potassium sorbate as preservative.	338
5993	cherries colored with red 3	849
5994	contains less than 1% of sodium citrate and disodium phosphate.	1480
5995	Vegetable oil blend soybean oil	243
5996	contain less than 2% of: whey	193
5997	vegetable mono- & diglycerides	729
5998	potassium sorbate and calcium disodium edta preservatives	1481
5999	contains 2% or less of: whey solids	193
6000	polyglycerol polyricinoleate	1482
6001	potassium sorbate and calcium disodium edta	1481
6002	preservatives	402
6003	lacti	295
6004	Bamboo shoots	1483
6005	Bean sprouts	1484
6006	citric acid to protect color.	200
6007	baby cob corn	134
6008	Corn.	134
6009	contains 2% or less of: calcium carbonate	328
6010	color added including yellow 5 and yellow 6	1485
6011	Diced p	9
6012	di pears	1486
6013	halved che artificially colored red with carmine	1487
6014	color added caramel color	357
6015	color added including yellow 5 lake and yellow 6 lake	1488
6016	pineapple segments	63
6017	halved cherries artificially colored red with red 3	849
6018	peach juice	499
6019	pear juice concentrate	284
6020	artificially colored red with carmine	1487
6021	halved cherries artificially colored red with carmine	1487
6022	halved cherries colored red with carmine	1487
6023	red and yellow papaya	1334
6024	passion fruit juice banana puree	1489
6025	beta carotene for color and vitamin a palmitate.	590
6026	halved cherries artificially colored red.	189
6027	Beef stock	1338
6028	contains less than 2% of: beef fat	1490
6029	gravy flavor base hydrolyzed corn	267
6030	soy and wheat proteins	1491
6031	flavoring contains natural beef juices	1307
6032	contains less than 2% of: modified corn starch	561
6033	contains less than 2% of: whey	193
6034	Garlic cloves	4
6035	Ingredients: enriched bleached flour wheat flour	131
6036	niacinamade	1492
6037	thiamin mononitate	1085
6038	watre	5
6039	vegetables oils palm	201
6040	soybean and/or cottonseed	243
6041	aluminum sulfate. sontains 2% or less of: dextrose	612
6042	sodium styroyl lactylate	875
6043	autolyzed yeast ectract	209
6044	potassium sorbate and tbho preservatives	1493
6045	leaving baking soda	24
6046	aluminum sulfate. contains 2% or less of: salt	612
6047	preservatives potassium sorbate	338
6048	tbhq	1082
6049	Grapefruit	200
6050	Enriched pasta wheat flour	131
6051	sour cream cultured sour cream	25
6052	refined soybean oil	243
6053	monoglycerides. dried	921
6054	cayenne peppers	195
6055	alcohol to retain freshness	384
6056	worcestershire sauce distilled vinegar	73
6057	anchovy puree	1270
6058	natural flavors contains soy	142
6059	habanero powder	725
6060	natural ginger flavor	28
6061	natural orange flavor.	649
6062	Ingredients: white distilled vinegar	480
6063	soy suces water	39
6064	dehydrated chipotle peppers	1363
6065	Long grain rice enriched with ferric orthophosphate	1057
6066	ricotta cheese whey	193
6067	yellow 6 lake.	794
6068	Enriched macaroni wheat flour	131
6069	paprika extract for color	934
6070	disodium phosphate. dried	1253
6071	Dehydrated potatoes with mono- and diglycerides and sodium acid pyrophosphate	34
6072	sodium bisulfite and citric preservatives	1494
6073	Dehydrated potatoes with sodium bisulfite preservative	34
6074	annatto extract and turmeric oleoresin for color	722
6075	sodium phosphate.	194
6076	sweet cream cream	473
6077	dehydrated chives	99
6078	semisoft cheese milk	1495
6079	disodium inosinate.	1002
6080	Ingredients: enriched macaroni product wheat flour	131
6081	cheese sauce mix wheat flour	131
6082	butter oil.	311
6083	contains less than 2% of: corn starch	866
6084	garlic powder.	4
6085	ferrous sulfate iron	251
6086	onion powder.	9
6087	pear juice from concentrate.	284
6088	Plums	1496
6089	less than 2% of : salt	148
6090	carmel color	357
6091	Egg whites 99%	584
6092	contains 1% or less of the following: guar gum	475
6093	and color includes beta carotene	478
6094	vitamins&minerals: calcium sulfate	924
6095	iron ferric orthophosphate	251
6096	alpha tocopherol acetate vitamin e	169
6097	zinc sulfate	527
6098	thiamine mononitrate vitamin b1. pyridoxine hydrochloride vitamin b6	1497
6099	Bread: enriched flour wheat flour	131
6100	contains less than 2% of: interesterified soybean oil	243
6101	malted barley flour with sulfites	993
6102	monoglycerides with citric acid preservative	200
6103	l-cysteine. spread: interesterified soybean oil	951
6104	contains less than 2% of: dehydrated garlic	4
6105	crushed tomatoes concentrated crushed tomatoes	487
6106	onion.	1498
6107	Precooked parboiled brown rice.	1499
6108	crushed tomatoes	240
6109	parsley.	22
6110	Ingredients: collard greens	1500
6111	Fresh cucumbers	122
6112	Organic ground corn	134
6113	organic oil sunflower	147
6114	safflower and/or canola	1501
6115	organic sweet potato powder	370
6116	and/or palm oils	201
6117	Mandarin orange sections	1417
6118	mandarin orange juice	1333
6119	Peeled mandarin orange segments	1502
6120	Prune juice	1503
6121	oil of bergamot.	1504
6122	eleuthero root	1505
6123	lemon verbena	1506
6124	licorice root	1507
6125	roasted chicory root	1279
6126	ginger root	28
6127	orange blossoms	1508
6128	dried honey	36
6129	asian ginseng.	1509
6130	leavening sodium acid pyrophosphatae	780
6131	nonfat dry milk blueberry flavored chips sextrose	7
6132	modified flour wheat flour	131
6133	noacin	466
6134	soy lecithincooked in vegetable oil contains one or more of: corn oil	185
6135	soybean oil. sausage ingredients: pork	243
6136	propyl gallate.	1321
6137	organic milled coan	68
6138	Ingredients: organic whole grain oats includes the oat bran	78
6139	organic honey salt	148
6140	organic ground almonds calcium carbonate	60
6141	mixed tocopherols vitamin e added to preserve freshness.	169
6142	Salmon	808
6143	Pink salmon	1510
6144	Organic whole grain oats includes the oat bran	191
6145	mixed tocopherols vitamin e added to preserve freshness.vitamins and minerals: feric orthophosphate	169
6146	vitamin a acetate	562
6147	pyridoxine hydrochloride.	525
6148	Liquid and partially hydrogenated soybean oil	243
6149	contains less than 2% of: vegetable mono & diglycerides	1511
6150	vita	562
6151	coloring includes blue 1 lake	885
6152	dried pineapple pineapple	1512
6153	dried papaya papaya	1334
6154	walnuts. dried fruit treated with sodium bisulfite and sulfur dioxide to promote color retention.	58
6155	raspberry juice from concentrate	961
6156	raspberry color red 40	677
6157	allspices	124
6158	bht preservative. vitamins and minerals: niacinamide	747
6159	Cultured pasteurized organic grade a nonfat milk.	7
6160	cor syrup	596
6161	color added includes red 40	677
6162	thiamin mononitrate vitamin b1.	1085
6163	fruit from concentrate white grape	1513
6164	organic apple juice concentrate.	322
6165	Cultured pasteurized organic grade a nonfat milk	7
6166	organic cherries	189
6167	elderberry juice for color	237
6168	organic lemon juice concentrate.	18
6169	organic vanilla beans.	20
6170	pectin organic lemon juice concentrate.	337
6171	Cultured pasteurised organic grade a nonfat milk	7
6172	organic elderberry juice for color	1414
6173	cranberry juice	766
6174	cranberry juice concentrate.	766
6175	tart cherry juice concentrate	1514
6176	Pomegranate juice from concentrate filter water	406
6177	Whole grains rolled oats	78
6178	puffed wheat	143
6179	puffed rice	1515
6180	textured soy protein	1457
6181	flax seed	207
6182	mixed tocopherols natural vitamin e to maintain freshness.	169
6183	organic parmesan cheese cultured pasteurized organic milk	62
6184	Granola whole grain rolled oats	78
6185	dried coconut	68
6186	toasted oats whole grain rolled oats	78
6187	canola oil with tbhq and citric acid to preserve fr	90
6188	citric ac	200
6189	wheat bran. contains 2% or less of: sugar	301
6190	doug	1516
6191	enriched egg noodles enriched durum wheat flour	239
6192	cooked chicken meat	57
6193	sodium phosphate flavor	194
6194	contains less than 2% of: potato starch	519
6195	cooked mechanically separated chicken fat	1148
6196	cooked mechanically separated chicken	1517
6197	meat	1376
6198	cooked beef beef	33
6199	contains 2% or less: celery	27
6200	caramel for color	357
6201	yeast extracts	209
6202	wheat protein concentrate.	514
6203	chicken flavoring hydrolyzed soy and corn gluten	630
6204	disodium guanlylate	1518
6205	chicken flavor natural flavors	1278
6206	natural flavor contains maltodextrin.	197
6207	cultured wheat starch	662
6208	wheat gluten. contains 2% or less of: soybean oil	955
6209	raisin juice c	150
6210	organic green tea	501
6211	organic natural flavors.	316
6212	peppermint powder sugar	1
6213	seasoned cooked beef beef	33
6214	hydrolyzed torula and brewers yeast protein	209
6215	hydrolyzed wheat gluten.	955
6216	white chicken meat cooked white chicken meat	57
6217	modified corn strach	866
6218	enriched paste durum wheat flour	239
6219	sirloin beef beef	1519
6220	contains less than 2% of: wheat flour	131
6221	grill flavor from soybean and/or cottonseed oil.	975
6222	Cooked beef and binder product beef	33
6223	gravy water	5
6224	clams	482
6225	hydrolyzed wheat gluten	955
6226	fermented wheat protein	1520
6227	succinic acid.	1521
6228	Pineapple tidbits	63
6229	dehydrated cranberries cranberries	188
6230	ground cinnamon	15
6231	organic chamomile	1522
6232	organic lemon myrtle	1523
6233	organic lemon oil.	910
6234	organic black tea	365
6235	organic oil of bergamot oil.	1504
6236	Jasmine rice	903
6237	bbq seasoning sugar	1
6238	natural smoke flavo	268
6239	natural flavors including sour cream and blue cheese flavors	1524
6240	palm oil & fractionated palm oil	201
6241	evaporated apples treated with sulfur dioxide to preserve color. contains 2% or l	1074
6242	sugar. contains 2% or less of: vegetable shortening palm oil	1
6243	polys	1
6244	Minced pollock	896
6245	cottonseed and/or soybean oil	243
6246	colored with extractives of paprika and turmeric.	1525
6247	peanut and/or canola and/or cottonseed oil	26
6248	Ingredients: organic honey.	36
6249	Organic raspberries	208
6250	apple pectin	337
6251	Organic concord grape puree	1526
6252	beef cooked beef	33
6253	tomatoes water	240
6254	white corn flour	165
6255	celery.	27
6256	textured soy protein caramel color added	276
6257	enzyme modified romano cheese romano cheese pasteurized cow's milk	969
6258	spice extracts.	1527
6259	contains less than 2%: high fructose corn syrup	344
6260	Tomato puree water tomato paste	487
6261	water enriched wheat flour wheat flour malted barley flour	131
6262	nacin	466
6263	ferrous sulphate thiamine	251
6264	contemplate	650
6265	flock	1528
6266	acid beef peacetimes enriched wheat flover wheat flour	131
6267	manic	1529
6268	perpetuals salivate	1
6269	toamto paste	83
6270	meatballs beef	33
6271	breadcrumbs enriched wheat flour {wheat flour	131
6272	textured soy protein soy flour	547
6273	enriched pasta product wheat floir	131
6274	tricalcium phospahte	381
6275	enriched pasta product wheat flour	131
6276	contains 2% or less: salt	140
6277	enzyme modified cheddar cheese cheddar cheese pasteurized milk	1009
6278	isodium phosphate	194
6279	Organic fruit organic raspberries	433
6280	organic morello cherries	1530
6281	organic red currants	1531
6282	Chicken broth contains flavor	316
6283	white chicken white chicken meat	57
6284	dumplings enriched wheat flour wheat flour	131
6285	partially hydrogenated vegetable oil	881
6286	contains 2% or less of chicken fat	1148
6287	chicken flavor autolyzed yeast extract	209
6288	contains 2% or less of green chilis green chili peppers	1285
6289	textured vegetable protein soy flavor	1532
6290	enriched wheat flour bleached	131
6291	enriched niacin	466
6292	thiamine mononitrate riboflavin and folic acid	1533
6293	malted barley flavor	1534
6294	seasoning chil pepper	195
6295	food starch-modified hydrolyzed soy protein	276
6296	flavorings soy lecithin.	185
6297	Coffee water	5
6298	coffee extract	585
6299	ascesulfame potassium	855
6300	water enriched wheat flour wheat flour	131
6301	dextrode	750
6302	English muffin: whole grain wheat flour	1535
6303	seasoning sea salt	98
6304	natural flavorings. mild cheddar cheese: pasteurized milk. cheese cultures	196
6305	and annatto for color.	722
6306	vegetable shortening partially hydrogenated soybean oil and/or cottonseed oil	243
6307	emulsifier mono- and diglycerides with mixed tocopherols	292
6308	ribofllavin	818
6309	mono and di-glycerides.	729
6310	brominated veget	1536
6311	long-grain parboiled rice enriched with iron ferric orthophosphate	251
6312	thiamin mononitrate and folic acid	1537
6313	contains 2% or less of corn	134
6314	milk protein concentrate nonfat milk	291
6315	contains 2% or less of modified cornstarch	561
6316	chili power chili pepper	195
6317	chili flavor oleoresin of paprika	55
6318	enriched egg noodles	1538
6319	enriched semolina wheat	451
6320	wheat gluten glyceryl monostearate	955
6321	contains 2% or less of potato starch	519
6322	monosodium gultamate	630
6323	franks pork	534
6324	disodium inosinate and disodium guanylate.	1039
6325	sodium metabisulfite preservative	397
6326	green chilies	1250
6327	Organic extract virgin olive oil.	6
6328	grated parmesan cheese milk	62
6329	modified egg yolk enzyme egg yolk	796
6330	grated romano cheese milk	969
6331	natural cheese flavor	38
6332	roasted garlic puree roasted garlic	4
6333	Organic extra virgin olive oil.	6
6334	vinegar salt	148
6335	Ingredients:enriched bleached flour wheat flour	131
6336	sodium aluminum phosphate. contains 2% or less of: corn syrup	864
6337	gums xanthan	265
6338	potassium sorbate and sorbic acid and citric acid preservatives	854
6339	aluminum sul	612
6340	dehydrated sweet potato	370
6341	raisins raisin	1539
6342	cheddar cheese powder whey	193
6343	cheddar cheese pasteurized cultured milk	32
6344	dry malt malted barley flour	993
6345	ammonium bicarbonate and sodium bicarbonate leavening	24
6346	milk protein hydrolysate	1540
6347	paprika color.	55
6348	enriched flour wheat flour. niacin	131
6349	onio	9
6350	anaheim peppers	1541
6351	contains 2% or less of: cilantro	106
6352	sodium benzoate and potassium sorbate added to maintain freshness.	926
6353	Organic dextrose	750
6354	organic reb - a.	1378
6355	panax ginseng	1509
6356	guarana	1542
6357	inositol	1543
6358	cyanocobalamin vitamin b12.	526
6359	Fresh banana peppers	1544
6360	malic and lactic acid	1545
6361	sodium benzoate and sodium metabisulfite preservatives	1546
6362	leavening sodium aluminum p	864
6363	Pasteurized cream	473
6364	mechanically separated chicken skim	57
6365	contains 2% or less the following: dextrose	750
6366	of paprika and turmeric	1547
6367	leavening sodium aluminium pho	1548
6368	potassium and sodium citrate	200
6369	magnesium oxide contains 2% or less lemon juice solids	1431
6370	maltodextrn	197
6371	red 40. contains 2% or less potassium citrate	677
6372	potassium citrate. contains 2% or less acesulfame potassium	904
6373	contains less than 2% acesulfame potassium	855
6374	instant tea	851
6375	contains less than 2% magnesium oxide	1431
6376	raspberry juice solids. contains 2% or less acesulfame potassium	855
6377	contains 2% or less of: calcium silicate	1010
6378	ethyl acetate	1549
6379	tannic acid	1550
6380	suralose	399
6381	contains less than 2% of: natural flavor	1302
6382	riiboflavin	818
6383	tocopheryl acetate	169
6384	silicon dioxide.	309
6385	Blanched and unblanched peanuts	173
6386	peanut oil and/or canola oil and/or cottonseed oil	26
6387	annatto extract for color.	722
6388	dehydrated honey refinery syrup	36
6389	granulated brown sugar	170
6390	vinegar maltod	73
6391	organic low fat cocoa powder.	118
6392	organic low fat cocoa powder	118
6393	organic quinoa.	167
6394	Mukimame shelled edamame soybeans	277
6395	red pepper.	195
6396	cheddar and blue cheeses pasteurized milk	1009
6397	emulsifiers acetic acid esters of mono- and diglycerides	729
6398	extract	269
6399	salted sherry wine	947
6400	spice. glazed with: water	198
6401	mirin water	1551
6402	toasted sesame oil	112
6403	flavor.	316
6404	Fresh tomatoes	240
6405	Raspberry filling sugar	1
6406	preservatives sodium benzoate	354
6407	artificial f	1552
6408	contains less then 0.5% of: mono and diglycerides	341
6409	belgian semi sweet c	118
6410	pumpkin pie sauce pumpkin	559
6411	monfat milk	1553
6412	whole grain barley flour	993
6413	whole grain brown rice flour	261
6414	corn bran	1554
6415	trisodiu	594
6416	Whole wheat flour.	283
6417	Citric aspartame	1251
6418	Rooibos.	1555
6419	naturally derived citric acid.	200
6420	contains less than 2% of calcium chloride	340
6421	contains less than 2% of calcium chloride.	340
6422	aloe vera juice and pulp	1556
6423	chicken meat cooked chicken white meat	57
6424	green bell peppers. contains less than 2% of : green chiles	195
6425	diced jalapeno peppers	1160
6426	vegetable flavor blend carrot	119
6427	flavoring maltodextrin	197
6428	dried torula yeast	1557
6429	buttermilk solids buttermilk	72
6430	whey proteins	387
6431	beef flavor beef broth	1338
6432	natural smoked flavor.	1558
6433	potato starch-modified. contains 2% or less of annatto color	519
6434	sodium acid pyrophosphate maintains color and leavening	518
6435	tapioca starch-modified	1559
6436	d-alpha tocopherol.	169
6437	walnuts with preservative bht	58
6438	vegetable shortening canola and/or palm oil with preservative tbh	790
6439	100% liquid egg whites.	376
6440	diced tomatoes tomatoes	240
6441	romano cheese part skim milk	969
6442	de	1560
6443	hydrogenated palm oil	201
6444	whole wheat	802
6445	natural flavor contains milk	7
6446	bht a preservative	721
6447	reduced ir	1561
6448	enriched pasta durum wheat flour	239
6449	contains less than 2% of: dehydrated onions	9
6450	monosodium glutam	630
6451	contains less than 1% of: mono and diglycerides	341
6452	natural and artificial; flavor	316
6453	brown sugar syrup	170
6454	vitamins & minerals: potassium chloride	1562
6455	pyrioxine hydrochloride	525
6456	marinated cooked white chicken chicken breast with rib meat	1156
6457	chicken gravy mix modified food starch	778
6458	chicken fat with extracts of ro	1148
6459	sodium tripolyphosphate to retain moisture. predust: wheat flour	820
6460	Pollock sodium tripolyphosphate to retain moisture. predust: wheat flour	820
6461	batter mix: water	5
6462	organic guayusa concentrate	1563
6463	organic guayusa aroma	1563
6464	organic guava flavor	1564
6465	organic cane sugar organic guayusa concentrate	1
6466	organic guayusa arum citric acid	200
6467	assorbic acid vitamin c.	329
6468	organic hibiscus extract	767
6469	organic blueberry flavor	1565
6470	organic yumberry flavor	1566
6471	organic lime juice extract	1567
6472	organic lime extract	1568
6473	Ingredients: enriched precooked long grain rice rice	1569
6474	thiamin hydrochloride	1085
6475	Enriched precooked long grain rice rice	999
6476	niacin niacinamide	466
6477	thiamin thiamin mononitrate	1085
6478	Enriched precooked parboiled long grain rice rice	1057
6479	Cultured grade a lowfat milk and fat free milk	7
6480	Low-moisture part-skim mozzarella cheese pasteurized part-skim milk	1570
6481	vinegar.	480
6482	vegetable mono & diglycerides.	729
6483	Pinto beans.	1268
6484	Batter: water enriched flour wheat flour	131
6485	soybean oil dried honey	36
6486	Dough: enriched flour wheat flour	131
6487	dextrose. filling: onion	750
6488	potato potato	279
6489	disodium edta	981
6490	green	888
6491	Filling: cooked chicken breast meat chicken breast	117
6492	bbq sauce molasses	156
6493	wa	5
6494	Filling: cream cheese product cheese milkfat	30
6495	low moisture part skim mozzarella cheese partly nonfat milk	531
6496	cellu	740
6497	dehydrated red bell peppers	84
6498	vinegar blend corn	73
6499	cider	322
6500	contains 2% or less of: mustard flour	95
6501	Cake base sugar	170
6502	modified corn starch. contains 2% or less of: whey	561
6503	sorbitan monoste	591
6504	less than 2% of: canola oil and/or soybean oil	26
6505	color a	677
6506	organic pineapple	63
6507	spice blend spices	834
6508	lime juice solids corn syrup solids	596
6509	oleore	1571
6510	spice blend buttermilk solids	575
6511	dehydrated vegetables onion	9
6512	cheddar cheese {pasteurized milk	32
6513	chicken flavors with other natural flavors	1572
6514	organic chicken broth concentrate organic chicken flavor organic chicken	41
6515	organic flavor	316
6516	organic turmeric	383
6517	wheat protein isolate	514
6518	Corn masa flour corn masa	1573
6519	organic dark red kidney beans	229
6520	organic pinto beans	1268
6521	organic great northern beans	1433
6522	organic paprika.	55
6523	salt and sodium benzoate preservative.	148
6524	Water. dehydrated potato flakes prepare potatoes	279
6525	mono-and diglycerides of fatty acids emulsifier. natural flavor	729
6526	potassium pa i r sorbate preservative.	338
6527	canola and/or soy and/or palm oil. contains 2% or less of: corn syrup	26
6528	natural and artificial vanilla flavor	20
6529	beef beef crumbles beef	33
6530	contains 2% or less of: white corn flour	165
6531	Sausage: mechanically separated chicken	1574
6532	salt. contains 2% or less of: corn syrup dextrose	140
6533	garlic powder. broth: chicken broth.	4
6534	contains 2% or less of modified cornstarch textured vegetable protein soy flour	547
6535	disodium inosinate and	1002
6536	contains less than 2% of: whey protein concentrate	387
6537	sorbic ac	854
6538	modified corn starch. contains 2% or less of: beef	561
6539	palm and/or palm kernel and/or partially hydrogenated palm kernel oil	201
6540	contains 2% or less of: molas	176
6541	chili pe	195
6542	and folic acid.	727
6543	parmesan cheese part skim milk	62
6544	dairy products solids	1575
6545	provolone cheese milk	7
6546	medium chain triglycerides coconut and/or palm kernel oil.	1019
6547	contains less than 1% of: roasted garlic puree garlic	4
6548	yeast extract barley	1094
6549	medium chain triglycerides coconut and/or palm kernel oil	1019
6550	high fructose corn syrup.	344
6551	raspberry flavor	636
6552	tocopherols natural vitamin e	169
6553	malted barley syrup vitamin and minerals:sodium ascorbate	1576
6554	alpha tocopherol acetate	169
6555	pyridoxine hydrchloride	525
6556	ribflavin	818
6557	cyanocobalmin bht added to packaging material to help preserve freshness.	526
6558	salted vodka	1577
6559	parmesan cheese pasteurized part-skim milk	62
6560	powdered cellulose anti-caking agent.	740
6561	cheddar/monterey/blue cheeses pasteurized milk	7
6562	whey protein concentrate cellulose gum	387
6563	silicon dioxide to prevent caking.	309
6564	Ingredients:enriched macaroni product wheat flour	131
6565	color added beta carotene	590
6566	foloc acid	727
6567	modified corn staech	866
6568	tetrasodium pyrophos-phate	518
6569	yellow5.	403
6570	sorbic acid as a preservative.	854
6571	contains less than 2% of: whey salt	140
6572	vegetable mono and diglycerides	1511
6573	dehydrated banana	136
6574	defatted wheat germ	180
6575	miso water	1578
6576	koji starter aspergillus oryzae	1470
6577	contains 2% or less : garlic powder	4
6578	pickled red chilired chili	1579
6579	pickled garlic garlic	4
6580	acetic acid salt	148
6581	paprika extract.	195
6582	mixed tocopherols added to preserve freshness	154
6583	beta carotene. vitamins and minerals: calcium carbonate	590
6584	color caramel color	357
6585	annatto extract	722
6586	mixed tocopherols added to preserve freshness. vitamins and mine	154
6587	Kale.	841
6588	cheddar and blue cheese cultured milk	7
6589	sour cream powder cultured crea	1015
6590	Whole green beans.	1044
6591	vegetable shortening interesterified soybean oil	243
6592	hydrogenated soybean oil and/or palm oil	243
6593	leavening s	258
6594	partially hydrogenated soybean oil with mono- and diglycerieds	243
6595	Durum wheat semolina.	1280
6596	organic blood orange juice from concentrate	1580
6597	organic black carrot juice from concentrate for color	590
6598	natural blood orange and orange flavors.	103
6599	Dehydrated potato	279
6600	sodium acid pyrophosphate and sodium bisulfite and citric acid preservatives	1581
6601	natural flavor milk.	7
6602	organic lemon juice from concentrate	18
6603	organic pink grapefruit juice from concentrate	553
6604	citirc acid	200
6605	natural grapefruit flavor	1582
6606	organic carrot and black carrot juices from concentrate for color	1056
6607	Organic pasteurized sweet cream	473
6608	natural lime flavor	200
6609	cocoa processed with alkali. contains 2% or less of: semi sweet chocolate sugar	118
6610	milk chocolate colored candies milk chocolate sugar	1
6611	contains less than 2% of whey protein concentrate	387
6612	sorbic acid preserv	854
6613	monterey jack cheese cultures	1583
6614	sodium phosphate vinegar	73
6615	water cellulose	740
6616	contains 2% or less of: corn sugar	596
6617	soybean oil sugar	1
6618	x	1584
6619	dehydrated apples treated with sodium sulfite and sulfur dioxide to promote color retention	213
6620	pyrodoxine hydrochloride	525
6621	contains less than 1% of: lactose enzyme	1186
6622	contains 2% or less of: gelatin	459
6623	bht to preserve freshness. vitamins & minerals: vitamin b1 thiamine mononitrate	747
6624	vitamin b2 riboflavin	818
6625	vitamin b6 pyridoxine hydrochloride	525
6626	vitanin b12	526
6627	zinc zinc oxide.	1585
6628	Whole grain wheat.	143
6629	malted barley syrup. vitamins and minerals: potassium chloride	1586
6630	Enriched durum flour wheat flour	239
6631	contains less than 2% of: parmesan cheese part skr milk	62
6632	romano cheese made from cow's milk cultured milk	969
6633	citric acid for flavor.	200
6634	thiamine mononitratvitamin b1	468
6635	stabilizer modified food starch	778
6636	contains less than 2 % of: romano cheese made from cow's milk cultured milk	62
6637	garlic garlic	4
6638	citric acid as a preservative	200
6639	seasonings spices	834
6640	beef sirloin seasoning roasted beef sirloin including beef juices	33
6641	autolyzed yeast extract soy	209
6642	grill flavor flavor from vegetable oil	975
6643	beef flavor contains beef fat and flavor	1307
6644	salt caramel color.	357
6645	color yellow lakes 5 & 6 and annatto extract	1587
6646	monterey jack cheese milk	7
6647	corn and/or soybean oil	243
6648	sodium citrate mono- and diglycerides	477
6649	Coconut oil.	135
6650	Organic extra virgin olive olive oil	6
6651	organic grain alcohol added for clarity	384
6652	organic soy lecithin prevents sticking	185
6653	propellant.	671
6654	malted barley syrup. vitamins & minerals: sodium ascorbate	1586
6898	canola or soybean oil	26
6655	partially hydrogenated vegetable shortening contains one or more of the following: partially hydrogenated soybean oil	1588
6656	contains 2% or less of: corn starch	866
6657	emulsifiers mono-	592
6658	emulsifiers mono	729
6659	Cookies wheat flour	131
6660	oat flakes	78
6661	leavening sodium carbonate	258
6662	ammonium carbonate	314
6663	canola lecithin	185
6664	canola and/or palm	90
6665	cocoa cookies enriched wheat flour wheat flour	131
6666	chocolate powder sugar	1
6667	liquor	384
6668	skin milk powder	291
6669	lactose sunflower lecithin	185
6670	natural vanilla flavor.	20
6671	vegetable oil canola and/or palm	26
6672	cookies enriched wheat flour wheat flour niacin reduced iron	131
6673	folic acid sugar	727
6674	whole m	5
6675	Organic honey.	36
6676	Ingredients: cream.	473
6677	guarana extract	1542
6678	corn and/or sunflower	307
6679	toasted corn germ.	1589
6680	water and citric acid.	5
6681	Organic coconut water.	438
6682	beef ravioli enriched wheat flour wheat flour	131
6683	carrots. contains 2% or less: caramel color	31
6684	spice extracts. contains 2% or less: high fructose corn syrup	554
6685	spice extract.	199
6686	dehydrate red bell pepper	1590
6687	polysorbate 8	613
6688	spices contains mustard	95
6689	mustard bran	1591
6690	contains less than 2% of: vinegar	480
6691	calcium silicate an anticaking agent.	309
6692	calcium silicate an anticaking agent	1010
6693	potassium iodine.	913
6694	aspartame.	1251
6695	mononitrate vitamin b1	1085
6696	modified cor	332
6697	Corn oil.	307
6698	ascorbic acid to maintain color. distributed byt the kroger co.	329
6699	cincinnati	225
6700	ohio 45202 certified organic by deffa columbus	1592
6701	oh 43214	367
6702	Whole green beans	1044
6703	whole yellow wax beans	1593
6704	Edamame soybean in pod	1594
6705	dimethyl silicon for anti-foaming	1595
6706	Ingredients: organic maple syrup.	102
6707	Organic green beans	1044
6708	contains less than 1% of: carrageenan	206
6709	contains less than 1% of: cocoa processed with alkali	118
6710	Ingredients: organic corn	134
6711	spices olive oil	6
6712	cheese cultured part-skim milk salt enzymes.	7
6713	cultured part-skim milk	735
6714	and enzymes	1596
6715	vegetable shortening palm oil and/or soybean oil	790
6716	emulsifiers propylene glycol mono- and diesters	939
6717	water corn syrup	596
6718	monocalcium phosphate. contains 2% or less of: modified corn starch	259
6719	vegetable shortening contains one or more of: palm and/or soybean oil with emulsifier propylene glycol monoesters	1597
6720	soy lecithin and preservative bht	185
6721	citric acid. contains 2% or less of: modified corn starch	200
6722	coconut creme coconut extract	1598
6723	natural yogurt flavor natural flavor	210
6724	garam masala spice	1599
6725	ginger powder	28
6726	paprika extract soy lecithin	55
6727	dried onio	9
6728	tamari sauce water	5
6729	white vinegar	480
6730	crushed red peppers	195
6731	white chablis wine	1600
6732	palm and/or palm kernel oil	201
6733	palm and/or cottonseed and/or sunflower oil	26
6734	blueberry powder blueberries	237
6735	gum blend xanthan gum	265
6736	sodium propionate preservative	1601
6737	Artichoke quarters	1342
6738	Asparagus spears.	1371
6739	Organic durum wheat semolina.	1280
6740	Organic tomato concentrate water	717
6741	contains less than 2% of: calcium chloride	340
6742	Contains 16 of these varieties: pinto beans	1268
6743	blackeye peas	1316
6744	navy beans	226
6745	large lima beans	1422
6746	small white beans	226
6747	red kidney beans	1602
6748	baby lima beans	1422
6749	great northern beans	1433
6750	speckled lima beans	1422
6751	green baby lima beans	228
6752	black turtle beans	1603
6753	whole green peas	1604
6754	Great northern beans.	1433
6755	Pearled barley.	255
6756	Ingredients: cayenne pepper sauce cayenne peppers	195
6757	natural flavors {contain soy}	196
6758	and tamarind	453
6759	onion powder xanthan gum	265
6760	natural butter   flavor soybean oil	243
6761	turmeric and annatto	1091
6762	tocopherol.	169
6763	natural butter flavor soybean oil	243
6764	tocopherol	154
6765	Cayenne peppers sauce cayenne peppers	195
6766	Green split peas.	1605
6767	Light red kidney beans.	1602
6768	Small red bean.	1606
6769	Baby lima beans.	1422
6770	Lentils	221
6771	Navy beans.	1146
6772	whole barley flour	993
6773	whole rye flour	235
6774	organic tapioca starch	757
6775	blueberry bits sugar	1
6776	fruit and vegetable extracts blueberry and purple carrot for color	237
6777	sugar. contains 2% or less of: potato flour	1
6778	fruit juice concentrate blend pear juice concentrate	284
6779	pineapple syrup	1179
6780	clarified pineapple and peach juice concentrate	1607
6781	Black beans.	669
6782	Garbanzo beans.	222
6783	Cranberry beans.	1608
6784	Pink beans.	1609
6785	Small white beans.	226
6786	Mayocoba beans.	1610
6787	Extra large eggs	14
6788	Brown rice.	305
6789	Ground flaxseed meal.	157
6790	Long grain rice	1057
6791	Ingredients: long grain rice	64
6792	Soy cocoa crisps soy protein isolate	1291
6793	alkalized cocoa powder	96
6794	cocoa creme fructose	118
6795	Medium grain rice	64
6796	Quinoa.	167
6797	organic chicken flavor base organic chicken flavor organic chicken	1572
6798	organic turmeric.	828
6799	potassium sorbatepreservative.	338
6800	Enriched unbleached wheat flour wheat flour	131
6801	bourbon vanilla extract	20
6802	Arborio rice.	701
6803	Red lentils.	1288
6804	green peppers. contains less than 2% of flaxseed	195
6805	contains 2 % or less of: salt	148
6806	vitamin & minerals: potassium chloride	1562
6807	pasteurized processed cheddar cheese cheddar cheese pasteurized milk	32
6808	Clover honey.	36
6809	whole grain sorghum flour	1611
6810	mixed tocopherols vitamin e and bht added to preserve freshness. vitamins and minerals: calcium carbonate	1612
6811	Coconut water powder coconut water concentrate	438
6812	contains less than 2% of: acesulfame potassium	855
6813	magnesium oxi	1431
6814	Pasta durum wheat semolina	1280
6815	filling gorgonzola cheese milk	1613
6816	penicillium roqueforti	1236
6817	ricotta cheese milk	1614
6818	grated cheese grana padano {milk	1615
6819	lysozyme preservative from egg}	1164
6820	parmigiano re	537
6821	Roma tomatoes	240
6822	fire roasted onions	9
6823	contains 2% or less of: fire roasted jalapeno peppers	1616
6824	chipotle in adobo chipotle peppers	1617
6825	Tomatoes tomato	240
6826	contains 2% or less of: green chilies	1250
6827	chile peppers anaheim	836
6828	jalapeno	1348
6829	water basil	48
6830	filling ricotta cheese milk	971
6831	mascarpone cheese milk	7
6832	parmigiano reggiano cheese milk	62
6833	granular basil basil	48
6834	vegetable fiber	223
6835	chile peppers jalapeno	195
6836	anaheim	536
6837	contains 2% or less of: passion fruit juice concentrate	1618
6838	dehydrated green and red bell peppers	1619
6839	tomato fiber	1620
6840	dehydrated onion.	9
6841	cooked mushrooms mushrooms	1621
6842	artificial mushroom flavor	1622
6843	dried porcini mushrooms	1623
6844	Organic enriched wheat flour niacin	131
6845	organic cane sugar syrup	170
6846	organic soy lecithin	185
6847	gruyere and fontina cheeses milk	1624
6848	gorgonzola cheese milk	1613
6849	grana padano cheese milk	1625
6850	lysozyme preservative from egg	1164
6851	Gluten free flour blend corn flour	165
6852	dehydrated cane sugar	170
6853	arrowroot flour	1626
6854	butter may contain annatto	2
6855	egg powder	333
6856	soy lecit	185
6857	Tomato pulp tomato	240
6858	dehydrated fried onion onion	9
6859	Organic green split peas.	1605
6860	Organic whole grain oats	78
6861	organic evaporated cane syrup	1627
6862	organic brown rice crisps organic brown rice	305
6863	Organic green lentils.	1628
6864	Spread sugar	170
6865	whey milk powder	193
6866	breadsticks enriched wheat flour wheat flour	131
6867	corn and malt syrup	176
6868	Organic whole grain rolled oats	78
6869	organic evaporated cane juice organic brown rice crisp organic brown rice	1627
6870	organic cranberries organic cranberries	188
6871	organic oat syrup solids	1629
6872	organic yumberry juice	1630
6873	organic pomegranate arils organic pomegranate arils	412
6874	organic pomegranate juice concentrate	406
6875	organic quinoa crisps	167
6876	organic wild blueberries organic wild blueberries	411
6877	organic chia seeds	1631
6878	mixed tocopherols vitamin e.	169
6879	Organic coconut oil.	135
6880	Organic virgin coconut oil.	135
6881	organic apricots organic apricots	275
6882	organic canola o	90
6883	Organic sweet cream	1632
6884	Ingredients: organic sweet cream	473
6885	whole grain yellow corn	134
6886	dried cane syrup	170
6887	sorghum flour	1611
6888	Black chia seed.	1633
6889	non-fat dry milk	801
6890	stabilizer xanthan	265
6891	potassium sorbate maintains freshness. contains live and active cultures: s. thermophilus	338
6892	l. bulgarious	914
6893	bifidus.	1215
6894	enzymes ascorbic acid	650
6895	sugar. contains 2% or less of: buttermilk	1
6896	contains 2% or less of: sodium aluminium phosphate	1548
6897	dextrin tapioca	757
6899	natural and artificial flavors contains milk derivatives	7
6900	Berry blend raspberries	208
6901	Tomato pulp tomatoes	240
6902	sausage pork	534
6903	fennel seeds	231
6904	barolo wine	1634
6905	rosemary.	89
6906	pork salami pork	534
6907	cherry tomatoes	19
6908	balsamic vinegar of modena	480
6909	ground black pepper	12
6910	extra virgin olive oil onion	6
6911	sunflower seed oil	147
6912	fractionated palm kernel and palm oil	201
6913	contains 2% or less of: white wheat flour	131
6914	po	507
6915	natural and artificial flavors. polysorbate 60	196
6916	Pasteurized cultured milk and cream	7
6917	blueberry lemon zest base blueberries	411
6918	blueberry and lemon flavors	1635
6919	citrus pulp	1636
6920	fruit and vegetable juice concentrate for color	1637
6921	potassium sorb	338
6922	Cultured milk and cream	1638
6923	three cheese blend cheddar cheese	32
6924	swiss cheese	1282
6925	provolone cheese pasteurized milk and cream	1007
6926	jalape	725
6927	locust bean and guar gums	1639
6928	potassium sorbate maintains freshness.	338
6929	strawberry preserves strawberries	448
6930	natural strawberry flavors	1640
6931	red 40 salt	148
6932	or canola oil	90
6933	maltodextrin from corn	197
6934	worcestershire sa	54
6935	instant green tea	501
6936	vitamin e acetate	1405
6937	modified corn starch.	263
6938	figs preserved with sulfur dioxide	306
6939	pregelatinized corn flour	263
6940	flaked corn	134
6941	sodium aluminium sulfate	1641
6942	degerminated yellow corn meal	730
6943	soy flour. sauce: water	547
6944	tomato paste tomatoes	240
6945	seasoning blend modified corn starch	332
6946	contains less than 2% guar gum	475
6947	beet powder color	174
6948	modified food starch. mozzarella cheese blend: low moisture part-skim mozzarella cheese pasteurized milk	778
6949	mozzarella cheese substitute water	5
6950	tri-calcium phosphate	381
6951	contains less than 2% of: guar gum	475
6952	rennet casein milk protein	640
6953	enrichment blend magnesium oxide	1431
6954	ferric-ortho-phosphate	1642
6955	vitamin b12 low moisture part-skim mozzarella cheese pasteurized part-skim milk	526
6956	enzymesi	192
6957	imitation mozzarella cheese water	5
6958	low moisture part-skim mozzarella cheese pasteurized part-skim milk	531
6959	enzymes. cooked pork and chicken pizza topping: sausage made with pork and chicken pork	935
6960	dry garlic	4
6961	textured vegetable protein soy protein concentrate	1532
6962	contains 2% or less of: lactic acid starter culture	295
6963	citric acid. may also contain 2% or less of : spice	200
6964	degerminated yellow corn meal. soy flour. sauce: water	730
6965	citric acid. may also contain 2% or less of: spices	200
6966	modified food starch. mozzarella cheese blend: mozzarella cheese substitute water	778
6967	natural smoke flavoring	880
6968	sucralose sweetener	399
6969	acesulfame potassium sweetener	855
6970	potassium sorbate preserva	338
6971	l-cysteine. toppings: buffalo style fully cooked lightly breaded skinless boneless diced chicken breast meat skinless boneless chicken breast fillets with rib meat	951
6972	sauce aged cayenne peppers	1643
6973	seasoning rice flour	138
6974	extractives of pappika	934
6975	isolated soy protein product isolated soy protein	276
6976	unmodified corn starch	263
6977	with less than 2%: soy lecithin	185
6978	lightly breaded with wheat flour	131
6979	pepper sauce red pepper	195
6980	sriracha sauce red jalapenos	195
6981	aged cayenne peppers	1643
6982	seasoning blend nonfat dry milk	801
6983	ranch seasoning {maltodextrin	197
6984	disodium insosinate and disodium guanylate	1297
6985	soybean oil and less than 2%: calcium stearate to prevent caking}	243
6986	xanthan gum and spice	265
6987	green onions.	870
6988	Crust: wheat flour	131
6989	l-cysteine. toppings: sauce water	951
6990	seasoning blend whole milk powder	7
6991	buttermilk solids {whey solids	193
6992	dried cream}	1644
6993	contains less than 2% of: calcium silicate and silicon dioxide {anticaking}	631
6994	roasted mushroom	1621
6995	feta cheese pasteurized milk	1645
6996	potato starch added to prevent caking0	519
6997	white onions	9
6998	roasted garlic.	4
6999	palm pol	201
7000	l-systeine. toppings: cheese low moisture part-skim mozzarella cheese pasteurized part-skim milk	1646
7001	natamycin mold inhibitor	1008
7002	romano cheese made from cow's milk pasteurized milk	969
7003	modified food starch {corn}	263
7004	lecithin {soy}	185
7005	contains less than 2%: calcium silicate and silicon dioxide {anticaking}	631
7006	fully cooked bacon topping cured with water	1647
7007	and/or sodium ascorbate	329
7008	sodium nitrate.may contain natural smoke flavoring	952
7009	nat	1648
7010	water whey	193
7011	sorbic acid preservatives	854
7012	water. contains 2% or less of: salt	5
7013	soy sauce powder wheat	39
7014	smoke falvor	268
7015	refiner's syrup powder	170
7016	molasses powder	156
7017	enzyme modified butter oil	311
7018	dehydrated butter	2
7019	extractives of annatto and turmeric. blanched in vegetable oil.	1649
7020	modified food starch. contains 2% or less of: salt	778
7021	dried chicken skin	1650
7022	dried chicken	1651
7023	spice extractive. bleached in vegetable oil. seasoning packet: seasoning packet: sugar	199
7024	mustard. smoke flavor	95
7025	lard and partially hydrogenated lard	1652
7026	chili pepper.	195
7027	hydroxypropyl methylcellulose modified cellulose	1653
7028	whey protien concentrate	387
7029	whey maltodextrin	197
7030	caraageenan.	206
7031	dehydrated jalapeno pepper	1160
7032	sriracha chili sauce red chili peppers	195
7033	Piquillo pepper	1654
7034	red jalapeno puree red jalapeno peppers	725
7035	red chili puree red chile peppers	195
7036	garlic puree garlic	4
7037	spices clove	1655
7038	habanero pepper powder.	725
7039	Fried potato skin potatoes	34
7040	cheddar bacon cheese product cheddar cheese milk	32
7041	enzymes. bacon cured with: water	192
7042	carotenal	1249
7043	annatto and paprika for color	236
7044	fully cooked bacon cured with water	50
7045	sodium nitrite. may also contain dextrose	367
7046	dehydrated pork broth	1656
7047	fully cooked pork with barbecue sauce pork	534
7048	mesquite smoke	1657
7049	monterey jack cheese pasteurized cultured whole milk	1204
7050	contains 2% or less of: rice flour	138
7051	sodium bicarbonate. glazed with: water	24
7052	honey powder natural maltodextrin	197
7053	natural honey	36
7054	prepared mustard mustard seed	1138
7055	lemon juice powder corn syrup solids	18
7056	extractives of paprika and annatto. sauces with: aged red cayenne peppers	934
7057	food starch	139
7058	capsicum oleoresin	725
7059	tomatoes in tomato juice	240
7060	contains 2% or less of: dehydrated onions	9
7061	creamer hydrogenated coconut oil	135
7062	sodium polyphosphate	313
7063	sodium stearoyl-2-lactylate	875
7064	arabica coffee	1658
7065	cocoa pr	118
7066	Organic coconut extract	1598
7067	organic guar gum.	475
7068	Ingredients: cherries	189
7069	sulfur dioxide  preservative.	306
7070	dehydrated chopped garlic spice	4
7071	Fire roasted diced tomatoes	240
7072	diced anaheim peppers	1541
7073	diced dehydrated onions	9
7074	red jalapeno red jalapeno peppers	195
7075	red chili puree red chili peppers	195
7076	shallots	82
7077	agave nectar	344
7078	lemon grass puree lemon grass	1659
7079	ginger puree ginger	28
7080	garl	4
7081	red miso organic soybeans	277
7082	organic rice koji	1660
7083	koji spores	1661
7084	chinese hot red pepper powder	195
7085	red jalapenos red jalapeno peppers	725
7086	yeast extract salt	148
7087	natural malt flavor	391
7088	natural honey flavor.	36
7089	rice vinegar water	73
7090	red pepper powder	195
7091	horseradish horseradish	212
7092	wasabi powder horseradish powder	212
7093	glucono deta lactone	516
7094	yellow 5 xanthan gum	265
7095	mustard oil	1662
7096	disodium edta to protect flavor	455
7097	dehydrated chili peppers	710
7098	spices includes mustard	95
7099	turmeric color.	175
7100	Ingredients: farro wheat	1663
7101	salt. contains 2% or less of: corn syrup	148
7102	corn syrup. contains 2% or less of: beef	596
7103	garlic powder. barbecue sauce: water	4
7104	vinegar. contains 2% or less of: hickory smoke flavor	73
7105	worcestershire sauce vinegar	73
7106	color added.	1664
7107	Sausage: mechanically separated chicken water	1517
7108	broth: chicken broth.	41
7109	contains 2% or less of: yeas	294
7110	sugar water	1665
7111	vegetable oil contains one or more of: cottonseed oil	583
7112	vegetable oil contains one or more of cottonseed oil	583
7113	reduced ironn	251
7114	ribolflovin	818
7115	contains 2% or less of: glycerin	234
7116	sodium propionate	1601
7117	mono- and diglycerids	729
7118	cllulose gum	600
7119	coconut.	68
7120	contains 2% or less of disodium phosphate	1253
7121	fumaric acid for tartness	421
7122	natural and artificial flavorin	407
7123	Ingredients: organic tomato puree filtered water	487
7124	organic pineapple juice concentrate	497
7125	pure liquid hickory smoke flavor	749
7126	organic caramel color	357
7127	organic tamarind concentrate	453
7128	organic spices organic all spice	124
7129	organic clove	621
7130	organic red pepper	195
7131	Almondmilk filter water	1364
7150	dried egg yolk	796
7132	natural vanilla flavor with other natural flavors	20
7133	vitamin a pamitate	1171
7134	d-alpha tocopherol vitamin e.	169
7135	brewed green tea	501
7136	green tea powder	501
7137	hibiscus flavor.	434
7138	green tea flavor.	1666
7139	contains less than 2% of: cooked turkey meat	1667
7140	turkey fat	704
7141	natural favor	210
7142	natural extractives of paprika	55
7143	calcium lactate.	857
7144	contains 2% or less of: beef fat	1490
7145	succinic acid	1521
7146	grill flavor from sunflower oil.	147
7147	contains 2% or less of: wheat flour	131
7148	paprika extractives color	1668
7149	natural extractives of turmeric color	383
7151	canola and/or soybean and/or palm oil with tbhq for freshness	243
7152	cheddar and skim milk cheese skim milk	32
7153	paprika oleoresin color	55
7154	annatto and turmeric extracts color	1669
7155	canola and/or soybean and/or palm oil	26
7156	annatto and turmeric extract color.	1087
7157	cheddar cheese and white cheddar cheese pasteurized milk	32
7158	conta	200
7159	contains less than 2%: niacinamide	466
7160	vitamin b6	525
7161	contains less than 2% sucralose sweetener	399
7162	sucrose acetate	170
7163	Jalapeno puree jalapeno peppers	725
7164	tomatillo puree	900
7165	vegetable oil canola and olive oils	26
7166	habanero pepper powder	725
7167	citric a	200
7168	yellow pepper puree yellow bell peppers	195
7169	aji amarillo puree water	1670
7170	aji amarillo chili peppers	1671
7171	passion fruit juice concentrate	1618
7172	fish sauceanchovy extract	1089
7173	diced red jalapeno pepper	195
7174	contains 2% or less of: sherry cooking wine	947
7175	dehydrated minced garlic	4
7176	dehydrated basil	48
7177	red chili peppers and garlic puree	1672
7178	contains 2% or less of: orange puree	1122
7179	paprika powder	55
7180	minced garlic	4
7181	peanut paste	1673
7182	red chili peppers peppers	195
7183	mustard sauce distilled vinegar	73
7184	minced garlic garlic juice	4
7185	phosphate acid	770
7186	contains 2% or less of: rice vinegar	73
7187	onion & garlic powder	1408
7188	citrus	844
7189	bonito	1674
7190	mirinrice	1551
7191	alcohol.	384
7192	non-hydrogenated margarine palm and palm kernel oil	1675
7193	vegetable monoglyceride	592
7194	sunflower and/or safflower and/or canola oil	243
7195	seasoning tomato powder	1676
7196	sundried tomato powder	1677
7197	sp	594
7198	molasses solids	156
7199	Poblano peppers	1347
7200	sweet cr	170
7201	potassium sorbate & sodium benzoate preservatives	1678
7202	oyster sauce water	1679
7203	oyster extract	1680
7204	modified	778
7205	organic expeller pressed oils safflower	181
7206	sunflower and/or palm oil	147
7207	cheddar cheese flavor	32
7208	organic cheddar cheese organic cultured pasteurized milk	7
7209	disodium	832
7210	organic high oleic safflower oil	181
7211	cane syrup	871
7212	contains less than 2% of each of the following: sea salt	98
7213	palm and/or palm kernel	201
7214	contains less than 2% of: soy flour	547
7215	vegetable oil soybean oil	243
7216	contains less than 2% of: whey milk	193
7217	less than 2% of: malic acid	345
7218	Organic tomato puree filtered water	487
7219	organic onion pow	9
7220	potassium sorbate and sodium benzoate as preservatives	803
7221	basil extract	965
7222	distilled	384
7223	spice dehydrated onion	9
7224	caluciu disodium edta to preserve freshness.	981
7225	mustard vinegar	73
7226	dill weed	840
7227	dill extract	933
7228	semi-sweet chocolate chunks sugar	1
7229	vanilla extrac	20
7230	suagr	170
7231	baking caramel sugar	1681
7232	food starch modified tapioca	757
7233	vegetable monoglycerides	921
7234	colored with beta carotene	478
7235	hot sauce peppers	195
7236	Organic brown rice flour	261
7237	organic amaranth flour	1682
7238	organic quinoa flour.	1683
7239	Cultured milk and skim milk	7
7240	color apo carotenal	1684
7241	Concentrated grape must balsamic vinegar of modena wine vinegar	104
7242	cooked grape must caramel color	357
7243	Concentrated grape must	1685
7244	balsamic vinegar of modena wine vinegar	480
7245	cultured rice flour	138
7246	dried whole egg solids	1686
7247	whole grain amaranth seed	1687
7248	instant dry yeast	294
7249	whole grain millet seed	298
7250	whole grain teff seed	1688
7251	sugarcane molasses	156
7252	whole grain amaranth s	168
7253	dried unsweetened coconut	68
7254	peanut butter chips sugar	1
7255	palm kernel and palm oil	201
7256	calcium carbonated	529
7257	dehydrated marshmallows s	750
7258	Organic prepared black beans	1116
7259	Ingredients: granola whole rolled oats	78
7260	crisp rice rice flour	138
7261	dried malt extract dried malt	391
7262	soy proteins	276
7263	crisp rice with soy protein soy protein concentrate	276
7264	Granola whole rolled oats	78
7265	fructooligosaccharides	1689
7266	peanut butt	137
7267	Isolated soy proteins soy	276
7268	dark chocolate flavored coating sugar	1
7269	choc	118
7270	Ingredients: mixed berry flavored filling sugar	1
7271	mixed fruit puree strawberries	88
7272	apple puree apples	1690
7273	apple powder	213
7274	sodium bicorbonate	24
7275	liquid whole eggs	325
7276	calcium  carbonate	328
7277	Ingredients: strawberry flavored filling sugar	1
7278	Apple and cinnamon filling sugar	1
7279	whole rolled oat	254
7280	Ingredients: raspberry flavored filling sugar	1
7281	rasberry puree	1691
7282	blue1	1692
7283	reduced iron. thiamine mononitrate	251
7284	gaur gum	1693
7285	canola oil and/or corn oil and/or soybean oil	26
7286	yogurt flavored coating sugar	1
7287	yogurt culture	736
7288	wheat flakes wheat	143
7289	almond butter ground almonds	60
7290	betacarotene for color.	590
7291	red jalapeno puree red jalapeno peppers salt	148
7292	spices c	834
7293	contains 2% or less of: potassium chloride	1562
7294	contains 2% or less of: black pepper	12
7295	contains 2% or less of: fructose	344
7296	Organic whole grains organic whole cracked wheat	1694
7297	organic enriched unbleached wheat flour organic wheat flour	131
7298	riboflavin and folic acid	1695
7299	organic grain and seed ble	1696
7300	Organic whole grain and seed blend organic oats	78
7301	organic cracked wheat	1694
7302	organic barley flakes	255
7303	organic triticale flakes	253
7304	organic soft white wheat flakes	143
7305	organic rye flakes	217
7306	organic amaranth	168
7307	organic brown flax-seed	157
7308	organic yellow corn meal	730
7309	organic whe	193
7310	organic vital wheat gluten	955
7311	organic cultured wheat flour	131
7312	organic sesam	153
7313	White popcorn.	589
7314	Yellow popcorn.	589
7315	Corn bread: enriched flour wheat flour	131
7316	reduced barley iron	251
7317	yellow cornmeal	149
7318	inverted cane sugar	1697
7319	salt. country style breaded chicken: boneless chicken breast meat with rib meat	140
7320	seasoning modified corn starch	332
7321	breaded with enriched wheat flour wheat flour	131
7322	paprika for color	195
7323	spice extractives. process american white cheese product: cultured milk and skim milk	295
7324	Waffle: enriched flour wheat flour	131
7325	soy lecithin. process american white cheese product: cultured milk and skim milk	185
7326	soy lecithin. peppered bacon strips: pork coated with black pepper and sugar. cured with: water	185
7327	Ingredients: prepared organic black beans	1116
7328	organic chili pepper	710
7329	organic cumin	43
7330	organic  distilled vinegar	480
7331	organic cayenne pepper	69
7332	organic coriander.	106
7333	Mineral water carbon dioxide	529
7334	Mineral water	1698
7335	carbon dioxide	529
7336	natural mango flavor.	1699
7337	blend soybean oil	243
7338	sweet cream butter milk	473
7339	soybean lecithin soy	185
7340	potassium sorbate and citric acid added as preservatives	1700
7341	calcium disodium edta used to protect quality	455
7342	vitamin a palmitate added.	1171
7343	Liquid soybean oil	243
7344	palm oil and palm kernel oil	201
7345	salt whey	140
7346	mil	640
7347	soybean lecithin  soy	185
7348	colored	1637
7349	with beta carotene	590
7350	palm oil palm kernel oil	286
7351	potassium sorbate and lactic acid added as preservatives	1701
7352	soy lecithin soy	185
7353	calcium disodium edta colered with beta carotene	843
7354	mono and diglycerdies	729
7355	and vitamin d3 cholecalciferol added.	1184
7356	palm oil and diglycerides	201
7357	Pasteurized whole milk	891
7358	guar bean gum	475
7359	acacia fiber	929
7360	garnish hazelnuts	300
7361	dark chocolate flakes sugar	1
7362	cocoa paste	118
7363	soy lecithin emulsifier.	185
7364	papr	55
7365	Ice cream: milk fat and nonfat milk	7
7366	polysorbate 80. strawberry flavored center: water	613
7367	Whole wheat thin bagel: whole wheat flour	283
7368	contains 2% or less of: polydextrose	922
7369	protein blend soy rice crisps{isolated soy protein	276
7370	date paste organic toasted oats organic whole grain oats	78
7371	organic evaporated cane sugar	170
7372	mixed tocopherols	1612
7373	dark chocolate	763
7374	protein blend soy rice crisps isolated soy protein	276
7375	date paste	1702
7376	organic toasted oats organic whole grain oats	78
7377	organic peanu	137
7378	white chocolate cane sugar	1
7379	organic toasted oats	78
7380	Organic coconut sugar.	609
7381	soy protein crisp rice rice flour	276
7382	pumpkin seeds	177
7383	dried kale	841
7384	organic madagascar bourbon vanilla vani	20
7385	cashew butter ground cashes	1703
7386	soy crisps rice flour	142
7387	cinn	15
7388	dark chocolate cocoa	118
7389	soy protein	276
7390	drie	1704
7391	Vanilla ice cream skim milk	1705
7392	milk chocolate coating sugar	1
7393	beef and modified food starch product beef	33
7394	less than 2% of: sesame oil	112
7395	rice wine distilled rice	384
7396	stabilizer corn starch	263
7397	balsamic vinegar wine vinegar	480
7398	grape must	150
7399	garlic with water and citric acid	4
7400	rendered chicken fat	1467
7401	Cooked enriched pasta water	1706
7402	enriched durum semolina durum semolina wheat flour	131
7403	grilled seasoned chicken breast strips with rib meat chicken breast with rib meat	1156
7404	less than 2% of: parmesan cheese pasteurized part-skim milk	62
7405	cheese flavor parmesan cheese pasteurized milk	62
7406	romano cheese pasteurized part skim cow's milk	969
7407	Cooked long grain rice	1707
7408	fully cooked grilled skinless boneless sliced chicken breast meat strips with rib meat skinless boneless chicken breast meat with rib meat	117
7409	and celery	27
7410	less than 2% of: orange juice concentrate	65
7411	balsamic vinegar reduction	104
7412	orange oil.	1118
7413	citric acid provides tartness	200
7414	contains less than 2% of: ascorbic acidvitamin c	329
7415	sodium citrate and potassium citrate controls acidity	200
7416	silicon dioxide prevents caking	309
7417	dl-alpha-tocopherol	169
7418	citirc acid provides tartness	200
7419	contains less than 2% of: ascorbic acid vitamin c	329
7420	Organic coconut flour.	1708
7421	california red bell peppers	536
7422	oregon pears	788
7423	dri	1709
7424	contains 2% or less of each of the following: salt	140
7425	dried honey solids	36
7426	dough conditioners e	1052
7427	contains 2% or less of: cream	473
7428	contains 1% or less of: soybean oil	243
7429	natural flavor contains wheat.	143
7430	disodium edta to protect flavor.	455
7431	honey solids refinery syrup	36
7432	molasses sucralose	399
7433	bourbon whiskey	384
7434	not more than 2% calcium silicate added to prevent caking	1010
7435	peanuts oil.	741
7436	concentrated butter	2
7437	wheat syrup	1710
7438	worcestershire powder maltodextrin worcestershire sauce distilled vinegar molasses	197
7439	garlic powder sugar	1
7440	vinegar powder maltodextrin w	73
7441	2% or less of the following: salt	148
7442	sodium phosphates.	570
7443	canola and/or soybean and/or palm oil dark chocolate flavored confectionary chip sugar	1
7444	soy lecithin iodied salt	185
7445	artificial flavor vanillin	186
7446	high fructose co? syrup	344
7447	baking powder sodium am pyrophosphate	780
7448	naicin	466
7449	lecithin emulsifier.	185
7450	whole grain oats	78
7451	raisin paste	1711
7452	contains 2% or less of: eggs	3
7453	Organic seaweed	1034
7454	corn sugar	750
7455	baking soda leavening	258
7456	monocalcium phosphate leavening	259
7457	ammonium bicarbonate leavening.	24
7458	ammonium bicarbonate leavening	24
7459	vegetable oil high oleic soybean and/or partially hydrogenated soybean and/or partially hydrogenated cottonseed	243
7460	sodium caseinate a milk derivatives	640
7461	contains 2% or less of: propylene glycol	616
7462	natural and artificial	1403
7463	pol	1712
7464	100% durum whole wheat flour.	283
7465	fennel	231
7466	ascorbic acid as a dough conditioner.	329
7467	vegetable oil contains one or more of the following: soybean	243
7468	hydrogenated soybean	243
7469	hydrogenated cottonseed	1001
7470	disodium dihydrogen pyrophosphate to promote colo	1713
7471	bht and mixed tocopherols added to preserve freshness.	1714
7472	contains 2% or less of: flax seeds	157
7473	ba	255
7474	contains 2% or less of: olive oil	6
7475	contains 2% or less of: salt.	148
7476	dehydrated roasted garlic	4
7477	cayenne & arbol chili peppers	195
7478	Diced onions	9
7479	modified corn starch. contains 2% or less of: calcium chloride	561
7480	oleoresin paprika color	55
7481	yellow corn flour.	165
7482	Durum wheat semolina niacin	466
7483	ferrous lactate iron	251
7484	contains 2% or less of: citric acid	200
7485	dried red chile peppers	195
7486	yeast extract.	209
7487	contains 2% or less of: caramel color	357
7488	dehydrated minced onions	9
7489	contains 2% or less of the following: salt	148
7490	Organic unsweetened coconut chips.	68
7491	Grade a pasteurized cream	473
7492	modified guar gum	475
7493	acesulfame potassium and sucralose non-nutritive sweeteners. vitamins and minerals: sodium ascorbate	1715
7494	Organic degerminated yellow cornmeal	149
7495	organic white rice flour	138
7496	organic potato starch	519
7497	organic degerminated corn flour	165
7498	organic cornstarch	263
7499	untreated sea salt	98
7500	organic gum blend organic guar and locust bean gums.	1716
7501	organic gum blend organic guar and locust bean gums	390
7502	organic cocoa powder	118
7503	organic vanilla flavor	20
7504	traces of lime.	85
7505	Prepared black beans	669
7506	Albacore white tuna	1717
7507	vegetable broth soybean flakes	256
7508	celery extracts	706
7509	sodium pyrophosphate.	518
7510	Decaffeinated green tea.	501
7511	folic aid	727
7512	liquid and hydrogenated soybean oil	243
7513	sodium bisulfite.	1289
7514	maltodextrin. beta carotene for color	197
7515	Ingredients: aged cayenne red peppers	1643
7516	Pineapple.	63
7517	100% basmati rice.	1718
7518	Purified water	5
7519	paprika extract added for color	55
7520	and natural flavor.	210
7521	yogurt powder cultured nonfat milk	7
7522	milk protein concentrate lactic acid	295
7523	sodium acid pyrophos-phate	780
7524	soy lecithin. vitamins and iron: vitamin a palmitate	185
7525	hydrogenated vegetable oil coconut oil	135
7526	contains less than 2% of: light cream	473
7527	sodium caseinate from milk	640
7528	xanthan guar gum	475
7529	contains less than 2% of: sodium caseinate	847
7530	light cream	1719
7531	vegetable juice blend carrot juice concentrate	1056
7532	natural flavors dextrose	750
7533	dehydrated carrot juice concentrate	119
7534	beef extract. adds a trivial amount of fat	1307
7535	saturated fat. adds a trivial amount of sugars.	1720
7536	high oleic soybean oil	243
7537	less than 2% of: sodium caseinate a milk derivative	847
7538	mixed tocopherols for freshness.	154
7539	less than 2% of: sodium caseinate  a milk derivative	847
7540	less than 2% of: maltodextrin	197
7541	mixed tocopherols f	1612
7542	less than 2% of: sugar	1
7543	less than 2% of sodium caseinate from milk	640
7544	peppermint bark sauce sugar	1
7545	carrageenan gum	206
7546	caramel sauce corn syrup	596
7547	caramel sugar	1681
7548	nonfat	887
7549	Pomegranate arils.	412
7550	cinnamon bits sugar	15
7551	juice infused cranberries cranberries	126
7552	pear juice from concentrate	284
7553	sweet cherry juice from concentrate	170
7554	peach juice from concentrate	499
7555	aronia juice	1721
7556	natural mango extract	1722
7557	thaimin mononitrate vitamin b1	1723
7558	follic acid	727
7559	soybean and/or vegetable oil palm	201
7560	water. contains 2% or less of each of the following: skim milk	5
7561	pyrophosp	1724
7562	Skip jack tuna	1725
7563	ranch dressing water	5
7564	mixed tocopherols for freshnes	154
7565	vegetable broth soybean flakes extract	1054
7566	carrot extract	1339
7567	celery extract	706
7568	protein chips water	5
7569	whey protein	387
7570	bananas ascorbic and citric acid to preserve color.	92
7571	wate	5
7572	vegetable oil contains one or more of the following oils	26
7573	corn. contains 2% or less of annatto color	134
7574	sodium acid pyrophosphate added to maintain color.	780
7575	corn. contains 2% or less of corn starch- modified	134
7576	cottonseeds	1726
7577	corn. contains 2% or less of corn starch - modified	134
7578	dehydrade onion	699
7579	corn. contains 2% or less of dextrose	134
7580	Ingredients: cayenne red peppers	195
7581	non-hydrogenated palm oil contains tbhq	201
7582	ascorbyl palmitate	650
7583	inverted sugar syrup	471
7584	Focaccia bread wheat flour	131
7585	creme fraiche sauce water	5
7586	creme fraiche cultured pasteurized cream	473
7587	pecorino romano cheese sheep's milk	1727
7588	che	38
7589	goat cheese sauce water	1728
7590	semisoft part-skim cheese pasteurized goat's milk	1728
7591	emmentaler cheese pasteurized cow's milk	1729
7592	pea starch	1730
7593	roasted garlic garlic	4
7594	palm oil.	201
7595	cane molasses.	156
7596	palm and/or canola oil	26
7597	precooked corn meal	149
7598	thiamine mononitrate.	1085
7599	less than 2% of: onion powder	121
7600	dried bell pepper.	536
7601	natural flavors contains soy and wheat	1004
7602	cashews cashews	145
7603	contains less than 2% of: natural flavorings	1731
7604	salt. adds a trivial amount of saturated fat.	140
7605	beef extract. adds a trivial amount of fat and saturated fat. adds a trivial amount of suagrs.	1307
7606	mushroom juice concentrate	1622
7607	bay leaf	107
7608	organic chicken flavor	1572
7609	organic natural flavor	210
7610	organic vegetable juice blend organic tomato paste	240
7611	organic celeriac juice concentrate	1144
7612	organic dex	170
7613	Concentrated organic juice.	1732
7614	Ingredients: hard boiled eggs eggs	3
7615	preservatives citric acid sodium benzoate.	200
7616	oat and honey cluster sugar	1733
7617	toasted oats rolled oats	78
7618	mixed tocopherols a preservative	1612
7619	wheat bits whole wheat flour	283
7620	bht to preserve freshness	721
7621	malt syrup. vitamins & minerals: niacinamide	176
7622	Concentrated orange juice calcium phosphate	65
7623	ingredients not found in regular juice	337
7624	chili powder chili peppers	195
7625	contains 2% or less of tomato paste	83
7626	hydrolyzed soy	276
7627	and wheat protein	514
7628	autolyzed yeast.	209
7629	ascorbic acid vitamin c malic acid concentrated blackberry juice	329
7630	concentrated strawberry juice	1233
7631	concentrated raspberry juice.	961
7632	and/or corolla oil	1734
7633	corn starch citric acid	200
7634	live juice powder	1735
7635	garli	4
7636	contains less than 2% of: natural and artificial flavors	940
7637	silicone dioxide	309
7638	concentrated lemon juice lemon pulp	18
7639	lemon oil.	910
7640	contains less than 2% of: sodium caseinate a milk derivative	847
7641	mono - and diglyc	1736
7642	acesulfame-k	1737
7643	lime pulp	61
7644	Pasteurized cultured organic lowfat milk	7
7645	organic strawberry flavor	1738
7646	organic beet powder for color	174
7647	vitamin c	329
7648	water cranberry juice concentrate	1739
7649	Organic low-moisture part-skim mozzarella cheese organic cultured pasteurized reduced fat milk	531
7650	powdered cellulose added to prevent caking.	740
7651	concentrated pineapple juice	497
7652	Organic colby jack cheese organic cultured pasteurized milk	7
7653	organic annatto vegetable color	722
7654	Blueberries.	1740
7655	sucrose.	1
7656	Blackberries.	658
7657	Dark sweet cherries.	1741
7658	dried yeast. vitamins and minerals: reduced iron	1742
7659	pyridoxine	525
7660	hydrochloride	148
7661	sodium bicarbonate. vitamins and minerals: calcium carbonate	24
7662	vitamins and minerals: calcium carbonate	203
7663	blueberry nuggets dextrose	750
7664	artificial blueberry flavor	1565
7665	souy lecithin	185
7666	vitamin b 12	1191
7667	thiamine f mononitrate	468
7668	Olive oil composed of refined olive oils and extra virgin olive oils.	6
7669	Olive oil composed of refined olive oils and extra virgin olives oiles.	6
7670	virgin olive oil.	6
7671	Cultured pasteurized grade a milk	7
7672	fruit and vegetable juice color	768
7673	agar.	342
7674	vegetable juice color.	768
7675	calcium ch	340
7676	organic expeller pressed coconut oil	135
7677	natural flavors contains butter	2
7678	bell pepper.	195
7679	white destilled vinegar	480
7680	molasses powder molasses	156
7681	extractive of paprika	934
7682	rice concentrate.	138
7683	green olives	1476
7684	2% or less of: tomato powder	1676
7685	feta and cheddar cheese powders feta and cheddar cheese pasteurized milk	640
7686	2% or less of: cheddar cheese powder cheddar cheese milk	32
7687	enzymes disodium phosphate	1253
7688	natural flavors including romano cheese	969
7689	spices including rosemary	89
7690	Orzo enriched durum semolina flour flour	1743
7691	contains 2% or less of: tomatoes with sulfur dioxide for color retention	19
7692	chile peppers	195
7693	saffron powder.	1744
7694	radish seeds	1745
7695	bell pepper	536
7696	Couscous wheat flour	131
7697	parmesan truffle seasoning non-fat dried milk	1746
7698	dried mushrooms	1747
7699	truffle salt salt	148
7700	truffles	1748
7701	parmesan cheese flavor maltodextrin	197
7702	whey solids	193
7703	natural flavor whey solids	193
7704	natural cream flavor	473
7705	natural mushroom flavor	1622
7706	truffle flavor maltodextrin	197
7707	dried truffles	1748
7708	arrowroot	1749
7709	Organic cultured pasteurized nonfat milk	7
7710	organic milk and organic cream	7
7711	carbon dioxide to maintain freshness	529
7712	and live and active cultures: l. acedophilus and bifidobacterium bifidum.	1750
7713	Organic cultured cream	473
7714	potassium hydroxide	1751
7715	Organic stone ground yellow corn masa flour	165
7716	organic expeller pressed high-oleic sunflower and/or safflower oil	1375
7717	trace of lime.	200
7718	contains less than 2% of each of the following: salt	148
7719	calcium propionate prese	911
7720	degerminated y	1752
7721	contains less than 2% of each of the following: yeast	294
7722	dehydrated jalapeno peppers	1160
7723	dough conditioners mono- and d	1753
7724	contains 2% or less of the following: soybean oil	243
7958	Okra.	1778
7725	Enriched wheat flour wheat flour malted barley flour	131
7726	thiamine mononitrete	1085
7727	thiamine mononitrte	468
7728	contains 2% less of the following: soybean oil	243
7729	Organic almondmilk filtered water	1364
7730	dl-alpha tocopherol acetate vitamin e	169
7731	Organic almondmilk	1364
7732	organic vanilla extract	20
7733	dl-alpha t	1754
7734	organic steel cut white whole wheat	802
7735	organic wheat gluten	955
7736	organic black sesame seed	1755
7737	organic brown flax seed	157
7738	organic poppy seed	745
7739	contains 2% or less of the following: organic crimson red	1756
7740	organic white whole wheat	802
7741	contains 2% or less of the following: organic brown flax seed	157
7742	organic b	174
7743	organic whole grain wheat	143
7744	organic	1592
7745	contains 2% or less of the following: organic soybean oil	243
7746	organic white distilled vinegar	480
7747	cultured organic unbleached wheat flour	131
7748	Enriched durum wheat semolina flour	131
7749	ferrous	251
7750	Cotton candy: cultured lowfat milk	7
7751	cotton candy flavor water	1757
7752	fruit juice color	722
7753	vitamins ascorbic acid vitami	329
7754	organic ginger root	28
7755	organic lemon grass	1659
7756	organic spearmint.	824
7757	chicken paste chicken meat	57
7758	natural flavor contains onion	9
7759	coconut cream coconut extract	1598
7760	red sweet peppers	195
7761	lemongrass. contains 2% or less of: salt	148
7762	red jalapeno peppers	836
7763	lemongrass	1758
7764	contains 2% or less of: soy butter soybeans	142
7765	monoglycer	592
7766	lemon flavored pieces sugar	1
7767	less than 2% of: nonfat dry milk	887
7768	smoke flavor maltodextrin	197
7769	quinoa	167
7770	egg whites. sauced with: water	244
7771	honey powder maltodextrin	197
7772	garlic power	45
7773	contains 2% of less of the following: baking soda	24
7774	mono-diglycerides	729
7775	sodium stearoyllactylate	875
7776	monoglyceride	592
7777	corn syrup solds	596
7778	sodium caseinate milk protein	640
7779	food starch-modified.	778
7780	sugar. contains 2% or less of the following: buttermilk.	1
7781	caramel milk	7
7782	Mandarin oranges mandarin oranges	1417
7783	greek yogurt skim milk	472
7784	margarine liquid soya oil	243
7785	hydrogenated soya oil	243
7786	whey powder enriched with lactose	405
7787	plant mono- and diglycerides	729
7788	cream milk	7
7789	icing sugar granulated sugar	170
7790	gum blend gum acacia	1759
7791	modified gum acacia	390
7792	orange emulsion water	1760
7793	Strawberry fruit prep strawberries	448
7794	monopotassium phosphate.	848
7795	ester gum yellow 6	794
7796	preservatives ascorbic acid	329
7797	contains 0.5% or less of: dipotassium phosphate	194
7798	Milk. contains 0.5% or less of: dipotassium phosphate	779
7799	vitamin a palmitate. adds a trivial amount of fat.	1171
7800	vegetable oil containing one or more of the following: palm	201
7801	sodium cageinatiea milk derivative	640
7802	contains 2% or less of: silicon dioxide	309
7803	artificial color.	648
7804	monoglycerides. contains 2% or less of: silicon dioxide	921
7805	artificial col	648
7806	sodium alginate guar gum	475
7807	less than 2% of: sucralose	399
7808	sodium benzoate and potassium benzoate preservatives.	454
7809	less than 2% of: black currant juice concentrate	349
7810	Jasmine green tea.	1761
7811	hibiscus	434
7812	dried cranberries	737
7813	safflower petals	346
7814	cornflower petals.	1762
7815	lavender petals	1763
7816	dried cranberries.	1764
7817	blackberry leaves	1765
7818	chicory root	1279
7819	lemon peels	317
7820	dried peaches.	444
7821	apple pomace	1766
7822	rosehips	1767
7823	elderberry	1414
7824	black currant	349
7825	dried raspberries	208
7826	Parmesan cheese culture pasteurized part-skim milk	62
7827	powdered cellulose added to prevent caking	740
7828	potassium sorbate a preservative.	338
7829	hydrogenated coconut and soybean oils	1227
7830	leavening sodium acid pyrophosphates	780
7831	extractives of garlic.	1261
7832	meyer lemon zest.	1768
7833	corn black beans	1116
7834	palm kernel and palm oils	201
7835	organic whole rolled rye	217
7836	organic whole oat flour	274
7837	organic malt extract	391
7838	organic nonfat dry milk	801
7839	organic soy lecithi	185
7840	organic whole oat flour organic brown sugar	274
7841	organic dehydrated blueberries organic blueberries	411
7842	organic sunflower o	147
7843	vegetables oil contains one or more of: canola	90
7844	fiber pea	1769
7845	molasses powder refiners syrup	156
7846	sodium acid pyrophosphate maintains natural color & leavening	780
7847	rosemary seasoning dextrose	750
7848	spice rosemary	89
7849	sunflowe	147
7850	malted barley with sulfites	255
7851	spread: interesterified soybean oil	243
7852	contains less than 2% of: butter cream	2
7853	smoked provolone cheese pasteurized milk	1007
7854	natamycin preservative.	1008
7855	Organic pasteurized milk and cream	7
7856	organic carob bean gum.	205
7857	and enzymes.	1596
7858	Ground organic blue corn	838
7859	organic expeller pressed vegetable oil organic sunflower and/or organic safflower oil	147
7860	sa salt.	148
7861	Colby and monterey jack cheese pasteurized milk	1009
7862	Ingredients: filling high fructose corn syrup	344
7863	blueberry puree concentrate	411
7864	methylecllulose	743
7865	whole  grain rolled oats	78
7866	riboflavvin	818
7867	vegetable oil  blend canola	90
7868	palm and palm kernel oils	201
7869	contains 2% or less of nonfat dry milk	801
7870	leavening potassium bicarbonate	24
7871	thiamin hydrochloride vitamin b1	1085
7872	cyanocobalamin vitamin b12	526
7873	dried fruit and nut blend almonds	60
7874	less than 2% vegetable oil canola	90
7875	annato color	722
7876	dried fruit and nut blend cashews	145
7877	less than 2% canola oil	90
7878	Carbonated water cane sugar	1
7879	fruit juice for color	1770
7880	vegetable oil  sunflower	147
7881	rice and/or cottonseed	583
7882	butter pasteurized sweet cream	1771
7883	cottonseed and/or rice	583
7884	white cheddar cheese popcorn popcorn	38
7885	ve	169
7886	mixed tocopherols vitamin e added to preserve freshness. vitamins and minerals: tricalcium phosphate	1612
7887	vitamin a palmitate folic acid	1171
7888	vitamin d. bht added to packaging material to help preserve freshness.	581
7889	Pasteurized butter cream	2
7890	Light tuna	1113
7891	vegetable broth	1772
7892	chili pepper sauce chili	195
7893	potassium sorbate and sodium bisulfite preservatives	1773
7894	less than 1/10 of 1% of sodium benzoate and potassium sorbate preservatives	354
7895	vegetable oils palm soybean and/or cottonseed. contains 2% or less of: leavening baking soda	24
7896	sorbic acid and citric acid preservatives	1774
7897	Enriched bleached flour  wheat flour	131
7898	dextrose contains 2% or less of: potassium chloride	1562
7899	potassium sorbate and tbhq preservatives	1775
7900	aluminium sulfate	1641
7901	aluminum sulfate. contains 2% or less of: sugar	612
7902	dextrose. contains 2% or less of: salt	750
7903	yeast yellow 5	976
7904	potassium sorbate and citric acid and tbhq preservatives.	1454
7905	gum acacia.	390
7906	black pepper powder	10
7907	papaya juice	935
7908	Filling: cooked eggs whole eggs	14
7909	salsa diced tomatoes in juice tomatoes	240
7910	tomatillos	900
7911	roasted jalapeno peppers jalapeno peppers	1160
7912	flavor enhancer yeast extract	209
7913	sunflower oil {anti dusting agent}	147
7914	black peppers	12
7915	roasted potatoes potatoes	34
7916	cooked black beans black beans	669
7917	roasted red bell peppers red bell peppers	195
7918	cream cheese pasteurized cultured milk and cream	30
7919	stabilizers xanthan and/or carob bean and/or guar gums	265
7920	sour cream cultured pasteurized milk	25
7921	cayenne pepper. salsa tortilla: unbleached wheat flour	195
7922	salt. water	140
7923	buttermilk. contains less than 2% of: tapioca starch - modified	72
7924	pgpr emulsifier	1482
7925	organic chili powder organic chili peppers	710
7926	sea salt organic garlic	4
7927	sugar almonds	60
7928	rice corn syrup	596
7929	natural & artificial flavor induces coconut	68
7930	bht preservative. vitamins and m	721
7931	natural & artificial flavor includes coconut	316
7932	bht preservative.vitamins and minerals:	721
7933	roasted tomato puree	487
7934	fire roasted tomatoes	1346
7935	Biscuit: bleached enriched flour wheat flour	131
7936	biscuit base sugar	1
7937	potassium sorbate preservative. pork sausage pam: pork	338
7938	soy lecithin. process american sharp cheese: cultured milk and skim milk	185
7939	English muffin: enriched unbleached flour wheat flour	131
7940	contains 2% or less of: yellow corn meal	730
7941	sodium nitrite. process american sharp cheese: cultured milk and skim milk	1368
7942	Pancake ingredients: water	5
7943	nonfat dry milk. cooked in vegetable oil contains one or more of: corn	801
7944	Bread:enriched wheat flour flour	131
7945	yeast. contains 2% or less of sugar	1776
7946	dough conditioners mono-and diglycerides	729
7947	yeast nutrients calcium sulfate	924
7948	ammonium chloride	462
7949	batter: water	5
7950	Durum whole wheat flour	239
7951	Durum whole wheat flour.	239
7952	redchilies	195
7953	modified tapiova starch	757
7954	Baby corn	1777
7955	emulsifiers soy lecithin	185
7956	Italian green beans	1044
7957	Fordook lima beans	228
7959	breading enriched yellow corn meal	1779
7960	enriched white corn meal	149
7961	enriched yellow corn flour	165
7962	batter water	5
7963	Spaghetti pasta-cooked enriched egg noodle product wheat flour wheat	143
7964	Zucchini	87
7965	red peppers.	195
7966	italian green beans and red peppers.	1780
7967	Parboiled brown rice water	724
7968	Chicken breast meat	1380
7969	Oregon red raspberries	208
7970	potassium sorbate and sodium benzoate to preserve freshness	803
7971	Blenched wheat	131
7972	horseradish grated horseradish roots	212
7973	sodium metabisulfite and sodium benzoate preservatives	397
7974	cellulose and xanthan gums	600
7975	calcium disodium edta retains freshness	455
7976	diced red jalapenos red jalapeno peppers	725
7977	cayenne pepper sauce cayenne peppers	195
7978	garlic onion powder	1781
7979	sweet bell pepper	195
7980	extractive of paprika.	934
7981	natural smoke flavor.	268
7982	ancho chiles	1782
7983	natural flavor corn syrup solids	596
7984	soy sauce solids wheat	39
7985	natural flavoring silicon dioxide to prevent caking.	309
7986	lime flavor sugar	1
7987	Bread crumbs enriched wheat flour wheat flour	131
7988	silicon dioxide to prevent caking	309
7989	long grain parboiled rice	1411
7990	corn peas	132
7991	dehydrated carrots	119
7992	canola oil. contains 2% or less of: salt	90
7993	chicken base chicken meat including natural chicken juices	57
7994	magnesium carbonate	1783
7995	standardized with sugar sucrose and/or dextrose	170
7996	extractives or turmeric for color.	175
7997	long grain brown rice. contains 2% or less of: canola oil	305
7998	pectin standardized with sugar sucrose and/or dextrose	337
7999	red beans	1318
8000	vitamin a palmitate added	1171
8001	seasoning dehydrated onions	9
8002	smoke flavor. contains 2% or less of: garlic garlic	268
8003	natural flavor hydrolyzed soy protein	276
8004	bacon flavor from: bacon cured with water	268
8005	sodium nitrite. may contain: potassium chloride dextrose	367
8006	bacon fat	704
8007	long grin parboiled rice	1411
8008	chicken base chicken meat including chicken juices	57
8009	natural flavor. contains 2% or less of: rendered chicken fat	1148
8010	extractives of turmeric for color.	1784
8011	modified cornstarch. contains 2% or less ascorbic acid vitamin c	778
8012	beta-carotene	590
8013	ascorbic	329
8014	Sardines	1785
8015	Smoked oysters in conttonseed oil	1786
8016	Crabmeat	815
8017	sodium metabisulfite.	397
8018	high oleic canola & fully hydrogenated cottonseed oils	90
8019	Key lime juice	200
8020	sucroglycerides emulsifier	1787
8021	Sesame seed bun: enriched bleached wheat flour wheat flour	131
8022	contains 2% or less of: yeast yeast	294
8023	calcium propionate preservatives	911
8024	monoglycerides with ascorbic acid and citric acid antioxidants	1788
8025	ascorbic acid. fully cooked flamebroiled chopped beef steak smoke flavor added: beef	329
8026	encapsulated salt	148
8027	grill flavor from partially hydrogenated soybean/cottonseed oil	243
8028	soy lecithin non-sticking agent.	185
8029	corn syrup solids. pasteurized process american cheese: cheddar cheese pasteurized milk	38
8030	Cooked breaded chicken breast patty with rib meat: chicken breast with rib meat	1156
8031	salt. modified food starch	1789
8032	papri	55
8033	Tomato sauce water	5
8034	cooked pasta semolina flour durum semolina	451
8035	Artichoke hearts	1342
8036	pyridoxine hydrochloride b6	525
8037	and cyanocobalamin b12	1790
8038	romano cheese part-skim milk	1791
8039	breadcrumbs bleached wheat flour	131
8040	whey. contains 2% or less of: leavening baking soda	193
8041	soybean and/or cottonseed. contains 2% or less of: leavening baking soda	24
8042	Enriched bleached flour water flour	8
8043	semisweet chocolate chips sugar	1
8044	eggs. contains 2% or less of each of the following: skim milk	3
8045	Wheat english muffin: bleached enriched flour wheat flour	131
8046	egg flavor medium chain triglycerides	1019
8047	turkey sausage patty: turkey	1095
8048	riboflavin and cyanocobalamin	1792
8049	bha. process american sharp cheese: cultured milk and skim milk	720
8050	Ingredients: corn masa flour	165
8051	sunflower and/or corn oil	1793
8052	Ingredients:dried cranberries cranberries	126
8053	honey roasted pecans pecans	49
8054	honey powder sucrose	170
8055	vegetable oil may contain one or more of: canola	90
8056	sunflower and/or soybean	185
8057	White tea	1794
8058	dried pomegranate.	412
8059	squash.	347
8060	In-shell roasted peanuts	173
8061	contains up to a 16% solution of water	603
8062	Iceberg lettuce	503
8063	red cabbage.	113
8064	Romaine lettuce	324
8065	radish.	372
8066	endive	1795
8067	radicchio.	1796
8068	Hearts of romaine lettuce.	324
8069	leaf lettuces.	324
8070	radish	372
8071	Baby spinach	79
8072	Baby spinach.	79
8073	Baby spring mix may contain some or all of the following baby whole leaf varieties: green leaf	1797
8074	mizuna	1798
8075	green romaine	324
8076	tango	420
8077	green oak	1799
8078	green chard	1800
8079	arugula	1801
8080	frisee	1795
8081	tatsoi	1802
8082	mache	1803
8083	red chard	1804
8084	red leaf	1805
8085	lolla rosa	1806
8086	red romaine	1807
8087	red mustard	1808
8088	radicchio	1796
8089	red oak	1809
8090	beet tops.	1810
8091	spring mix may contain some or all of the following baby whole leaf varieties: green leaf	1797
8092	ref leaf	1805
8093	beet tops	1810
8094	Butter lettuce and lolla rosa.	324
8095	Fresh squeezed orange juice	65
8096	In-shell roasted peanuts.	173
8097	Organic spring mix may contain some or all of the following organic baby whole leaf varieties: organic green leaf	324
8098	organic mizuna	1798
8099	organic green romaine	324
8100	organic tango	1811
8101	organic green oak	501
8102	organic green chard	1800
8103	organic baby spinach	79
8104	organic arugula	1812
8105	organic frisee	1813
8106	organic tatsoi	1802
8107	organic mache	1803
8108	organic red chard	1804
8109	organic red leaf	1805
8110	organic lolla rosa	1806
8111	organic red romaine	324
8112	organic red mustard	1808
8113	organic radicchio	1796
8114	organic red oak	1814
8115	organic beet tops	1810
8116	organic herbs organic parsley	22
8117	organic dill	840
8118	organic cilantro.	47
8119	Organic baby romaine	1815
8120	Organic baby spinach leaves	79
8121	organic beet tops.	1810
8122	organic beet tops. mix may vary by season	1810
8123	Organic arugula.	1812
8124	Organic mango chunks.	190
8125	Organic tomatillos	900
8126	organic jalapeno pepper puree	195
8127	organic lime juice concentrate	61
8128	milk traces	640
8129	papaya papaya evaporated cane syrup	1
8130	cranberries cranberries	126
8131	cranberry seed oil	1816
8132	dark chocolate raisins dark chocolate coating unsweetened chocolate	1817
8133	soy lecithin {an emulsifier} natural vanilla	185
8134	milk}	7
8135	pure food glaze	1818
8136	dry roasted cashews	145
8137	pine nuts.	1819
8138	Roasted cashews	145
8139	extractives of spice	1527
8140	expeller pressed canola oil and/or expeller pressed sunflower oil.	26
8141	Root vegetables sweet potato	370
8142	sweet potato colored with beet juice	174
8143	taro	1820
8144	batata	370
8145	parsnip	1821
8146	expeller pressed canola oil and/or safflower oil and/or sunflower oil	26
8147	Organic beef	33
8148	organic apple cider vinegar	480
8149	seasoning celery powder	1069
8150	natural smoke flavoring.	880
8151	organic green bell peppers	66
8152	organic jalapeno peppers	1160
8153	organic chipotle pepper powder.	195
8154	organic chipotle pepper powder	1363
8155	organic fire roasted tomatoes	240
8156	organic roasted corn	134
8157	organic roasted onions	9
8158	organic marjoram	1822
8159	organic thyme.	44
8160	organic vegetable base organic vegetable concentrate organic tomato	240
8161	organic celeriac	1823
8162	organic onion organic carrot	9
8163	organic vegetables organic celery	27
8164	yeast extrac	294
8165	Pitted prunes	1824
8166	Prunes	321
8167	potassium sorbate added as a preservative	338
8168	Organic raisins.	67
8169	organic tango.organic green oak	1825
8170	ranch dressing soybean oil	243
8171	buttermilk cultured pasteurized skim milk and milk	7
8172	ranch seasoning and spices salt	148
8173	natural and artificial flavor {includes milk	316
8174	soybean}	256
8175	spices xanthan gum	265
8176	contains less than 2% of: distilled vinegar	480
8177	natural flavor includes milk	7
8178	broccoli florets.	116
8179	contains less than 2% of: distilled venegar	480
8180	grape tomatoes	19
8181	waffle pretzels unbleached enriched wheat flour flour	131
8182	apples apples and calcium ascorbate vitamin c	650
8183	calcium salt	340
8184	annatto vegetable color.	722
8185	Portobello whole mushrooms.	1826
8186	Sliced mushrooms.	46
8187	Romaine	1815
8188	Organic green romaine.	1827
8189	seasoned chicken breast with rib meat chicken breast with rib meat	1156
8190	less than 2% soy protein concentrate	276
8191	caesar dressing water	5
8192	parmesan cheese skim milk	62
8193	turmeric {color}	175
8194	pepper sauce cayenne peppers	195
8195	parmesan cheese parmesan cheese milk	62
8196	potato starch and powdered cellulose to prevent caking	519
8197	seasoned crdutions wheat flour	131
8198	candla and/or olive oil	6
8199	disodium indsinate and disodium guanylate	630
8200	Organic baby kale.	841
8201	organic chard	1828
8202	organic kale.	841
8203	creamy poblano dressing canola oil	90
8204	cultured buttermilk	1301
8205	poblano chilies	1347
8206	worcestershire sauce water	5
8207	chive	1829
8208	corn southwest style chicken breast with rib meat chicken breast with rib meat	1156
8209	water contains 2% or less of the following: sodium lactate preservative	1097
8210	sodium phosphate preservative	194
8211	spices including cumin	43
8212	sodium citrate preservative	477
8213	sodium diacetate preservative	1062
8214	mesquite smoke flavor	1383
8215	four cheese blend montery jack cheese pasteurized milk	1204
8216	annatto vegetable color	722
8217	queso quesadilla cheese pasteurized milk	1009
8218	asadero cheese pasteurized milk	1830
8219	annatto {vegetable color}	236
8220	tortilla strips stone ground white corn	134
8221	sunflower oil or corn oil	1831
8222	nacho seasoning whey powder	193
8223	granular cheese {milk	405
8224	cheddar cheese powder {milk	38
8225	romano cheese powder {milk	62
8226	blue cheese powder {milk	837
8227	cultured nonfat milk powder	887
8228	chili lime seasoning whey powder	193
8229	lime juice powder	200
8230	sour cream powder {sour cream cream	25
8231	silicon dioxide}	309
8232	chunky bleu cheese dressing canola oil	90
8233	bleu cheese milk	837
8234	hard-cooked eggs egg	14
8235	sodium benzoate as a preservative	454
8236	turkey breast turkey breast	949
8237	contains 2% or less of sugar	1
8238	sodium nitrate preservative	952
8239	potassium lactate preservative	1068
8240	sodium erythorbate preservative	363
8241	bacon bits bacon cured with water	140
8242	may contain smoke flavoring	880
8243	sodium phosphate to enhance flavor	194
8244	sodium ascorbate preservative	329
8245	potassium chloride preservative	1562
8246	flavoring.	407
8247	Cultured milk & cream	735
8248	protein isoalte	1832
8249	lactic & citric acid	295
8250	potassium sorbate & sodium benzoate preservative. xanthan gum	1833
8251	tapioca pearls	1229
8252	carmel color.	357
8253	salt. contains 2% or less of: corn syrup solids	140
8254	monocalcium phosphate monohydrate	259
8255	propylene glycol mono- and diesters of fatty acids	939
8256	calcium acetate	1834
8257	Pacific cod	1835
8258	Sockeye salmon	1836
8259	sodium nitrite preservative and natural hardwood smoke	367
8260	Atlantic salmon with color added	808
8261	sodium nitrite preservatives	367
8262	natural hardwood smoke.	1314
8263	sodium nitrite preservative.	367
8264	preservative and natural hardwood smoke	1837
8265	sodium bisulfite preservative.	1289
8266	folic acid. water	727
8267	contains 2% or less of citric acid	200
8268	enriched wheat flour lfour	131
8269	sodium bisulfite as a preservative	397
8270	sodium tripolyphosphate to retain morsture. soy flour	820
8271	Coconut shrimp - shrimp	86
8272	coconut flake	68
8273	sodium tripolyphoshate	820
8274	to retain moisture	234
8275	- sugar	170
8276	nincin	1085
8277	contain 2% or less of citric acid	200
8278	leavening sodium acid pyrophosphat	780
8279	methycellulose	743
8280	whey power	387
8281	Cooked shrimp	86
8282	slat. cocktail sauce: tomato paste	148
8283	prepared horseradish horseradish	212
8284	soy bean oil	243
8285	artificial mustard flavor	95
8286	granulated onion and garlic	1838
8287	horseradish flavor	212
8288	pectinase	1839
8289	Shrimp: shrimp	86
8290	aluminum potassium sulphate	612
8291	calcium hydrogen phosphate	381
8292	stearic acid	1840
8293	sodium tripolyphosphate for moisture retention. soy dipping sauce: water	820
8294	Chicken leg quarters	57
8295	vegetable oil cottonseed and/or soybean oil	26
8296	unsweetened cocoa	1817
8297	an	652
8298	Beef skirt steak	33
8299	cocktail sauce: tomato paste	83
8300	Boneless skinless chicken thigh	57
8301	sodium lactate and sodium phosphate.	1841
8302	Boneless pork	534
8303	water and contains 2% or less of: natural flavor	5
8304	salt. less than 2% of: potassium lactate	1068
8305	Beef contains up to 15% of a flavoring solution of water	1307
8306	salt. less than 2% of: dextrose	140
8307	less than 2% of: dextrose	750
8308	salt. less than 2% of: modified food starch	140
8309	may contain smoked flavoring.	1842
8310	less than 2% of: isolated soy protein	276
8311	bht and citric acid added to help protect flavor. packed in beef collagen casings.	1843
8312	bht and citric acid added to help protect flavor.	721
8313	beef hearts	1844
8314	modified food strach	778
8315	ga	1845
8316	contains 2% or less of: flavoring	407
8317	diacetate	480
8318	pork hearts	1846
8319	pork hearts and beef hearts	1847
8320	sodium eryt	363
8321	extr	269
8322	citri	200
8323	Cured with water	5
8324	Coated with black pepper. cured with: water	12
8325	orange juice solids	65
8326	Chicken breast with rib meat containing up to 15% of a solution of water	117
8327	crushed tomatoes tomatoes	240
8328	chipotle pepper chipotle peppers	1363
8329	ancho chili pepper	1782
8330	chipotle powder	195
8331	Organic ground beef	33
8332	cultured celery extract	706
8333	Ground turkey	1848
8334	Organic ground beef.	33
8335	Ground chuck beef	33
8336	Ground sirloin beef	33
8337	Beef and natural flavourings.	33
8338	natural rosemary flavor	89
8339	Organic turkey	1095
8340	Alaska pollock	1849
8341	sorbital	1099
8342	contains 2% or less of: natural and artificial flavor extracts of blue crab	1850
8343	snow crab	897
8344	lobster and alaska pollock	1271
8345	refined fish oil anchovy	1851
8346	sardine	894
8347	sodium pyrophosphate	518
8348	caramine for color	357
8349	canthaxanthin for color.	1852
8350	sugar sorbitol	1099
8351	lobster and alaska pollack	1271
8352	refined fish oil anchony	899
8353	potassium chloride disodium inosivate	1562
8354	sodium pyrohosphate	518
8355	carmine for colo	673
8356	cultured corn sugar	170
8357	ground red pepper	195
8358	encased in collagen casing.	1853
8359	natural and artificial maple flavor contains sugar	1
8360	contains 2% or less of: potassium lactate	1068
8361	contains 2% or less dried vinegar powder	480
8362	juice powder	1735
8363	lactic acid starter culture not	295
8364	celery juice powder	27
8365	lactic acid starter culture not from dairy.	295
8366	potato starch and powdered cellulose	519
8367	natamycin	1008
8368	gruyere cheese {pasteurized milk	1854
8369	contains	5
8370	cultured celery juice powder.	27
8371	ground red pepper.	195
8372	pasteurized process cheddar cheese cheddar cheese cultured milk	32
8373	contains less than 2% of: enzyme modified cheese cheddar cheese {cultured milk	38
8374	coated with a mixture of ground black pepper and sugar	12
8375	seasoning potassium chloride	1562
8376	turkey meat	1667
8377	beer	635
8378	encased in collagen casings.	1853
8379	Seasoned with:   salt	148
8380	natural flavor. tenderness and moistness enhanced with water	210
8381	Seasoned with:  fructose	344
8382	sodium nitrate.	952
8383	White turkey	949
8384	smoked flavoring	1842
8385	pickles cucumbers	122
8386	red peppers red bell peppers	195
8387	sodium erthyorbate	363
8388	contains 2% or less of: modified food starch salt	148
8389	sodium erytho	363
8390	Beef and natural flavoring	33
8391	Beef chuck and natural flavorings.	1855
8392	Meat pork	534
8393	pasteurized processed cheese cheddar cheese milk	32
8394	apo-carotenal coloring	1856
8395	contains 2 % or less of modified food starch	746
8396	soduim nitrite	367
8397	Ground turkey water contains 2% or less of salt dextrose spices	750
8398	potassium phosphate caramel color bha citric acid	848
8399	beef flavor maltodextrin	197
8400	bha-bht.	1857
8401	Dressing: soybean oil	243
8402	xanthan and cuar gum	265
8403	sodium benzoate and potassium sorbate to preserve freshness	926
8404	neufchatel ch	1858
8405	Farm raised clams	482
8406	Coho salmon with color added salt	148
8407	brown sugar cracked black pepper	170
8408	sodium nitrite preservative and natural hardwood smoke.	367
8409	thiamine mononitrate b	468
8410	Chicken breast boneless	117
8411	skinless. solution ingredients: water	5
8412	cajun spice blend paprika	55
8413	kosher salt	140
8414	dried thyme leaves	44
8415	dried basil leaves	48
8416	Cultured pasteurized milk and cream	7
8417	mayonnaise soybean oil vinegar	243
8418	calcium disodium edta 70 protect flavor	455
8419	sugar. contains 2% or less of. vinegar	1
8420	sodium ascore3ate	1461
8421	dressing soybean oil	243
8422	vinegar. salt	148
8423	carrots. contains 2% or less of: soybean oil	31
8424	corn cider vinegar	480
8425	ascorbic and malic and citric acids	329
8426	sodium acid sulfate	1079
8427	sugar. contains 2% or less of: relish cucumbers	1
8428	wheat germ.	180
8429	mayonnase soybean oil	243
8430	alum natural flavors	612
8431	polisorbate 80	613
8432	contains less than 2% of red bell pepper	195
8433	2% or less of: spices	834
8434	2% or less of: flavoring	407
8435	oleoresin or paprika	55
8436	Ground pork.	534
8437	Meat ingredients pork	534
8438	pepper jack cheese cultured milk	1859
8439	sorbic acid a preservative	854
8440	contains 2% or less of: corn syrup solids	596
8441	nonfat yogurt cultured nonfat milk	109
8442	potassium sorbate used to protect quality	338
8443	lecithin soy	185
8444	vegetable oil blend canola oil	90
8445	plant sterol esters	1860
8446	sodium benzoate used to protect quality	354
8447	and calcium disodium edta used to protect quality	843
8448	cholecalciferol vitamin d3.	1189
8449	Vegetable oil blend liquid soybean oil	243
8450	palm kernel oil water	286
8451	maltodextrin corn	197
8452	cholecalciferol vitamin d3	1189
8453	beta car	590
8454	Vegetable oil blend liquid soybean	243
8455	vitamin a palmit	562
8456	potassium sorbate and calcium disodium edta used to protect quality potassium sorbate used to protect quality and calcium dis	338
8457	enriched degermed yellow corn meal degermed yellow corn meal	149
8458	enriched farina farina	1861
8459	relecithinated soy flour	1862
8460	contains less than 2% of the following: seasoning blend spices	834
8461	partially hydrogenated vegetable shortening soybean and cottonseed oil with soy lecithin	243
8462	contains 2% or less of the following seasoning blend spices	1863
8463	relecithinated soy flour. contains 2% or less of each of the following: buttermilk	1864
8464	Ingredients: enriched bleached flour bleached wheat flour	131
8465	bakingsoda	886
8466	emulsifier phosphate	194
8467	imitation blueberry bits dextrose	750
8468	gelatinized yellow corn flour	165
8469	vegetable shortening hydrogenated palm kernel oil	286
8470	palm oil. contains 2% or less of each of the following: corn syrup solids	201
8471	Idaho potato dry	279
8472	contains 2% or less of the following: cream powder cream	473
8473	butter powder cream	2
8474	freshness preserved with sodium bisulfite	1289
8475	citric acid. bha and bht.	747
8476	contains 2% or less of the following: onion	9
8477	sodium acid pyrophosphate. freshness preserved with sodium bisulfite	518
8478	bha and bht	1857
8479	contains less than 2% of the following: cheese powder cheddar cheese pasteurized milk	38
8480	sodium acid pyrophospate. freshness preserved with citric acid	780
8481	sodium bisulfite	1289
8482	bha and bht.	1857
8483	contains less than 2% of the following: vinegar powder	480
8484	cream powder cream	1644
8485	onion natural flavor	9
8486	cheddar cheese powder cultured pasteurized milk	32
8487	contains less than 2% of the following: parmesan powder milk	537
8488	romano powder milk	1865
8489	Idaho potatoes dry	519
8490	contains 2% or less of: natural cheddar cheese flavor	1866
8491	natural blue cheese flavor	1867
8492	contains 2% or less of: garlic powder	4
8493	natural cheddar cheese flavor	1868
8494	disodi	594
8495	natural parmesan cheese flavor	62
8496	Potato dry	519
8497	contains 2% or less of mono and diglycerides. freshness preserved with sodium bisulfite and bht.	1289
8498	contains 2% or less of mono and diglycerides	341
8499	freshness preserved with sodium bisulfite and bht.	401
8500	Idaho potato flakes dry	519
8501	bha.	720
8502	eggs yolks	796
8503	contains less than 2% of each of the following: baking powder sodium acid pyrophosphate	17
8504	crushed black pepper	12
8505	monosodium glutamte	708
8506	teriyaki sauce soy sauce water	39
8507	paprika oleoresin.	195
8508	whey soybean oil	243
8509	less than 2% salt	140
8510	milk proteins	640
8511	sucrose esters of fatty acids	1869
8512	natural and artificial flavorings.	196
8513	egg yolk and egg	14
8514	mascarpone cheese	906
8515	dextrose potato starch	750
8516	sodium diphosphat	556
8517	black cherry syrup corn syrup	596
8518	black cherry juice 36.8%	1870
8519	cherries 2.5%	189
8520	artificial flavorings.	1871
8521	whole roasted hazelnuts	144
8522	Organic pasteurized milk	7
8523	stabilizers: organic guar gum	475
8524	organic carob seed flour	1872
8525	organic vanilla beans	20
8526	organic corn syrup	596
8527	organic coffee	550
8528	organic carob seed flour.	1872
8529	organic gianduja sauce organic cane sugar	1
8530	organic hazelnut paste	300
8531	organic chocolate	118
8532	organic carob s	800
8533	organic caramel organic cane sugar	873
8534	organic glucose syrup	315
8535	thickener agar-agar	342
8536	organic pistachio	320
8537	stabilizer organic guar gum	475
8538	fresh cream	473
8539	tara gum	696
8540	raspberry swirl: pure cane sugar	170
8541	toasted coconut	68
8542	taragum	453
8543	pineapple swirl: pure cane sugar	1
8544	glucose dextrose fd&c red #40 citric acid	315
8545	natural flavors cellulose gum	600
8546	pectin citric acid fruit and vegetable juice for color	200
8547	vanilla bourbon	20
8548	seeds.	1873
8549	sicilian pistachio paste	1874
8550	toasted pistachios grains	320
8551	dark chocolate cocoa of dominican origin	118
8552	dark chocolate curls sugar	1
8553	sicilian almond paste	1875
8554	toasted sicilian almond grains	60
8555	100% brazilian	118
8556	arabica coffee cream	550
8557	butter corn syrup	596
8558	coffee chocolate beans sugar	1
8559	arabic gum shellac	289
8560	100% brazilian arabica co	550
8561	lemonade base water	5
8562	lemon flavor with other natural flavors	1876
8563	locust bean gum and turmeric	339
8564	frozen greek yogurt base whey protein concentrate	387
8565	cultured dairy solids {whey protein concentrate	387
8566	nonfat dried milk	887
8567	natural flavor}	316
8568	standardized with dextrose	750
8569	stabilizer mono and diglycerides	729
8570	acidifier water	200
8571	natural glycerin	234
8572	natural lactic acid	295
8573	natural vanilla and other natural flavors	20
8574	cultures.	987
8575	blueberry pomegranate base blueberries	411
8576	blueberry and pomegranate flavors with other natural flavors	196
8577	natural lactic acid natural vanilla and other natural flavors	1877
8578	White tuna	1878
8579	vegetable broth soy	142
8580	raspberry puree natural flavor	1691
8581	strawberry puree concentrate	1879
8582	color red 40.	677
8583	corn syrup.	750
8584	Mandarin orange segments	1417
8585	pineapple juice.	497
8586	erythorbic acid to promote color retention	775
8587	Canadian spring water	1880
8588	carbon dioxyde.	529
8589	apple and door county cherry juice concentrate	1881
8590	carbon dioxide.	529
8591	concentrate grape juice	150
8592	Reconstituted fruit juice blend water and concentrated juices of apples	322
8593	white grapes	1299
8594	reconstituted vegetable juice blend water and concentrated juice of sweet potatoes	1882
8595	purple carrots	1883
8596	tomatoes and clarified carrots	240
8597	apple juice concentrate ascorbic acid vitamin c.	650
8598	cane or beet sugar	170
8599	Grape juice from concentrate water	150
8600	White grape juice from concentrate water	150
8601	potassium metabisulfite added to maintain flavor and freshness.	1884
8602	100% prune juice.	1885
8603	Organic tomato juice from concentrate water	450
8604	organic tomato concentrate	717
8605	reconstituted organic vegetable juices of organic carrots	1056
8606	organic beets	174
8607	organic lettuce	324
8608	organic watercress	1425
8609	and organic spinach	79
8610	vitamin c ascorbic acid.	329
8611	reconstituted vegetable juices of carrots	1056
8612	and spinach	79
8613	cheddar cheese solids pasteurized milk	32
8614	Rice pieces rice flour	138
8615	sunflower oil with natural tocopherols added to preserve freshness	147
8616	enzyme modified cheddar cheese solids milk	640
8617	color fd&c yellow no. 5 lake	1886
8618	fd&c yellow no. 6 lake	1886
8619	fd&c blue no. 1	1887
8620	fd&c red no. 40	677
8621	romano cheese made from cow'a milk cultured milk	969
8622	vitamin a palmtate	562
8623	contains one or more of the following oils: canola	90
8624	contains 2% or less of : buttermilk	72
8625	enzyme modified skim milk cheese pasteurized skim milk	472
8626	color yellow lakes 5 & 6 and other color added	1888
8627	less than 2% of the following citric acid	200
8628	dried chipotle pepper	1363
8629	extractives or paprika	55
8630	flaxseed	157
8631	less than 2% of the following: citric acid	200
8632	Prepared light red kidney beans	1889
8633	disodium edta added for color retention.	455
8634	Prepared dark red kidney beans	605
8635	Prepared large lima beans	228
8636	calcium disodium edta added for color retention.	455
8637	Brown long grain rice.	305
8638	Prepared red beans	1318
8639	Prepared navy beans	226
8640	onion flavor.	9
8641	Quartered artichoke hearts	1342
8642	citric acid and ascorbic acid to retain color.	1890
8643	guaran	475
8644	citrate	319
8645	niacinmide	1492
8646	raspberry juice solids	961
8647	blue1.	1692
8648	Blackeye peas.	1316
8649	contains less than 2% of: lemon juice solids	18
8650	corn syrup solids++	750
8651	contains less than 2% of: magnesium oxide	1431
8652	Lentils.	1891
8653	Contains 16 of the following varieties: large lima beans	228
8654	cranberry beans	1892
8655	pink beans	1609
8656	lentils green split peas	221
8657	seasoning packet ingredients: spices	834
8658	lemon powder corn syrup solids	1386
8659	caramel color contains sulfites	357
8660	and citric acid. no more than 2% silicon dioxide added as an anti-caking agent.	200
8661	Small red beans.	605
8662	yell	1893
8663	Yellow split peas.	1894
8664	Organic soymilk filtered water	1895
8665	organic sunflower and/or safflower and/or canola oil	147
8666	organic chipotle powder	1363
8667	organic tomato powder	240
8668	organic garlic powder.	4
8669	seasoning parmesan cheese pasteurized milk	62
8670	bread crumbs	77
8671	contains 2% or less of dextrose	750
8672	seasoning romano cheese pasteurized cow's milk	969
8673	bread crumbs bleached wheat flour	131
8674	sugar hydrolyzed soy and corn protein	1
8675	less than 2% calcium stearate anti-caking	927
8676	contains 2% or less of pectin; citric acid	200
8677	fruit juice concentrate added for color	1770
8678	Concord grape juice	150
8679	water and concord grape juice concentrate	5
8680	enriched vermicelli wheat flour	131
8681	whey from milk	405
8682	citric acid..	200
8683	Enriched rice rice	999
8684	enriched vermicelli flour	784
8685	oleoresin turmeric	383
8686	annatto extract color.	722
8687	annatto and turmeric extracts color.	1669
8688	riboflavin and folic	1695
8689	chicken fat rendered chicken fat	1148
8690	chicken mechani-cally separated chicken	1455
8691	lactose from milk	270
8692	natural chicken flavor	1416
8693	sodium ca-seinate from milk	640
8694	turmeric and paprika extracts color.	1896
8695	Brown long grain rice	305
8696	enriched spinach pasta wheat flour	131
8697	cream cheese pasteurized milk	1208
8698	parmesan and romano cheeses pasteurized milk	1897
8699	garlic yeast extract	1261
8700	cultured nonfat dry milk	801
8701	sour cream	25
8702	chopped pickles	1898
8703	contains 2% or less of onion	9
8704	enzyme modified egg yolks	1412
8705	potassium sorbate and calcium disodium edta as preservatives	338
8706	Enriched high gluten flour wheat flour	131
8707	cornmeal.	149
8708	cormeal.	149
8709	Organic potatoes	279
8710	organic expeller pressed vegetable oil sunflower	147
8711	organic expeller pressed sunflower seed	1831
8712	safflower seed and/or canola oil	1501
8713	pasteurized orange juice concentrate	65
8714	tri-calcium citrate.	1011
8715	partially hydrogenated vegetable shortening contains soybean oil	243
8716	leavening baking soda.	24
8717	Ground yellow corn	134
8718	sunflower oil and / or canola oil	26
8719	dried buttermilk	1024
8720	sugared egg yolks	1412
8721	tumeric and annatto colors.	175
8722	Couscous precooked durum wheat semolina	1280
8723	tocopherols to protect flavor.	169
8724	Couscous precooked durum wheat semolina.	1280
8725	Brownie mix: sugar	1
8726	artificial flavor. frosting: powdered sugar sugar	637
8727	shortening palm oil and soybean oil with mono- and diglycerides	1899
8728	tbhq and citric acid	543
8729	preservative potassium sorbate	338
8730	semi-sweet chocolate chips sugar	1
8731	emulsifier sot lecithin	185
8732	vegetable shortening contains one or more of the following: canola and/or palm oil and/or soybean oil with preservative tbhq	243
8733	contains 2% or less of the following: sat	477
8734	Chocolate cookie crumbs enriched flour wheat flour	131
8735	calcium disodium edta.	455
8736	Pumpkin.	559
8737	Sauerkraut	1900
8738	Tomatoes with juice	240
8739	less than 2% of: habanero peppers	195
8740	chopped green chili peppers	1285
8741	spice natural flavor	198
8742	enzyme modified egg yolk	185
8743	contains 2% or less of: vinegar	73
8744	pimentos	1478
8745	Red salmon	808
8746	Queen olives	1458
8747	potassium sorbate.	338
8748	minced pimientos	1478
8749	Manzanilla olives	1901
8750	minced pimentos	1478
8751	Ripe black olives	1902
8752	ferrous gluconate to stabilize color.	251
8753	Ripe back olives	1459
8754	Boneless breast of chicken with rib meat containing up to 8% of a solution of water	1156
8755	sodium phosphates. breaded with: bleached wheat flour	570
8756	ground paprika	55
8757	spice extractives.	1527
8758	filled with: unsalted butter pasteurized cream	473
8759	diacetyl	1903
8760	battered with: water	5
8761	sodium bicarbonate. pre-browned in vegetable oil.	24
8762	high-fructose corn syrup	344
8763	potassium sorbate and sodium benzoate added as preservatives	803
8764	and sulfur dioxide preservative.	306
8765	Oregon strawberries	448
8766	Michigan red tart cherries	1904
8767	California apricots	275
8768	sunflower lecithin emulsifier	185
8769	vanilla flavor.	20
8770	cottonseed and soya	1905
8771	Dry roasted unblanched organic almonds.	60
8772	Dry roasted unbleached organic almonds.	60
8773	Dry roasted organic cashews	145
8774	organic sunflower oil.	147
8775	Dry roasted organic sunflower seeds	151
8776	contains less than 2 salt	140
8777	blue cheese chunks water	837
8778	sodium and calcium caseinates	640
8779	potassium sorba	338
8780	contains less than 2% mustard flour	95
8781	contains less than 2% salt	140
8782	contains less than 1% of dried garlic	4
8783	contains less than 2% of modified food starch	778
8784	potassium sorbate and	338
8785	contains less than 2% garlic	4
8786	onion puree	9
8787	disodium phospha	1253
8788	buttermilk. distilled vinegar	1906
8789	parmesan and romano cheese cultured pasteurized part skim milk	62
8790	contains less than 2% soy sauce water	39
8791	lactic aci	295
8792	vegetable oil canola and/or soybean	26
8793	vidalia onion	1907
8794	contains less than 1% of onion powder	121
8795	buttermilk solids from milk	405
8796	whey solids from milk	405
8797	casein from milk	640
8798	hydroxypropyl methylcellulose	1653
8799	lemon juice from concentrate water	200
8800	roasted sesame oil	112
8801	l	295
8802	acai puree	264
8803	contains less than 1% of spice	198
8804	elderberry and chokeberry juice for color	237
8805	potassium sorbate as a prese	338
8806	cultured lowfat buttermilk	1301
8807	fire roasted poblano pepper	1347
8808	contains less than 2% of garlic	4
8809	contains 2% or less of the following: guar gum	475
8810	preservatives propionic acid	1092
8811	sodium hydroxide	385
8812	calcium sulfate.	456
8813	Shells: stone-ground corn masa flour	165
8814	vegetable oils may contain one or more of the following: soybean	243
8815	corn or palm olein	307
8816	trace of lime	200
8817	tbhq preservative	1082
8818	calcium chlorine.	340
8819	chicken bouillon salt	148
8820	spice xanthan gum	265
8821	seasoning paprika	55
8822	jalapeno mash jalapeno peppers	725
8823	sodium bezoate	354
8824	chipotle pepper puree	195
8825	roasted onion	9
8826	cumin.	43
8827	roasted poblano pepper	1347
8828	habanero pepper	836
8829	yellow sweet corn	134
8830	cheese premix {corn starch	866
8831	color added annatto	722
8832	paprika}	195
8833	and calcium chloride	340
8834	cheese flavor {cheddar cheese pasteurized milk	1908
8835	salt and enzymes}	1909
8836	natural flavoring contains egg protein	1910
8837	contains less than 2% of soybean oil	243
8838	diced tomatoes in puree	487
8839	vegetable oil cottonseed and/or canola and/or soybean	26
8840	spices basil	48
8841	Tomatoes puree water tomato paste	240
8842	vegetable oil cotton seed and/ or canola and/or soybean	26
8843	ricotta cheese pasteurized milk	971
8844	dehydrated parsley.	22
8845	vegetable oilcottonseed and/or canola and/or soybean	26
8846	citric acid dehydrated parsley	200
8847	roaster garlic garlic	4
8848	enzyme modified egg yolk egg yolk	796
8849	natural cheese flavor flavor	38
8850	roasted garlic puree garlic chunks	4
8851	modified milk ingredients	1911
8852	rennet and/or microbial enzyme and/or lipase	1161
8853	may contain calcium chloride	340
8854	natural roasted garlic concentrate	4
8855	worcestershire sauce base  water	5
8856	spice blend	575
8857	gum tragacanth natural flavors	1912
8858	polysorbate 20	1913
8859	catsup seasoning salt	148
8860	ethoxyquin antioxidant.	1914
8861	Tomato pureetomato paste	240
8862	worcestershire saucedistilled vinegar	73
8863	organic ketchup spice organic spices	834
8864	organic onion	9
8865	crushed chile peppers	195
8866	sodium erythor	363
8867	dried chipotle peppers	1363
8868	ethoxyquin antioxidant	1914
8869	worcestershire sauce base water	5
8870	spice bled	55
8871	gum tragacanth	1912
8872	sodium benzoate.	354
8873	hot sauce cayenne red peppers	195
8874	ground habanero	1915
8875	tamarind.	453
8876	modified food starch. contains less than 2% of: salt	778
8877	spices and herbs	1916
8878	dried garlic and onion	670
8879	Aged red peppers	1917
8880	anchovies and natural flavors.	1270
8881	less than 2% of: spice	198
8882	onion power	121
8883	less than 2% of: organic onion powder	9
8884	organic spice.	198
8885	turmeric acid	175
8886	mustard seed salt	148
8887	citric acid. paprika.	55
8888	dried onion vinegar	1918
8889	Pure vinegar made from apples and filtered water	480
8890	filtered water.	5
8891	Distilled white vinegar and filtered water.	480
8892	Red wine	946
8893	sodium metabisulfite preservative.	426
8894	contains 1% or less of malic acid	345
8895	Organic wine vinegar	480
8896	organic concentrated grape must. contains naturally occurring sulfites. 6% acidity.	1919
8897	Organic chicken stock water	97
8898	organic chicken stock from concentrate sea salt	98
8899	organic vegetable stock organic carrot	119
8900	organic mushroom powder	1920
8901	concentrated organic chicken stock	97
8902	contains less than 2% of: organic cane sugar	1921
8903	Organic vegetable sauce water	5
8904	organic vegetable stock flavor organic carrot	119
8905	cooked white chicken meat white chicken meat	57
8906	pasta semolina	451
8907	chicken flavor chicken meat	57
8908	spaetzle dumplings water	5
8909	enriched durum flour durum wheat flour	239
8910	chicken broth concentrate chicken broth	41
8911	contains less than 2% of the following ingredients: cornstarch	263
8912	cooked chicken meat chicken meat	1147
8913	pasta whole wheat flour	283
8914	chicken flavo	1572
8915	chickpeas	222
8916	seasoning	211
8917	clam extract clam extract	484
8918	cooked white chicken meat chicken white meat	57
8919	concentrated chicken broth base chicken broth	41
8920	yeast ext	209
8921	seasoned beef sirloin burgers beef	33
8922	beef broth base beef	1338
8923	hydrolyzed wheat protein	514
8924	chicken flavor chicken fat	1148
8925	potassium gluconate	1922
8926	contains less than 2% of the following ingredients: modified food starch	778
8927	flavoring minerals potassium chloride	1562
8928	magnesium sulfate	1923
8929	lower sodium natural sea salt sea salt	148
8930	hydrolyzed soy and wheat gluten proteins	1292
8931	contains less than 2% of: flavoring yeast extract	209
8932	contains less than 2% of: carrots	31
8933	seasoning onion powder	121
8934	unmodified food starch	263
8935	oleoresin celery	706
8936	oleoresin carrot	1339
8937	contains less than 2% of: unmodified food starch	746
8938	Chicken stock water	5
8939	concentrate chicken stock	97
8940	vegetable stock carrot	119
8941	concentrated cabbage juice	1924
8942	dried parsley.	22
8943	contains less than 1% of: cream	473
8944	chicken flavoring yeast extract	209
8945	egg yolk powder	185
8946	seasoning hydrolyzed soy	39
8947	corn and wheat gluten proteins	1925
8948	oleoresin carrot.	119
8949	contains less than 1% of: whey protein concentrate	387
8950	mushroom powder dextrin	1920
8951	mushroom extract	1622
8952	cheese blend cheddar cheese milk	32
8953	margarine partially hydrogenated soybean and cottonseed oils	1926
8954	colored with annatto/turmeric	590
8955	calcium disodium edta as a preservative	455
8956	cheddar cheese flavor aged cheddar cheese milk cheese cultures	32
8957	sodium silicoaluminate and paprika extract	1927
8958	natural flavor contains maltodextrin	197
8959	reduced iron and zinc oxide mineral nutrients	1928
8960	vitamin c sodium ascorbate	650
8961	a b vitamin niacinamide	466
8962	vitamin b1 thiamin mononitrate	1085
8963	a b vitamin folic acid	819
8964	vitamin d.	581
8965	vitamins and minerals: sodium ascorbate vitamin c	1461
8966	apple puree concentrate	1690
8967	a b vitamin niacinamide vitamin a palmitate	466
8968	contains less than 2% of the following: canola oil	90
8969	soy lecithin. vitamins and miner	185
8970	Corn meal blend corn meal and degermed corn meal	1929
8971	whole wheat and wheat bran	143
8972	contains less than 2% of the following: glycerin	401
8973	partially hydrogenated sunflower oil	147
8974	honey molasses	156
8975	soy lecithin. vitamins and minerals: vitamin c sodium ascorbate	185
8976	vitamin e alpha tocopherol acetate	169
8977	zinc zinc oxide	1585
8978	vitamin b1 thiamin hydrochloride	1085
8979	vitamin b12 cyanocobalamin	526
8980	vitamin d cholecalciferol.	581
8981	vitamin e mixed tocopherols  added to preserve freshness. vitamins and minerals: calcium carbonate	1612
8982	mixed tocopherols vitamin e added to preserve freshness. vitamins and minerals: calcium carbonate	169
8983	flavor hydrolyzed soy protein	276
8984	contains 2% or less of beef fat	1490
8985	dehydrated cooked beef	33
8986	dried beef stock	1930
8987	disodium i	594
8988	flavor hydrolyzed corn protein	1292
8989	sugar monosodium glutamate	630
8990	dehydrated cooked chicken	1931
8991	contains natural flavor	1302
8992	on	148
8993	hydrolyzed corn & soy protein	1292
8994	cooked chicken and chicken broth	57
8995	Enriched bread enriched wheat flour	131
8996	partially hydrogenated vegetable oil soybean and/or cottonseed oil and/or canola and corn oils. may contain salt	243
8997	sesame and/or poppy seeds	1932
8998	yeast nutrients contains one or more of the following: monocalcium phosphate	259
8999	potassium bromate	1933
9000	romano cheese sheep's milk	969
9001	and/or parmesan cheese cow's milk	640
9002	garlic oil.	1934
9003	Bread crumbs enriched wheat flour flour	131
9004	may contain whey	193
9005	sugar. and/or honey. contains 2% or less of. partially hydrogenated vegetable oil contains one or more of canola oil	1
9006	calcium proprionate	911
9007	hot red peppers	195
9008	ammonium sulfate; calcium propionate preservative	915
9009	potassium sorbate preservative. salt	1935
9010	dried yeast salt and sugar.	1
9011	gelatin contains 2% or less if acipic acid for tartness	480
9012	sodium citrate controls acidity	200
9013	fumeric acid for tartness salt	421
9014	dimenthylpolysloxane prevents foam	358
9015	contains 2% or less of adipic acid for tartness	200
9016	dimethylpolysiloxane prevents from.	1595
9017	dimethylpolysiloxane prevents foam.	1595
9018	dimethylpolysiloxane prevents foam	1595
9019	sodium citrate control acidity	477
9020	contains 2% or less of tetrasodium pyrophosphate	879
9021	mono- and diglycerides prevent foaming	729
9022	partially hydrogenated soybean oil with bha preservative	243
9023	natural and artificial flavoring.	407
9024	contains 2% or less of almonds	60
9025	Starch blend modified tapioca starch	1559
9026	microcrystalline cellulose	740
9027	emulsifier mono - and diglycerides	729
9028	aspartame sweetener	1251
9029	vegetable oil contains one or more of the following: palm oil	201
9030	color added including yellow 6 and yellow 5	786
9031	color added including yellow 5 lake and yellow 6 lake.	863
9032	Organic quinoa	167
9033	organic herbs	488
9034	organic dehydrated sweet corn	750
9035	organic yeast extract.	209
9036	organic parmesan cheese powder pasteurized organic milk	62
9037	organic sweet whey powder	405
9038	organic sun dried tomato	1038
9039	organic dehydrated corn	134
9040	organic dehydrated spinach	79
9041	organic lemon powder	1386
9042	organic dehydrated mushrooms	1621
9043	cheddar cheese sauce cheddar cheese milk	32
9044	they	44
9045	salt contains 2% or less of the following: sodium alginate	645
9046	preservative sorbic acid	854
9047	color oleoresin paprika	55
9048	apocarotenal.	773
9049	contains 2% or less of the following ingredients: salt	140
9050	tomato onion	9
9051	disodium phossphate	1253
9052	modified wheat starch.	662
9053	partially hydrogenated sotbean oil	243
9054	sodium caseinate from milk.	640
9055	parmesan and cheddar cheeses pasteurized milk cheese cultures	1209
9056	modified wheat starch and yellow 6.	1936
9057	citric acid modified corn starch	200
9058	enzyme modified cheddar cheese blend cheddar	32
9059	blue	1937
9060	and semi-soft cheese blend pasteurized milk	1009
9061	citric acid potassium chloride	1562
9062	grated romano cheese pasteurized cow's milk	969
9063	enzymes modified romano cheese romano cheese pasteurized cow's milk	1938
9064	enriched spaghetti semolina wheat flour	131
9065	glycerol monostearate	1939
9066	contains less than 2%: cheddar cheese milk	7
9067	meatballs beef and pork	1940
9068	breadcrumbs {wheat flour	131
9069	glyceryl monostearate	1941
9070	folic aicd	727
9071	beefbreadcrumbs enriched wheat flour wheat flour	131
9072	textured soy yeast protein soy flour	547
9073	folic acid contains 2% or less of: salt	148
9074	enzymes water	5
9075	contains less than 2%: dehydrated onion	9
9076	citric acid and potassium sorbate preservatives.	1942
9077	Prepared beans	214
9078	bacon water	5
9079	green chile puree contains citric acid	200
9080	contains 2% or less of textured vegetable protein soy flour	547
9081	contains 2% or less of: tomato paste	83
9082	contains 0. 5% or less of: dipotassium phosphate	779
9083	Partially hydrogenated palm oil corn syrup	201
9084	silivcon dioxide	309
9085	acesulfame-k.	1737
9086	sweetened with nutritive and nonnutritive sweeteners.	1
9087	sodium casenate a milk derivative	640
9088	organic cocoa powder processed with alkali	118
9089	organic graham flour	1943
9090	am	652
9091	emulsifier mono and diglycerides	729
9092	di potassium phosphate	848
9093	glucose syrup solids	315
9094	partially hydrogenated vegetable oil may contain coconut	881
9095	palm and/or canola	26
9096	soylecithin	185
9097	dipotassiumphosphate	779
9098	Low fat milk	1944
9099	cardamom.	230
9100	Chamomile.	1945
9101	Peppermint.	458
9102	niacinamide vitamin b3	466
9103	calcium pantothenate and biotin b vitamins	1946
9104	tocopherol to perfect flavor.	169
9105	asparttame	1251
9106	Citric acid maltodextrin	200
9107	contains less than 2% of: potassium citrate	904
9108	corn syrup solid	750
9109	aspartame. contains les than 2% of: natural flavor	1251
9110	contains less than 2% of: calcium silicate	1010
9111	potassium citrate controls acidity	904
9112	natural lemon flavors	29
9113	brominated vegetable oil and red 40.	1536
9114	natural and artificial flavors and sodium benzoate preservative.	1947
9115	sodium benzoate preservative and red 40.	454
9116	natural flavors and caffeine.	585
9117	yellow 5 and brominated vegetable oil.	1948
9118	potassium benzoate preservative and acesulfame potassium.	490
9119	acesulfame potassium and caffeine.	1949
9120	potassium citrate and sodium benzoate preservative.	904
9121	potassium benzoate preservative and caffeine.	490
9122	natural flavor and caffeine.	585
9123	and sodium benzoate preservative.	454
9124	yellow 6 and brominated vegetable oil.	1948
9125	sodium benzoate preservative and caramel color.	354
9126	sodium benzoate preservative and citric acid.	454
9127	quinine hydrochloride and natural flavor.	1201
9128	aspartame phosphoric acid and quinine.	1251
9129	Carbonated water and natural flavor.	356
9130	blackberry	658
9131	potassium benzoate a preservative	490
9132	calcium choloride	340
9133	calcium sodium edta to protect	455
9134	kiwi juice from concentrate	1950
9135	calcium disodium edta to protect flavo	843
9136	pink grapefruit juice from concentrate	553
9137	magnesium sulfat	1951
9138	blackberry juice from concentrate	489
9139	potassium benoate and potassium sorbate preservatives	1016
9140	calcium disodium edta to	455
9141	magenesium sulfate	1951
9142	Carbonate water	356
9143	potassium benzoate	490
9144	aceslfame potassium	855
9145	Durum wheat semolina enriched with iron ferrous sulfate and b vitamins niacin	1280
9146	nutrients from whole food concentrates spinach	79
9147	beet	174
9148	shiitake mushroom	869
9149	color paprika oleoresin	55
9150	fruit juice concentrate watermelon	1952
9151	huito	1953
9152	turmeric oleoresin	175
9153	enriched with iron ferrous sulfate and b vitamins niacin	251
9154	thiamin mononitrate riboflavin	818
9155	thaimin mononitrate	1723
9156	Extra fancy durum wheat flour	239
9157	fresh eggs	14
9158	Popcorn.	162
9159	Organic popcorn.	1954
9160	palm oil with preservative tbhq	201
9161	potassium chloride.	1562
9162	Dehydrated potato with emulsifier mon- and diglycerides and preservative sodium acid pyrophosphate	279
9163	contains 2% or less of: monosodium glutamate	630
9164	preservative bht.	721
9165	Dehydrated potato with emulsifier mono- and diglycerides and preservative sodium acid pyrophosphate	519
9166	preservative tbhq	1955
9167	Idaho potatoes	279
9168	butter cream and salt	148
9169	freshness preserved with sodium acid pyrophosphate	780
9170	natural cheddar cheese flavor natural flavors includes: milk	38
9171	blue cheese	837
9172	and romano cheese past	62
9173	sour cream milk fat	25
9174	natural cheddar cheese flavor natural flavors includes milk	38
9175	and romano cheeses pasteurized milk	969
9176	enzymes and salt	148
9177	imitation bacon textured soy flour	547
9178	partially hydrogenated soybean oil with bht as an antioxidant	243
9179	dipotassium phosphate. freshness preserved with sodium acid pyrophosphate	779
9180	Precooked parboiled whole grain brown rice.	305
9181	and folic acid a b vitamin.	727
9182	Organic long grain rice.	1057
9183	orzo pasta made with wheat flour	131
9184	Dehydrated potato with preservative sodium bisulfite	279
9185	enzyme-modified cheddar cheese and butter cheddar cheese milk	32
9186	romano cheese sheep and cow milk	969
9187	color yellow 5 and 6	786
9188	reduced lactose whey.	405
9189	Dehydrate potato with emulsified mono- and diglycerides and preservative sodium acid pyrophosphate	1956
9190	Dehydrated potatoes with preservative sodium bisulfite	34
9191	filic acid	727
9192	color yellow 5	403
9193	yellow lake 5	1957
9194	enzyme modified cheese cheddar cheese milk	32
9195	Whole grain parboiled brown rice	305
9196	Enriched long grain rice iron	251
9197	maltodextrin from corn salt	197
9198	Mint chocolate fudge: sugar	1
9199	hydrogenated palm kernel oil with soy lecithin	286
9200	butter cream milk	7
9201	cream milk powder	1958
9202	chocolate liquor hydrogenated palm kernel oil with soy lecithin	171
9203	caramel corn sy	452
9204	potassium sorbate as a preservative.	338
9205	Dried cranberries sugar	1
9206	soybean and/or sunflower seed	185
9207	Cashew	145
9208	brazils	1959
9209	Peanuts salt	173
9210	blanched.	754
9211	organic mozzarella cheese organic milk	531
9212	culture starter	1960
9213	organic parmigiano reggiano cheese organic milk	62
9214	animal rennet	1961
9215	organic cherry tomatoes organic cherry tomatoes	240
9216	organic sugar syrup	1
9217	organic basil sauce water	5
9218	organic parmigiano reggiano organic milk	537
9219	organic sunflower seed oil	147
9220	organic durum wheat semolina	451
9221	organic malted wheat flour	131
9222	organic sourdough organic wheat flour	131
9223	dough conditioner: ascorbic acid	329
9224	organic oregano.	42
9225	organic cherry tomatoes	1962
9226	organic aged cheese organic milk	640
9227	Crust wheat flour flour	131
9228	contains two percent or less of the following: soybean oil	243
9229	cooked seasoned pizza topping pork	534
9230	pepperoni made with pork	534
9231	and beef pork	33
9232	soybean with tbhq for freshness	991
9233	rosemary seasoning maltodextrin	197
9234	sugar spices	1
9235	canola and/or soybean and/or palm oil with tbhq added for freshness	1082
9236	contains 2% or less of: leavening calcium phosphate and/or baking soda	24
9237	dehydrated vegetable blend carrot	119
9238	color blue 1.	1692
9239	vegetable oil contains one or more of the following: canola	90
9240	or soybean oil	243
9241	less than 2% of: corn syrup	596
9242	leavening contains one or more of: yeast	294
9243	less than 2% of: red hot cayenne pepper sauce powder red hot cayenne pepper sauce aged cayenne red peppers	195
9244	maltodex	197
9245	may contain one or more of the following: corn	170
9246	dry hot sauce red peppers	195
9247	dry vinegar	480
9248	paprika extract flavor & color	55
9249	dry honey	36
9250	mustard food starch	1963
9251	silicon dixodie	631
9252	tumeric extract color	383
9253	natural smoke flavor and natural flavor.	268
9254	rice flour salt.	148
9255	sunflower and/or safflower oil	1375
9256	contains two percent or less of: salt	140
9257	sunflower oil and/or canola oil	1382
9258	dried sour cream cultured cream	25
9259	high-oleic sunflower oil	147
9260	sour cream powder cultured cream	25
9261	disodium phosph	556
9262	Ground white corn	134
9263	sunflower oil and / or canola oil and salt.	1964
9264	romano cheese cultured pasteurized part-skim milk	969
9265	extractives of turmeric and caramel color	383
9266	and not more than 2 % silicon dioxide added as an anticaking agent.	631
9267	sunflower and/or canola oil	26
9268	contains 2% or less of: reduced-lactose whey	193
9269	enzyme modified cheddar cheese and butter cheddar cheese pasteurized milk	32
9270	butter milk solids	2
9271	contains two percent or less of: sodium phosphate	556
9272	yellow #5 color	403
9273	yellow 6 color.	403
9274	corn. or soybean oil	134
9275	leavening contains one or more of the following: yeast. sodium bicarbonate. ammonium bicarbonate.	17
9276	molasses powder contains molasses and corn maltodextrin	156
9277	sulfites.	306
9278	toasted onion powder.	121
9279	extractives of paprika color	934
9280	natural flavor contains natural hickory smoke flavor.	1965
9281	Potato flour potato flakes	664
9282	beet powder.	174
9283	Potato flour potato flakes and starch	519
9284	vegetable oil corn and/or canola and/or sunflower	26
9285	toasted corn germ	1966
9286	corn and/or canola and/or sunflower oil	26
9287	long grain brown rice flour	261
9288	vegetable oil may contain	26
9289	tbhq and calcium propionate preserve freshness.	1082
9290	vegetable oil may contain soybean	243
9291	palm safflower	181
9292	graham flour whole grain wheat flour	283
9293	contains 2% or less of: calcium carbonate source of calcium	203
9294	contains two percent or less of: enzymes	192
9295	calcium phosphate leavening	381
9296	canola and/or palm and/or soybean oil with tbhq for freshness	243
9297	contains two percent or less of: baking soda	24
9298	citric acid and tbhq added to preserve freshness	200
9299	baking soda and/or calcium phosphate leavening	24
9300	Organic unbleached wheat flour	131
9301	grain mix organic cracked wheat	1694
9302	organic spelt	302
9303	organic rye	217
9304	organic barley	255
9305	organic triticale	253
9306	organic oats	78
9307	organic flax	207
9308	organic sesame seeds	1967
9309	organic grain mix organic cracked wheat	143
9310	organic rosemar	89
9311	organic cracked peppercorn	12
9312	organic poppy seeds and salt.	148
9313	canola and/or soybean and/or palm oil with tbhq added to preserve freshness	1082
9314	contain 2% or less of: salt	140
9315	palm and/or sunflower oil	26
9316	chocolate l	118
9317	contains two percent or less of: dextrose	750
9318	annatto extract vegetable color	722
9319	semi-sweet chocolate drops sugar	1
9320	contains two percent or less of: invert sugar	471
9321	natural and artificial flavor soy lecithin	185
9322	vitamin b2	248
9323	partially hydrogenated vegetable oil shortening contains one or more of the following: soybean oil	243
9324	contains two percent or less of: cornstarch	263
9325	artificial color fd&c yellow #5	403
9326	Enriched flour bleached wheat floor reduced iron	131
9327	thiamin vitamin b1	1085
9328	contains two percent or	1
9329	ribolfavin vitamin b2	818
9330	palm and/or palm kernel and/or partially hydrogenated pal kernal oil+	201
9331	whole wheat powder	802
9332	contains two perce	185
9333	paprika oleoresin and annatto and turmeric extracts for color	934
9334	chocolate flavored chips† sugar	1
9335	cocoa proc	118
9336	contains two percent or less of: high fructose corn syrup	344
9337	titanium dioxide an artificial color	369
9338	enzyme modified soy protein	276
9339	sugar palm oil	201
9340	chocolate flavored chips+ sugar partially hydrogenated palm kernel oil	286
9341	dextrose and soy lecithin an emulsifier	750
9342	contains two percent or less of: sodium bicarbonate	24
9343	natural artificial flavors	895
9344	sunflower and/or canola oil contains ascorbic acid and rosemary extract for freshness	147
9345	multigrain flour blend wheat	131
9346	flax	207
9347	durum	1968
9348	contains two percent or less of: leavening baking soda	24
9349	yellow prussiate of soda.	780
9350	Black peppercorn	12
9351	white peppercorn	12
9352	green peppercorn	66
9353	red peppercorn.	12
9354	Whole black peppercorns.	12
9355	cinnamon chips.	15
9356	beer extract	391
9357	silicon dioxide added as a flow agent.	309
9358	ground mustard	95
9359	dehydrated orange peel	366
9360	balsamic vinegar powder maltodextrin	197
9361	Organic black chia seeds.	1631
9362	Organic whole brown flaxseed.	1969
9363	Organic ground golden flaxseed.	157
9364	Shelled hemp seeds.	1970
9365	Blanched almond flour.	377
9366	emulsifier mono- and diglycerides with preservatives mixed tocopherols	1971
9367	ascorbic acid and citric acid	1890
9368	partially hydrogenated vegetable shortening contains one or more of the following: cottonseed and/or soybean oil	243
9369	mono- and diglycerides with preservative  mixed tocopherols	1972
9370	preservative citric acid	200
9371	emulsifier polysorbate 60	587
9372	partially hydro generated vegetable shortening contains one or more of the following: partially hydrogenated soybean oil	599
9373	cotton seed oil.. water	583
9374	emulsifiers mono- and diglycerides with preservatives mixed tocopherols	1973
9375	color red 40 lake	1974
9376	Chocolate cake sugar	1
9377	dry egg yolk	185
9378	propylene glycol mono & diesters of fatty acids	939
9379	mono &	630
9380	propylene glycol mono & dies	616
9381	propylene glycol mono &	616
9382	Brownie mix sugar	1
9383	Brownie sugar	13
9384	egg yol	796
9385	Enriched wheat flour contains wheat flour	131
9386	Organic agave.	1975
9387	sodium saccharin 32 mg saccharin	756
9388	calcium silicate anti-caking agent.	1010
9389	Salt ingredients: salt	148
9390	pepper ingredient: pure black pepper.	12
9391	Peanut oil.	741
9392	Olive oil composed of refined olive oils and extra virgin olive oil.	6
9393	dimethyl silicone for anti-foaming	1595
9394	propellant. adds trivial amount of fat	1976
9395	vegetable mono-and diglycerides.	729
9396	contains less than 2% of natural and artificial flavors	196
9397	and sodium hexametaphosphate.	1275
9398	sodium hexametaphosphate.	1275
9399	and sodium hexametphosphate.	1275
9400	partially hydrogenated vegetable shortening contains soybean oil with emulsifier mono- and diglycerides	243
9401	vegetable shortening contains one or more of the following: palm oil	201
9402	and/or soybean oil with emulsifier propylene glycol monoesters	1977
9403	emulsifier propylene glycol mono- and diesters	1978
9404	preservative bht	721
9405	vegetable shortening contains one or more of the following: palm oil and/or soybean oil with emulsifier propylene glycol mono and dieste	1979
9406	vegetable shortening contain one or more of the following: palm and/or soybean oil with emulsifier propylene glycol monoesters	1597
9407	emulsifier propylene glycol mono and dieters	616
9408	vegetable shortening contains one or more of the following: palm oil and/or soybean oil with emulsifier propylene glycol mono- and diesters	1980
9409	mono- and diglycerides and soy lecithin with preservative bht	1981
9410	confetti bits sugar	1
9411	whipping aid sodium lauryl sulfate.	1982
9412	Filling high fructose corn syrup	344
9413	raspberry puree concentrate	1691
9414	natural and artificial f	403
9415	whole wheat flakes	802
9416	crisp rice with soy protein rice flour	138
9417	mixed tocopherols to retain freshness	154
9418	modified co	332
9419	color added. citric acid	200
9420	vitamin a palmate	562
9421	pyriodoxine hydrochloride vitamin b6	525
9422	caramel color. vitamins and minerals: calcium carbonate a source of calcium	452
9423	ricoflavin	818
9424	foli	819
9425	dehydrated apples treated with sulfur dioxide and sodium sulfite to promote color retention	306
9426	beet powder for color. vitamins and minerals: calcium carbonate a source of calcium	853
9427	ferric orthophosphate a source of iron	251
9428	caramel color. vitamin and minerals: calcium carbonate a source of calcium	452
9429	ribofalvin	818
9430	sucralose splenda brand. vitamins and minerals: calcium carbonate a source of calcium	399
9431	dehydrated apples treated with sodium sulfite to promote color retention	1075
9432	sucralose splenda brand. vitamins and minerals: calcium carbonate	399
9433	Whole grain rolled oats with oat bran	78
9434	cranberries dried cranberries	188
9435	milled flaxseed	207
9436	calcium carbonate a source of calcium	203
9437	100% organic steel cut oats.	78
9438	Organic whole grain rolled oats.	78
9439	trisodium phosphate. vi	194
9440	contains 2% or less of corn syrup	596
9441	vegetable oils palm kernel and canola	26
9442	sodium sulfite to promote color retention. vitamins and minerals: sodium ascorbate vitamin c	1075
9443	malt syrup. vitamin and minerals: sodium ascorbate vitamin c	176
9444	malt syrup. vitamins and minerals: sodium ascorbate vitamin c	176
9445	malt flavoring. vitamins and minerals: vitamin b3 niacinamide	391
9446	honey coated sliced almonds dry roasted almonds	60
9447	bht a preservative. vitamins and minerals: sodium ascorbate vitamin c	721
9448	vitamin e mixed tocopherols added to preserve freshness. vitamin and minerals: calcium carbonate	1983
9449	zinc oxide and reduced iron mineral nutrients	1357
9450	vitamin b1 thiamine mononitrate	1085
9451	malt syrup.	176
9452	calcium pantothenate a vitamin	496
9453	bht to preserve freshness. vitamins & minerals: vitamin b1 thiamin mononitrate	747
9454	Whole rolled pats	78
9455	naturally milled cane sugar	170
9456	whole almonds	60
9457	crisp rice crisp rice muffs	64
9458	ground flax seed	207
9459	vitamin e mixed tocopherols added to preserve freshness.vitamins and minerals: calcium carbinate	169
9460	mixed tocopherols natural vitamin e	169
9461	herb blend organic sugar	1
9462	organic cardamom	230
9463	organic fenugreek	232
9464	organi	1592
9465	sodium bisulfate	1289
9466	hot sauce aged cayenne red peppers	69
9467	worchestershire sauce vinegar	73
9468	sulfating agent	426
9469	pin	1984
9470	Pasta durum semolina flour enriched flour ferrous sulfate	451
9471	riboflavin and folic acid and water	1985
9472	pasteurized egg yolks	1412
9473	Red potato	279
9474	american cheese water	5
9475	cas	924
9476	potassium sorbate preservatives	338
9477	pickle relish	1986
9478	Tuna tuna	1113
9479	pickle relish cured cucumbers	122
9480	cel	740
9481	naturally derived citric acid	200
9482	contains 2% or less of: butter cream	2
9483	Vegetable stock water	1987
9484	cannellini beans cannellini beans	1407
9485	kombu seaweed	1988
9486	whole milk milk	7
9487	contains 2% or less of: red bell peppers	84
9488	roast	1989
9489	vegetable base carrots	119
9490	black bean flakes black beans	669
9491	contains 2% or less of: red wine vinegar	110
9492	oregan	42
9493	Montamore cheese pasteurized milk	1990
9494	Montamore	1991
9495	parmesan and asiago cheese pasteurized milk	1009
9496	Parmesan and romano cheese pasteurized milk	62
9497	penicillium roqueforti.	1236
9498	cellulose powder anti-caking	740
9499	natamycin yeast and mold inhibitor.	1008
9500	Pasteurized unfiltered cider from select organic apples.	1992
9501	Pasteurized unfiltered juice from select organic apples.	322
9502	Fresh pressed pasteurized juice from 100% organic honeycrisp apples.	322
9503	Pasteurized 100% pure apple juice from whole organic gravenstein apples.	322
9504	Fresh pressed pasteurized unfiltered juice from select organic gala apples.	322
9505	Crust wheat flour	131
9506	dough conditioners datem	1993
9507	soy lecithin processing aid	185
9508	cheeses whole milk mozzarella cheese pasteurized milk	7
9509	parmesan and romano cheese blend both made with pasteurized cow's milk	1086
9510	pepperoni pork	534
9511	spices. caramel color	834
9512	tamrind	453
9513	White and gold corn	134
9514	red and green peppers	195
9515	water. contains 2% or less of cellulose gum	5
9516	extractives of turmeric color	383
9517	corn syrup garlic	4
9518	contains less than 1% of: sodium citrate	477
9519	stabilizer grade a whey	193
9520	calcium sulfate locust bean gum	924
9521	vitamin a vitamin a palmitate	1171
9522	bht.	721
9523	potassium sorbate and carbon dioxide preservative	338
9524	potassium sorbate and carbon dioxide preservatives	1994
9525	and locust bean gum	339
9526	Organic grade a cream	473
9527	less than 2%: organic corn starch	866
9528	Organic cultured grade a milk	7
9529	vanilla flavor water	20
9530	organic vanilla flavors	20
9531	organic cream.	473
9532	strawberry puree organic sugar	1879
9533	mono and	630
9534	Cultured pasteurized skim milk	472
9535	fruit and vegetable juice concentrates for color	1995
9536	calcium chloride. contains five live active cultures including s. thermophilus	340
9537	bifidus and l. casei.	1996
9538	pectin. contains five live active cultures including s. thermophilus	337
9539	stevia extract	859
9540	citric acid. contains five live active cultures including s. thermophilus	200
9541	bifidus	1215
9542	and l. casel.	1997
9543	calcium chloride. contains five live active cultures including s	340
9544	contains five live active cultures including s. thermophilus	1389
9545	l bulgaricus	1390
9546	and l. casei.	1998
9547	stevia extract. contains five live active cultures including s. thermophilus	859
9548	turmeric for color. contains five live active cultures including s. thermophilus	383
9549	fruit and vegetable juice for color. contains five live active cultures including s. thermophilus	295
9550	Cultured pasteurized skim milk. contains five live active cultures including s. thermophilus	7
9551	l. bugaricus	1999
9552	locust bean gum. contains five live active cultures including s. thermophilus	339
9553	l acidophilus	867
9554	bifidus and l casei.	1996
9555	black carrot juice concentrate for color.	590
9556	orange pulp cells	65
9557	blood orange juice concentrate	1580
9558	fruit and vegetable juice concentrates for color and calcium chloride. contains five live active cultures including s. theromphilus	2000
9559	l.bulgaricus	1390
9560	l.acidophilus	867
9561	and l.casei.	2001
9562	Cultured grade a nonfat milk	7
9563	peach puree peaches	1192
9564	peach flavor with other natural flavors	2002
9565	artificial color {fd & c yellow #6}	403
9566	calcium chloride. contain five live active cultures including s. thermophilus	340
9567	l. b	295
9568	strawberry banana puree strawberries and bananas	136
9569	strawberry and banana flavors with other natural flavors	2003
9570	potassium sorbate and artificial color fd&c red #40	2004
9571	grade a whey protein concentrate	387
9572	nonfat dry milk.	1182
9573	stabilizers carob been and/or xanthan and/or guar gums	475
9574	Cultured pasteurized reduced fat milk	1188
9575	Colby cheese cultured pasteurized milk	1239
9576	Filling: butternut squash	1064
9577	breadcrumbs wheat flour	131
9578	amaretti cookies sugar	1
9579	dried egg white	584
9580	salt. pasta: soft wheat flour	140
9581	durum wheat se	1968
9582	Filling: ricotta cheese cultured whey	971
9583	grana padano cheese dop milk	1625
9584	lysozyme from egg white	1164
9585	pasteurized	2005
9586	Filling; mozzarella cheese milk	531
9587	ricotta cheese cultured whey	971
9588	roasted tomato contains salt	148
9589	Filling: sauteed mushrooms mushrooms	46
9590	porcini mushroom	1623
9591	grated cheese m	38
9592	sodium benzoate & bha to preserve freshness	454
9593	Water gelatin	459
9594	salt. if black cherry or cherry: natural & artificial flavor	140
9595	blue 1. if lemon lime: natural & artificial flavor	2006
9596	yellow 5 blue 1; if orange: natural favor yellow 6.	795
9597	organic monterey jack cheese organic cultured	1204
9598	Organic yellow colby cheese organic pasteurized cultured milk salt	148
9599	organic annatto vegetable color microbial enzymes	722
9600	organic monterey jack	1204
9601	cheese organic pasteurized cultured milk	7
9602	Organic grade a lowfat milk	7
9603	Organic grade a whole milk	7
9604	Organic grade a reduced fat milk	1188
9605	Organic grade a fat free milk	7
9606	Organic grade a reduced-fat milk	2007
9607	Pasteurized organic sweet cream	1632
9608	Lowfat milk	994
9609	carrageenen	206
9610	Low fat milk high fructose corn syrup	2008
9611	vitamin d3 added.	1189
9612	dl-alpha-tocopherol acetate vitamin e.	169
9613	sunflower lecthin	2009
9614	d-alpha tocopherol natural vitamin e.	169
9615	strawberry lemonade concentrate concentrated lemon juice sugar	1
9616	natural flavored tea powder maltodextrin	197
9617	grade a whey	193
9618	monoester	2010
9619	sodium phosphate sodium hexametaphosphate	194
9620	stabilizerscarob bean and/or xanthan and/or guar gums.	265
9621	stabilizers carob bean and/or xanthan and/or guar gums.	475
9622	dried chives	2011
9623	lemon concentrate	200
9624	orange solids	2012
9625	stabilizers carob bean and/or xanthan gums	265
9626	Parmesan cheese cultured pasteurized part-skim milk	62
9627	cellulose powder added to prevent caking. potassium sorbate preservative.	740
9628	monterey jack cheese cultured pasteurized milk	1204
9629	anticake potato starch	519
9630	Made from pasteurized milk	640
9631	and annatto color if colored.	722
9632	Organic pork	534
9633	pasteurized process cheddar cheese cheddar cheese cultures milk	32
9634	contains less than 2%of enzyme modified cheese cheddar cheese {cultured milk	2013
9635	pasteurized process swiss cheese swiss cheese {culture milk	1282
9636	powdered cellulose to prevent caking	740
9637	potassium sorbate and natamycin preservatives}	2014
9638	mushrooms mushrooms	46
9639	and edta	455
9640	seasoning encapsulated slat {salt	148
9641	partially hydrogenated soybean oil}	243
9642	seasoning {potassium chloride	1562
9643	natural flavors}	895
9644	mushroom flavor {tapioca dextrin	2015
9645	annato	236
9646	contains less than 2% caramel color	357
9647	mushroom concentrate	1622
9648	potato starch}	519
9649	swiss cheese flavor enzyme modified swiss cheese {milk	1282
9650	vidalia onions	1907
9651	contains less than 2% of enzyme-modified cheese cheddar cheese {cultured milk	2016
9652	ja	2017
9653	Skinless chicken thigh	2018
9654	mozzarella cheese pasteurized cow's milk	531
9655	dehydrated green peppers	66
9656	in a natural pork casing	2019
9657	dehydrated apples	738
9658	feta cheese pasteurized cow's milk	1645
9659	aged provolone cheese pasteurized cow's milk	2020
9660	dehydrated mushrooms	1621
9661	contains 2% or less of: raw sugar	170
9662	parmesan cheese pasteurized cow's milk	62
9663	contains 2% or less of: dehydrated red and green peppers	55
9664	sun dried tomatoes tomato	700
9665	dehydrated sweet red peppers	2021
9666	diced ham cured with: water	148
9667	swiss cheese pasteurized cow's milk	1163
9668	Enriched wheat flour wheat flour enriched with niacin	131
9669	white corn meal	149
9670	yeast food monocalcium phosphate	259
9671	ammoniium sulfate	915
9672	dough conditioners ammonium phosphate	918
9673	ammonium chorlide	140
9674	natural vani	186
9675	milk chocolate chunk sugar	1
9676	natural vanilla ext	21
9677	vegetable shortenings palm oil with beta carotene color	201
9678	natural and artificial flavor propylene glycol	616
9679	sunset yellow 6	2022
9680	dextrose. c	750
9681	vegetable oil margarine palm and palm kernel oil	201
9682	liquid canola oil	90
9683	vegetable monoglyce	592
9684	sugar chocolate chips sugar	1
9685	soyb	142
9686	degermed yellow cornmeal	149
9687	egg. cooked in a vegetable oil contains one or more of: corn oil	14
9688	soybean oil frank ingredients: mechanically separated chicken	1517
9689	paprika and paprika oleoresin	195
9690	cooked in vegetable oil contains one or more of: corn oil	26
9691	soybean oil. frank ingredients: mechanically separated chicken	243
9692	egg cooked in vegetable oil contains one or more of: soybean oil	243
9693	paprika & paprika oleoresin	55
9694	contains less than 2% of flavorings	196
9695	less than 2% of the following: salt	140
9696	spices in a collagen casing.	198
9697	natural and artificial maple flavors sugar	1
9698	benzyl alcohol	2023
9699	less than 2% of the following: dextrose	750
9700	spices including fennel and red pepper	231
9701	spices including fennel and black pepper	231
9702	natural spices including fennel and black pepper	834
9703	Cured with: turkey thighs	1095
9704	Soybeans.	256
9705	Sweeteners high fructose corn syrup	344
9706	concentrate lemon juice	18
9707	water tricalcium phosphate	751
9708	raspberry concentrate	208
9709	concentrated fruit juices apple	322
9710	passion fruit	1032
9711	Organic strawberries organic blackberries	88
9712	organic red raspberries	208
9713	Organic red raspberries.	208
9714	organic blackberries	658
9715	red raspberries and blueberries.	2024
9716	and water	5
9717	Wild blueberries.	2025
9718	italian beans	605
9719	broccoli florets	116
9720	mushrooms.	2026
9721	Cooked quinoa water	2027
9722	white	1
9723	red and black quinoa	167
9724	red and yellow peppers	195
9725	eggplant	2028
9726	sundried tomatoes	1029
9727	black olives	1477
9728	chili powder.	195
9729	Cooked freekeh water	2029
9730	roasted green durum wheat	1968
9731	extract virgin olive oil	6
9732	fresh ginger	28
9733	Cooked organic macaroni organic durum wheat semolina	1280
9734	organic cheese sauce pasteurized organic milk	7
9735	organic mozzarella cheese pasteurized organic milk	531
9736	sodium acid pyrophosphate added to maintain natural color.	518
9737	folic acid. contains 2% or less of annatto color	727
9738	d	1
9739	contains 2% or less of corn starch - modified	332
9740	red bell peppers. contains 2% or less of dextrose	536
9741	contains 2% or less of annatto color	722
9742	partially hydrogenated lard with bha and bht to protect flavor	2030
9743	sugar. contains 2% or less of: whey	1
9744	partially hydrogenated lafd with bha and bht added to protect flavor	881
9745	colored with yellow	590
9746	malt powder dried corn syrup	2031
9747	sour dough cultures.	958
9748	Bread: enriched flour bleached wheat flour	131
9749	ammonium aluminum sulfate	612
9750	diammonium phosphate	2032
9751	corn meal. spread: natural oil blend soybean	730
9752	palm fruit	201
9753	palm stearine	2033
9754	palm kernel and/or canola	2034
9755	potassium sorbate and sodium benzoate to protect quality	803
9756	betacarotene for color	590
9757	stone ground whole wheat flour	283
9758	pyridoxine hydrochloride vitamin b2	525
9759	folic acid b12.	727
9760	Enriched wheat flour flour. niacin	131
9761	vegetable oil canola andior soybean oil	26
9762	pyridoxine hydrochloride vitamin 66	525
9763	riboravin vitamin 62	818
9764	pyridoxine dydrochloride vitamin b6	525
9765	vitmain b12.	1191
9766	Croissant enriched bleached flour wheat flour	131
9767	vegetable shortening partially hydrogenated soybean and / or cottonseed oils	881
9768	water. contains 2% or less of each of the following: salt	5
9769	calcium propionate and potassium sorbate as preservatives	1240
9770	pork sausage patties pork	534
9771	bha and bht antioxidants	1857
9772	egg patty whole eggs	14
9773	soy lecithin release agent	185
9774	process american sharp cheese cultured milk and skim milk	640
9775	ham pork cured with water	128
9776	Biscuit bleached enriched wheat flour bleached wheat flour	131
9777	buttermilk cultured low-fat milk	2035
9778	leavening {sodium bicarbonate	24
9779	anhydrous monocalcium phosphate}	259
9780	enriched flour {wheat flour	131
9781	processed american sharp cheese cultured milk and skim milk	38
9782	Whole wheat flatbread whole wheat flour	283
9783	dough conditioners mono and diglycerides	729
9784	ascorbic acid. calcium propionate preservative	329
9785	processed american pepper jack cheese cultured milk and skim milk	1859
9786	contains 2% or less of the following: soybean oil. polydextrose	243
9787	whole milk powder. soybean oil	243
9788	processed sharp american yellow cheese cultured milk and skim milk	38
9789	enzymes soy lecithin.	185
9790	Wheat english muffin bleached enriched flourwheat flour	131
9791	water whole wheat flour	283
9792	contains less than two percent of the following: wheat gluten	955
9793	egg white patty  egg whites	376
9794	turkey patty turkey	1095
9795	textured vegetable protein product soy protein	276
9796	and cyanocobalamin	526
9797	Croissant wheat flour	131
9798	mono diglycerides	729
9799	beta carotene {color}	478
9800	dough conditioner wheat flour	131
9801	emulsifer water sorbitan monostearate	591
9802	sodium propionate {preservative}	1601
9803	egg white patty egg whites	376
9804	textured vegetable protein product soy protein concentrate zinc oxide	276
9805	salt corn syrup solids	140
9806	hydrolyzed soy protein flavoring	276
9807	Durum wheat flour enriched with iron ferrous sulfate and b vitamins niacin	239
9808	whole milk ricotta cheese sweet whey	971
9809	asiago cheese pasteurized cow's milk	972
9810	enzymes powdered cellulose added to prevent caking	309
9811	romano cheese pasteurized sheep's milk	969
9812	flour blend yellow corn flour	165
9813	extractives of turmeric and paprika	2036
9814	and anti-caking agent powdered cellulose and potassium sorbate to protect flavor	338
9815	half & half milk	473
9816	wheat fiber	1359
9817	fresh garlic	4
9818	fresh sage	1305
9819	fresh rosemary	89
9820	portobello mushrooms	505
9821	natural mushroom base sauteed mushrooms	46
9822	butter sweet cream	1771
9823	natural fiavorings	1731
9824	spice & vegetable extract	2037
9825	dehydrated potatoes 100% potatoes	279
9826	natural parmesan flavor contains milk	7
9827	natural romano flavor contains milk	7
9828	and/or soybean barley malt	1586
9829	hops	530
9830	reduced iron thiamine monitrate	251
9831	Minced alaska pollock	1849
9832	Od	2038
9833	beer water	5
9834	yeast wheat flour	131
9835	contains 2% or less of: maltodextrin	197
9836	leavening sodium acid p	780
9837	potato sticks dried potatoes cottonseed oil	279
9838	dried potatoes	279
9839	parmesan and romano cheese milk	640
9840	sod	594
9841	flavored bits corn syrup	596
9842	bleached wheat flour enriched with niacin	131
9843	tortilla chips yellow whole cor	134
9844	potato sticks dried potatoes	279
9845	olive oil blend canola oil and olive oil	6
9846	natural flavors with smoke and grill flavors	196
9847	dehydrated lemon peel	909
9848	natural hickory smoke flavor.	749
9849	Cod	2039
9850	sun-dried tomatoes	700
9851	dehydrated sun-dried tomato	240
9852	molasses corn syrup	156
9853	soybean oil as a processing aid	243
9854	peach juice solids	499
9855	olive oil blend canola oil and olive oil.	6
9856	poblano black bean salsa super sweet corn	134
9857	red onion	1102
9858	poblano pepper	1347
9859	black bean black bean	669
9860	sea salt blend potassium including chili pepper	98
9861	Tilapia.	814
9862	Swai.	2040
9863	Atlantic salmon	808
9864	astaxanthin added for color.	2041
9865	Mahi mahi.	2042
9866	Halibut.	2043
9867	Walleye.	2044
9868	Lake whitefish.	2045
9869	Bluegill.	2046
9870	Ice cream mixskim milk	472
9871	stabilizer dextrose.	750
9872	less than 1% sodium aluminosilicate	1311
9873	pistachio flavor water	2047
9874	food coloring water	5
9875	sodiumbenzoate.	354
9876	chocolate almond and truffle blend sugar	1748
9877	roasted almonds {almonds	60
9878	canola and/or safflower oil}	26
9879	butter {cream	393
9880	powdered sugar {sugar	170
9881	cornstarch}	263
9882	stabilizer guar gum	475
9883	natural vanilla flavoring	20
9884	vanilla beans.	20
9885	nonfat dry milk; stabilizer whey protein	2048
9886	chocolate chipssugar{sugar	1
9887	corn starch}	263
9888	and milk	640
9889	creme de menthe water	2049
9890	propyleneglycol	616
9891	custard base egg yolks	1412
9892	evaporated milk	2050
9893	sweetened condensed milk {condensed milk	2051
9894	sugar}	170
9895	chocolate chip cookie dough unenriched wheat flour	131
9896	cookie dough base brown sugar	13
9897	chocolate chips sugar {sugar	1
9898	stabilizer whey protein	387
9899	chocolate chips {sugar	1
9900	vanilla}	20
9901	chocolate butter fudgeribbon high fructose corn syrup	344
9902	margarine{liquid soybean oil	243
9903	soy mono and diglycerides	394
9904	artificial butter flavor	2052
9905	vitamin a palmitate}	562
9906	enriched wheat flour {wheat flour	131
9907	pasteurized egg	2053
9908	baking powder{sodium acid pyrophosphate	780
9909	mono calcium phosphate}	259
9910	powdered sugar{sugar	170
9911	coco processed with alkali	118
9912	chocolate butter fudge ribbon high fructose corn syrup	344
9913	margarine {liquid soybean oil	243
9914	stabilizer whey protein isolate	387
9915	pumpkin base pumpkin	559
9916	pumpkin pie spice	2054
9917	cream ribbon corn syrup	596
9918	dioxide salt	2055
9919	pie chips wheat flour	131
9920	grade whey	193
9921	lqcust bean gum	339
9922	and contains 2% or less of the following: puree water	5
9923	standardized with dextrose.	750
9924	chocolate chips sugar sugar	1
9925	high fructose corn sy	344
9926	sugar molasses	156
9927	natural and artificial strawberry flavor	1738
9928	sliced black cherries cherries	1194
9929	red #40.	677
9930	blueberry variegate high fructose corn syrup	344
9931	puree high fructose corn syrup	344
9932	cookie pieces sugar	1
9933	vegetable oil shortening {hydrogenated soybean and/or cottonseed oils}	1001
9934	fudge ribbon high fructose corn syrup. water	344
9935	chocolate flavored wafer: bleached wheat flour	131
9936	contains 2% or less of: cocoa	118
9937	orange puree water	1122
9938	carrageenan. coating: coconut oil	206
9939	cocoa and cocoa processed with alkali	118
9940	No sugar added	1
9941	reduced fat ice cream: milkfat and nonfat milk	7
9942	aspertame	1251
9943	natural and artificial flavcors	895
9944	vitamin a palmatate. sugar free chocolate flavored wafer: bleached wheat flour	1171
9945	ismalt	681
9946	contains 2% orless of: c corn flour	165
9947	sot lecithin.	185
9948	Milk fat and nonfat milk	7
9949	locust bran gum	339
9950	artificial flavors cherry	2056
9951	artificial colors blue #1	1692
9952	yellow #5 and #6	786
9953	fudge variegate powdered sugar sugar	1
9954	vegetable oil peanut and/or cottonseed oil and/or palm oil	26
9955	chocolate flakes powdered sugar	1
9956	natural stabilizers guar gum	475
9957	grape puree	1526
9958	stabilizers guar gum	475
9959	carob bean gun	800
9960	corn syrup and less than 2% of the following: salt	596
9961	water and less than 2% of the following	5
9962	and less than 2% of the following: alt	1311
9963	dextrose monosodium glutamate	708
9964	flavorings spice extractives	1295
9965	collagen casing.	1853
9966	Pork. water and less than 2% of the following: salt	534
9967	flavorings maple and spice extractives	2057
9968	Ingredients:shrimp	86
9969	Ingredients: shrimp	86
9970	cottoneseed	583
9971	enriched bleachedwheatflour flour	784
9972	pyrophosphate	1724
9973	sodium bicarbonate monocalciumphosphate	24
9974	sodium tripolyphospahte	820
9975	to retain moisture.	234
9976	enriched bleached wheat flour	131
9977	Gulf shrimp	86
9978	sodium tripolyphosphates to retain moisture.	2058
9979	salt. sauce: water	148
9980	prepared horseradish horseradish root	212
9981	oil of mustard	1662
9982	distilled vinegar water	480
9983	bro	2059
9984	salt sodium tripolyphosphate.	820
9985	Scallops mollusks.	2060
9986	natural peppermint oil	458
9987	soy lecithin and pgpr emulsifiers	185
9988	soybean oil and/or corn oil	2061
9989	less than 2% of salt. natural and artificial flavoring	148
9990	and potassium sorbate preservative.	338
9991	chocolate liquor-processed with alkali	118
9992	soy lecithin an emulsifier and oil of peppermint.	185
9993	soy lecithin eumlsifer	185
9994	salt macadamia nuts and confectioners glaze.	140
9995	cherries red tart pitted cherries	189
9996	sunflower oil and confectioners glaze.	2062
9997	vanillablueberrieswildblueberris	20
9998	center sweet condensed milk milk solids	777
9999	sucrose corn syrup	170
10000	fondant sucrose	170
10001	palm kernel oil partially hydrogenated palm kernel oil w/soy lecithin emulsifier	286
10002	caramel flavor n &aflavors	452
10003	inversweethigh fructose cornsyrup	554
10004	butter pasteurized cream milk	7
10005	vanillin artificial flavor vanilla	186
10006	natural vanilla and sea salt.	20
10007	fodant sucrose	170
10008	caramel flavor n&a flavors	452
10009	inversweet high fructose corn syrup	344
10010	dry roasted coffee beans and confectioners glaze.	550
10011	chocolate liquior processed with alkali	118
10012	pomegranate cranberries cranberries	412
10013	Organic dark chocolate coating organic sugar	1
10014	organic soy lecithin emulsifier	185
10015	organic sugar.	170
10016	organic soy lecithin an emulsifier	185
10017	organic banana chips organic bananas	136
10018	dried organic cranberries organic cranberries	737
10019	organic sunflower	151
10020	chocolate liquor. cocoa butter	171
10021	coffee beans	550
10022	corn syrup modified tapioca starch	1559
10023	modifiedtapioca starch	757
10024	sorbic acid.	854
10025	Greek yogurt coating sugar	1
10026	yogurt powder whey protein concentrate	387
10027	yogurt cultures	867
10028	dried pomeg	412
10029	liquid sugar	170
10030	con	134
10031	soy lecith	185
10032	coconut coconut	68
10033	contains 2% or less of calcium chloride	340
10034	Pure vinegar made from red grape wine and filtered water.	480
10035	potassium sorbate sodium benzoate.	2063
10036	Organic dark chocolate chips organic cane sugar	1
10037	organic dark chocolate raisins organic dark chocolate coating organic sug	763
10038	Organic raisins treated with organic canola oil or organic sunflower oil	67
10039	organic hulled sunflower seeds	151
10040	organic shelled pumpkin seeds	161
10041	organic cashews dry roasted salted organic cashews	145
10042	organic almonds dry roasted salted organic almonds	60
10043	Organic raisins treated with organic sunflower and/or organic canola oil	67
10044	organic almonds.	60
10045	Organic raw walnuts.	733
10046	organic oleic sunflower oil and salt.	147
10047	Organic raw pecans.	732
10048	organic cashew pieces	145
10049	and wheat gluten	326
10050	cor syrup solids	750
10051	spices including white pepper	960
10052	disodium inosinate and disodium guanylate flavor enhancers	1039
10053	and sulfiting agents.	397
10054	and caramel color.	357
10055	spices including sage	1305
10056	and fd&c yellow 5 and 6.	786
10057	and cumin	43
10058	fd&c yellow 6 and red 40	2064
10059	and garlic.	4
10060	romano cheese made from cow's milk cultured pasteurized part-skim milk	969
10061	spices including oregano	42
10062	and beet powder for color.	174
10063	Organic baby spinach.	79
10064	Organic baby arugula.	1812
10065	mini pretzel enriched wheat flour wheat flour	131
10066	raspberry mash corn syrup	596
10067	dextrose. contains less than 2% or less of the following: sodium carboxymethylce	750
10068	praline nut seasoning sugar	1
10069	and less than 2% silicon dioxide	631
10070	butter.	639
10071	and parsley	22
10072	and extractives of paprika.	55
10073	Raw almonds usa.	60
10074	contains 2% or less of: black bean powder	2065
10075	Yogurt grade a pasteurized skim milk	472
10076	sour cream cultured skim milk	25
10077	contains 2 percent or less of the following: natural flavor	210
10078	confectioners glaze.	502
10079	contains 2 percent or less of the following: malt center corn syrup	197
10080	invert sugar blend high fructose corn syrup	1
10081	malt ball center corn syrup	596
10082	milk compound coating sugar	1
10083	non	671
10084	soy le	394
10085	nonfat dry milk solid	801
10086	ground spices cinnamon	15
10087	cocoa butter oil	171
10088	candy cane sugar	1
10089	Cranberries usa	126
10090	Apricots turkey	275
10091	sulphur dioxide.	426
10092	Coconut philippines sodium metabisulfite added as preservative.	2066
10093	rspo hydrogenated vegetable oil palm kernel	286
10094	and vanillin an artificial flavoring.	186
10095	Dates pakistan	159
10096	white oat flour usa.	274
10097	dehydrated vegetables	2067
10098	dehydrated bell peppers	536
10099	citric acid and natural flavors.	2068
10100	Raw almonds usa. steam pasteurized	60
10101	Almonds usa	60
10102	sea salt. steam pasteurized	98
10103	artificial colors red 40 lake	677
10104	fd&c yellow 5 lake	403
10105	Allspice ground.	124
10106	Ancho pepper.	1782
10107	onion & garlic	2069
10108	Salt & celery seed.	2070
10109	& black pepper	12
10110	& garlic.	4
10111	Cinnamon sticks	15
10112	Cumin & cayenne pepper.	2071
10113	thyme & black pepper.	2072
10114	Vanilla bean.	20
10115	Sunflower seeds usa	271
10116	Peanuts usa roasted in sunflower oil	173
10117	Peanuts brazil	173
10118	argentina roasted in sunflower oil	147
10119	Peanuts usa	173
10120	Roasted peanuts peanuts brazil	173
10121	argentina	2073
10122	seasoning red pepper	195
10123	salted butter pasteurized cream	2
10124	chile	195
10125	milk chocolate pokies milk chocolate sugar	1
10126	soy lecithin and vanilla	185
10127	artificial color fd	648
10128	citrus pectin	337
10129	vegetable and fruit juice color	768
10130	grapefruit juice from concentrate	553
10131	lemon juice from lemon puree concentrate	200
10132	contains 2% or less of the following: peach puree concentrate	1192
10133	plum juice c	2074
10134	licorice center corn syrup	826
10135	enrichment wheat flour wheat	131
10136	licorice extract	826
10137	soy mono & diglyce	243
10138	kosher gelatin	459
10139	contains 2% or less than of the following: citrus pectin	337
10140	pretzels enriched flour wheat flour	131
10141	Yogurt coating sugar sugar	1
10142	yogurt coating mix sugar	1
10143	vanilla pretzels enriched flour wheat flour	131
10144	evaporated organic cane juice	2075
10145	Corn corn	134
10146	cayenne pepper sauce aged red pepper	725
10147	no more than 2% silicon diox	631
10148	vitamin b2 riboflavi	818
10149	organic dutch cocoa	118
10150	White chocolatesugar	1
10151	dark chocolatesugar	1
10152	candy canesugar	1
10153	pepp	10
10154	fd&c yellow no. 5	403
10155	yellow no. 6	403
10156	blue no. 1	1692
10157	red no. 40.	677
10158	molasses walnuts	156
10159	herb blend sugar	1
10160	cardamom seed	230
10161	fennel seed	231
10162	nutmeg.	2076
10163	glaze gum arabic	390
10164	sorbic	854
10165	citric acid sorbitol	200
10166	fd&c yellow no.5	403
10167	yellow no.6	403
10168	blue no.1	1692
10169	red no.40	677
10170	carnauba wax for anti-sticking.	415
10171	golden	590
10172	red no. 40	677
10173	carnauba wax for arrd-ad old ng.	415
10174	Raw cashews vietnam	145
10175	brazil.	728
10176	Raw pine nuts china.	1012
10177	carnauba wax for anti-smoking.	415
10178	steam pasteurized.	2005
10179	Dried apricots apricots turkey	2077
10180	prunes prunes usa	1824
10181	dried papaya papaya thailand	1334
10182	fd&c 5 and 6	786
10183	dried apple china	738
10184	dried pineapple pineapple thailand	1512
10185	sulfu	2078
10186	Jumbo golden raisins usa	1028
10187	sulfur dioxide added to preserve color.	306
10188	high oleic sunflower oil.	147
10189	Pineapple thailand	63
10190	Goji berries tibet.	2079
10191	artificial colors fd&c yellow#5	403
10192	yellow#6	794
10193	red#40	677
10194	blue#1	1692
10195	titanium dioxide less than 1%	369
10196	artificial colors fd&c yellow #6	403
10197	fd&c red #40.	677
10198	toffee butter	2
10199	whole cranberries usa	188
10200	golden raisins south africa	1028
10201	usa	594
10202	diced papaya thailand	1334
10203	diced pineapple thailand	63
10204	strawberries thailand	448
10205	cherries usa	189
10206	blueberries usa	130
10207	fd&c yellow #5 & #6	403
10208	raw walnuts usa	733
10209	dried cranberries cranberries usa	737
10210	dried goji berries tibet	2079
10211	raw pecans usa	732
10212	dried red tart cherries cherries usa	865
10213	raw filberts turkey	2080
10214	raw pistachios usa	320
10215	Roasted almonds almondsusa	60
10216	roasted pecansusa	49
10217	roasted pistachios pistachiosusa	320
10218	raw filberts turkey.	60
10219	Raw pumpkin seeds china.	161
10220	partially hydrogenated pam kernel oil	286
10221	peanut bu	123
10222	white onion	9
10223	cilantro leaves	2081
10224	lime juice concentrate citric acid	200
10225	sodium benzoate and sodium bisulfite preservatives and lime oil	2082
10226	Cashews vietnam	145
10227	brazil	728
10228	Bananas philippines	136
10229	natural banana flavoring.	2083
10230	Roasted cashews brazil	145
10231	vietnam	225
10232	india	383
10233	roasted almonds usa	60
10234	brazil nuts bolivia	728
10235	peru	2084
10236	roasted pecans jr usa	49
10237	almonds blanched usa	60
10238	filberts turkey	144
10239	high oleic sunflower oil. steam pasteurized.	147
10240	wasabi seasoning maltodextrin	197
10241	and calcium stearate	927
10242	added to prevent caking	309
10243	sweetened dried cranberries cranberries	126
10244	infused dried cherries red tar	865
10245	banana chips bananas	136
10246	expeller pressed coconut oil	135
10247	sweetened coconut flakes	68
10248	Pretzels wheat flour	131
10249	soda	356
10250	honey mustard seasoning sugar	1
10251	dried mustard distilled vinegar	73
10252	dextrose monohydrat	750
10253	barbecue seasoning sugar	1
10254	extract of papri	55
10255	Ingredients: pretzels wheat flour	131
10256	canola oil ranch seasoning maltodextrin	197
10257	parsl	22
10258	pizza seasoning sugar	1
10259	romano cheese	969
10260	silicon dioxide flow agent.	309
10261	Bbq sourdough pretzels pretzels wheat flour	131
10262	cane sugar salt	140
10263	jalapeno pepper. silicon dioxide anti-caking	195
10264	coconut flakes	68
10265	seasoning sugar fructose	1
10266	molasses refiner's syrup	156
10267	apple cider vinegar powder maltodextrin	197
10268	niacin vitamin b3	817
10269	sugar yeast	1
10270	calcium propionat	911
10271	ground caraway	521
10272	whole caraway seeds	521
10273	soybean oi	243
10274	calcium propionate a preserva	911
10275	sweet dairy whey	405
10276	soy lecithin; may be to	185
10277	calcium propiona	911
10278	folic acid water	727
10279	fruit juice concentrates elderberry juice	350
10280	watermel	2085
10281	cornmeal; topped with	149
10282	Organic whole grain wheat flour	131
10283	organic whole grain kamut bulgur wheat	1047
10284	organic whole grain oatmeal	1026
10285	organic whole gra	2086
10286	topped with organic crushed wheat.	143
10287	Dry roasted almonds usa.	60
10288	organic butter flavor	2052
10289	organic annatto.	722
10290	vegetable oil sunflower oil and/or canola oil	1382
10291	vegetable oil sunflower and/or canola oil	26
10292	sodium diacetate sodium acetate	602
10293	contains two percent or less of: salt and sea salt	148
10294	malt vinegar flavor	480
10295	Organic maple syrup.	102
10296	Organic distilled white vinegar	480
10297	Organic wild blueberries	411
10298	natural apple pectin	2087
10299	organic whole mustard seed	1138
10300	organic yellow mustard seed	1138
10301	Organically grown and processed tomatoes	240
10302	organic lentil beans	1891
10303	Organically grown and processed tomato puree	487
10304	organic sweet basil	48
10305	organic diced tomatoes tomatoes	240
10306	citric acid acidifier	200
10307	organic extract virgin olive oil	6
10308	organic crushed chilis	195
10309	org	42
10310	Beef stock water	1930
10311	dehydrated beef stock	1930
10312	roasted onion concentrate	9
10313	mono and diglycerides.	729
10314	organic enriched wheat flour organic wheat flour	131
10315	organic canola and/or organic soybean oil	978
10316	organic eggs	3
10317	organic concentrated chicken stock	97
10318	organic mushro	1621
10319	contains less than 1% of: salt	140
10320	onion juice concentrate.	9
10321	natural flavo	316
10322	Dry roasted organic blanched peanuts.	137
10323	sorbate preservative.	338
10324	Raw marcona almonds usa or spain	60
10325	Raw macadamia nut pieces	753
10326	natural caramel color.	357
10327	confectioner's coating sugar	170
10328	palm kernal oil	286
10329	confectioners coating sugar	1
10330	tapi	2088
10331	nutritional yeast	2089
10332	nutritional yeast turmeric	383
10333	organic miso paste	1469
10334	habanero peppers	836
10335	peanu	137
10336	oregano & less than 2% silicone dioxide flow agent.	42
10337	Roasted peanuts organic argentina	173
10338	sunflower oil organic	147
10339	palm oil organic.	201
10340	yogurt pretzels yogurt coating evaporated cane juice	1627
10341	pretzels	2090
10342	peanut pokies milk chocolate sugar	137
10343	vanillin an artificia	186
10344	lactase enzymes	1186
10345	vitamin a d3.	562
10346	Chocolate ice cream mix skim milk	56
10347	stabilizer dextrose	750
10348	pistachio ice	320
10349	Hot & spicy peanuts usa	173
10350	garlic sesame sticks unbleached wheat flour	131
10351	garlic pow	45
10352	enriched wheat flour bleached wheat flour malted barley flour niacin	131
10353	folic acid c	727
10354	less than 2% of: rice starch	1154
10355	roasted sunflower seeds sun	271
10356	calcium propio	911
10357	wasabi	2091
10358	artificial color fd&c yellow 5	403
10359	msg.	630
10360	contains 2% or less of each of the following: vegetable oil soybean and/or cottonseed oils	2092
10361	dough conditioners may contain one or more of the following: mono-and diglycerides	729
10362	yeast nutrients monocalcium phosphate	259
10363	ammonium sulfate and/or calcium	915
10364	contains less than 2% of each of the following: wheat gluten	955
10365	white whole wheat flour	283
10366	contains less than 2% of each of the following: dried toasted sliced onion	9
10367	ascorbic acid added as a dough conditioner.	329
10368	peanut pokies milk chocolate	137
10369	vanillin an artifici	186
10370	vegetable oil canola and/or safflower oil and/or sunflower oil	26
10371	Egg whites 99% contains 1% or less of the following: guar gum xanthan gum	475
10372	vitamin b6 pyrodoxine hydrochloride	2093
10373	Dry roasted pistachios	320
10374	Roasted in-the-shell peanuts	173
10375	black currant juice from concentrate	2094
10376	natural whole grain steel cut oats	78
10377	unsweetened apple juice	322
10378	diced apples salt	148
10379	seedless raisins	233
10380	apple spice dextrose	750
10381	sodium nitrate. may also contain smoke	952
10382	benzoyl peroxide	2095
10383	fresh potato	279
10384	cheddar cheese modified milk ingredients	32
10385	bacterial cultures	2096
10386	potassium sorbate and calcium disodium edta as preservatives.	1481
10387	parmesan cheese cultured pasteurized part skim milk	62
10388	contains less than 2% anchovies fish soy sauce water	1089
10389	contains lees than 2% modified food starch	746
10390	natural flavored	316
10391	potassium sorbate and calcium disodi	338
10392	contains less than 2% whey	193
10393	potassium sorbate an	338
10394	whey high fructose corn syrup	193
10395	contains less than 2% of onion juice	9
10396	garlic juice	4
10397	potassium s	1340
10398	contains less than 2% spice	198
10399	oleor	2038
10400	potassium sorbate and calcium disodium	338
10401	oils soybean oil	243
10402	contains 2% or less of: lemon juice concentrate	18
10403	water mustard seed	1138
10404	burdock root	2097
10405	shitake black mushrooms	2098
10406	dried bean curdisoybeans	277
10407	fried bean curd soybean	256
10408	corn oil salt	148
10409	soysauce water	5
10410	monosodium gl	594
10411	Nama wakame salted seaweed	2099
10412	fd&c yellow #5	403
10413	fd&c blue #1 and natural flavor.	1692
10414	whole egg powder less than 2% sodium silico aluminate added as an anticaking agent	2100
10415	Seaweed.	1034
10416	white distilled vinegar and acetic acid.	480
10417	Noodles: wheat flour	131
10418	hydrolyzed protein sardine	2101
10419	tuna	1113
10420	alginic acid	380
10421	sodium metaphosphate	2102
10422	guar gum. sauce: worcester sauce brewed vinegar	475
10423	hydrolyzed soybean protein	276
10424	vegetable oil rapeseed oil	187
10425	rice oil	2103
10426	hydrolyzed protein bonito	713
10427	scallop extract scallop	2104
10428	hydrolyzed protein soybeans	276
10429	horse mackerel	2105
10430	spirit vinegar	480
10431	brewed vinegar	480
10432	monosodium glutamate. dried vegetable: cabbage cabbage	708
10433	magnesium carbonate. garnish: dried worcester sauce modified potato starch	1783
10434	worcester sauce	54
10435	spices pepper	10
10436	dried seaweed	2106
10437	Bamboo shoots and citric acid.	2107
10438	Glutnous rice flour	2108
10439	modified tapioca starch.	757
10440	mandarin orange pulp	1502
10441	mandarin orange concentrate	1502
10442	orange concentrate	2109
10443	carboxymethly cellulose	600
10444	Oolong tea.	2110
10445	Jasmine scented green tea	501
10446	jasmine flower.	2111
10447	roasted rice	64
10448	popped sorghum seed	2112
10449	Seasoned fried soybean curd soybean	256
10450	glucose rice	315
10451	rice koji	1660
10452	Sugarcane molasses.	156
10453	red chili peppers	195
10454	Glutinous rice	2113
10455	waxy corn starch	263
10456	eat	169
10457	glutinous rice powder glutinous rice	2113
10458	cooking wine glutinous rice	2113
10459	ethanol	384
10460	non-glutinous rice	2113
10461	fd&c yellow no. 6	403
10462	red pepper extract	725
10463	Glucose syrup corn starch	315
10464	sweet rice	2114
10465	orange flavor fd & c red no.40 allura red ac	677
10466	star anise	2115
10467	mustard flour corn flour	165
10468	fd & c yellow no. 5 and fd & c blue no. 1 mix desired amount of powder with enough water to form a paste. cover and let stand 5 minutes for flavor to develop.	2116
10469	Japanese radish	2117
10470	sodium ascorbate antioxidant	329
10471	disodium succinate	1521
10472	fd&c yellow no.5.	403
10473	cornstarch and water.	139
10474	Mung bean starch	2118
10475	and water.	5
10476	Sesame seed oil.	112
10477	Unbleached enriched wheat flour niacin	131
10478	leavenings sodium acid pyrophosphate	780
10479	Red beans.	1889
10480	Milled rice.	64
10481	shorteningpartially hydrogenated soy bean oil	599
10482	Black sesame seeds	2119
10483	Sauries	1
10484	Berkshire pork	2120
10485	salt and 2% or less of potato starch	140
10486	natural flavor with smoke flavor	1558
10487	sodium caserinate milk	640
10488	tapica maltodextrin	197
10489	rendered bacon fat and cooked bacon cured pork with water	719
10490	sodium nitrate and smoke flavor	952
10491	Lychees	675
10492	water and sugar.	2121
10493	Salted plum plum	1496
10494	perilla juice	2122
10495	thiamine hydrochloride.	468
10496	perilla	2123
10497	fd&c red no. 40.	677
10498	: berkshire pork	2120
10499	sodium. phosphates	556
10500	soy bean and salt	256
10501	Squid	2124
10502	monosodium glutamate red pepper.	630
10503	chili sauce red jalapeno chili	195
10504	egg yolks. distilled white vinegar	2125
10505	sugar and lemon juice concentrate.	170
10506	White sesame seeds.	266
10507	Black soy beans	2126
10508	chestnuts	2127
10509	tangles	2128
10510	natural flavor of garlic	4
10511	natural flavor of capsicum	195
10512	sodium benzoate preservatives	354
10513	artificial and natural flavors soybean oil	243
10514	calcium disodium edta retains product freshness. spices	843
10515	Shaved bonito	1674
10516	Coconut milk	2129
10517	carboxy methyl cellulose	1330
10518	sodium metabisulphite preservative	2130
10519	Fish paste threadfin bream fish	2131
10520	tetra sodium pyrophosphate	518
10521	natural and artificial flavor crab extract monosodium glutamate	630
10522	walic acid	345
10523	disodium ribonucleorice	1002
10524	Rice vinegar water and rice	2132
10657	4-hydroxy-2	186
10525	diluted with water to 4.5% acidity 45 grain.	73
10526	sea slat	98
10527	diluted with water to 3.0% acidity 30 grain	200
10528	ginseng.	1426
10529	Kimchi chinese cabbage	2133
10530	fish extract	2134
10531	glutinous rice flour	2135
10532	turnip greens	1392
10533	wasabi japanese horseradish	2091
10534	and sulfer dioxide.	306
10535	Oyster extract water	1680
10536	oyster	2136
10537	soy sauce extract water	39
10538	fish paste crustacean shellfi	2137
10539	licorice root.	1507
10540	plum juice concentrate	2074
10541	sidium benzoate preservative	354
10542	fd & c red no.'s 3 and 40	677
10543	fd & c blue no.1.	2138
10544	momosodium glutanate	630
10545	vegetable extraxt onion & napa cabbage	2139
10546	hydrolyzed protein soy	276
10547	kelp exteact	2140
10548	and fd&c red #40.	677
10549	water and glucono delta lactone.	5
10550	Partially milled brown rice and water.	305
10551	artificial butter	2141
10552	vanilla flavoring	20
10553	turmeric extract.	175
10554	horse radish	2142
10555	japanese mustard plant	2143
10556	Sliced ginger	28
10557	aspartame contains phenylalanine	1251
10558	White sesame seed	1967
10559	glycine	2144
10560	methionine	2145
10561	green laver	2146
10562	starchsweet potato	139
10563	dried bonito	2147
10564	hydrolyzed proteinyeast	2148
10565	Bamboo shoots and water.	1483
10566	Green pea	1452
10567	vegetable oil palm/coconut/sunflower	26
10568	yeast extract powder	209
10569	artificial coloring	648
10570	Ingredients: modified cornstarch	263
10571	beef flavor	1307
10572	chicken flavor chicken	1278
10573	chicken skin	1650
10574	soy sauce powder soy sauce water	39
10575	hydrolyzed vegetable protein hydrolyz	267
10576	wasabi powder horse radish powder	212
10577	fd&c yellow no.5 sly lecthin	403
10578	fd&c blue no 1	2149
10579	Glutinous rice flour peanut soy sauce water soynean wheat salt seaweed sugar	2150
10580	alaska pollack	2151
10581	beet red	174
10582	cochineal extract.	673
10583	Straw mushrooms	2152
10584	water and salt.	178
10585	egg white powder and mineral salt.	2153
10586	cooking wine water	5
10587	beta carottene	590
10588	Granulated sugar	170
10589	glucose syrup cornstarch	315
10590	bean paste kidney beans	2154
10591	maltose	176
10592	glucose rice powder	315
10593	hydhocehated glucose syrup	315
10594	trhalose	1099
10595	sorunol	1099
10596	concentrated fruit juice strawberry	1233
10597	glyceryl-lacto esters of fatty acids	729
10598	artificial falavor	643
10599	red no.3	849
10600	fdc&c blue no.1	2155
10601	fd&c yellow no	403
10602	6	1
10603	sorbic acid and sodium meta-bisulfite preservatives	854
10604	vegetable oils soybeans	243
10605	sherry	947
10606	skim milk solids	777
10607	wasabi essence	2091
10608	sodium copper chlorophyllin	2156
10609	roasted brown rice.	305
10610	Oolong tea	2110
10611	jasmine tea jasmine scented green tea	501
10612	jasmine flower	2111
10613	Noodles: enriched wheat flourflour	131
10614	sodium benzoate added to retard spoilage soup base: rendered pork fat	354
10615	pork extract pork extract	2157
10616	rendered pork oil	719
10617	bonito powder	1674
10618	and garlic powder dried vegetables: dried green onion	4
10619	dried seaweed.	2106
10620	Red bean jam sugar	1
10621	rice powder	138
10622	trehalose	2158
10623	sweet cooking rice wine glutinous rice	2113
10624	malted rice	197
10625	vegetable oil soybean and rapeseed	243
10626	baking powder sodium bi	258
10627	Chestnut jam sugar	1
10628	sweetened chestnut {chestnut	2127
10629	water}	5
10630	sweet cooking rice	2114
10631	baking	17
10632	elderberry color	350
10633	palm olein	201
10634	soy sauce soybean	256
10635	seasoning hydrolyzed soy protein	276
10636	Ingredients: wheat flour	131
10637	coconut power	2159
10638	palm oil shorting	201
10639	leavining agents ammonium hydrogen carbonate	634
10640	treatment agentsodium metabisufite	2066
10641	soy letchin	276
10642	colorcaramel.	357
10643	Roasted green tea.	501
10644	Noodles: enriched wheat flour flour	784
10645	corn oil or canola oil	833
10646	fd&c yellow #5. sauce: vinegar	403
10647	high fructo	344
10648	fd&c yellow no.6	403
10649	trisodium citrate.	200
10650	soy-beans	256
10651	wasabi powder dextrin	678
10652	arabic gum	390
10653	fd&c yellow no. 5 and fd&c blue no. 1.	2160
10654	garlic essence soybean oil	1934
10655	ethyl maltol	2161
10656	2-methylpyrazine	2162
10658	5-dimethyl-3 2h furanone	20
10659	2-ethyl-3-methylpyrazine	2163
10660	3-methylthio	2164
10661	propionaldehyde	2165
10662	dextrin.	678
10663	water salt	148
10664	sodium benzoate added to retard spoilage dusted with cornstarch.	354
10665	and sodium benzoate added to retard spoilage	354
10666	dusted with corn starch.	263
10667	dried yolk powder	2166
10668	shaved bonito and seaweed.	1674
10669	and fd&c red no. 40.	677
10670	sodium benzoate to retard spoilage	454
10671	natural flavor soup base: salt	148
10672	white pepper powder	12
10673	mushroom powder	1920
10674	caramel powder	452
10675	hydrolyzed vegetable protein	267
10676	disochum inosinate and artificial flavor dried vegetables : dried green onion	2167
10677	natural flavor. soup base: salt	316
10678	leek chips	558
10679	soy sauce powder soybeans	142
10680	seaweed powder	1034
10681	malfodextrin	197
10682	dries lesks	2168
10683	disodium insinate	2169
10684	silicon dioxide to make free flowomg dried vegetables: dried green onions	309
10685	Enriched wheat flavor	143
10686	nicene	817
10687	maltodextrinmaltodextrin	197
10688	beef powder	2170
10689	non daily creamer	2171
10690	Starch syrup	139
10691	oblate powder potato	2172
10692	d-sorbitol	1099
10693	acidulant citric acid	200
10694	emulsifier glycerol esters of fatty acids	2173
10695	lecithin soybean	185
10696	col	459
10697	concentrated lychee juice	665
10698	starch powder potato	519
10699	emulsifiers polyglycerol esters of fatty acids	762
10700	enzyme-modified lecithin soybeans.	185
10701	Ingredients : glucose syrup	315
10702	concentrated peach juice	499
10703	enzyme-modified lecithin soybeans	185
10704	fd &c red no. 40.	677
10705	enzyme modified lecithin soybeans	185
10706	fd&c red no.40.	677
10707	riboflavin and folic acid salt and water.	2174
10708	Soy sauce salt	148
10709	defatted soybeans	256
10710	soybean paste water	2175
10711	lactobacillus	535
10712	seed malt	204
10713	capsicum oleoresin.	725
10714	yam flour and hydrated lime.	1626
10715	Sweet corn	134
10716	salt soy	148
10717	sauce powder soy sauce water. soybeans	39
10718	maltdextrin	197
10719	onion powder modified cornstarch	561
10720	hydrolyzed vegetable protein hydrolyzed corn gluten	1292
10721	soy protei	276
10722	hydrogenated soybean and cottonseed oil	243
10723	salt. natural flavor	148
10724	torula yeast extract	209
10725	sesame oil green onion. sesame seeds. natural smoke flavor.	112
10726	sherry wine powder maltodextrin	197
10727	leek powder	558
10728	sesame oil lemon juice powder.	112
10729	medified cornstarch	561
10730	whey extract	193
10731	wheat proten	326
10732	soyprotein	276
10733	autolyzed yeat extract	209
10734	hydrogenated soybean and cottanseed oil	243
10735	modified crnstarch	561
10736	sunfites	397
10737	Ingredients: milled rice	64
10738	soybean and sesame oils	243
10739	fd & c red no. 3	849
10740	fd & c red no. 40	677
10741	calcium disodium edta retains product freshness and fd & c blue no.1.	2155
10742	glycerol esters of fatty acids	2173
10743	waxy com starch	2176
10744	red pepper extract.	759
10745	apricots with pulp and juice	275
10746	calcium disodium edta retains product freshness.	843
10747	organic soy bean	256
10748	organic sweet rice wine organic shochu organic rice	64
10749	koji culture	1661
10750	organic sweet rice	2114
10751	organic rice.	64
10752	aloe vera gel 20%	2177
10753	natural white grape flavor	2178
10754	cochineal extract	673
10755	leavening agents sodium bicarbonate	24
10756	Strawberry filling: sugar	1
10757	palm shortening	201
10758	demineralized whey powder	193
10759	polyglycerol esters or fatty acids	2179
10760	cone: unbleached wheat flour	131
10761	sugar syrup brown sugar	13
10762	Chocolate filling: sugar	1
10763	maltodextrin. cone: unbleached wheat flour	197
10764	sodium metabisulphite preservative.	2130
10765	Enriched what flour flour	816
10766	natural flavor. soup base	316
10767	monosodium	594
10768	glutamate	708
10769	turmeric powder	280
10770	disodium inosinate disodium guanylate.	630
10771	lactic acid and sodium benzoate added to retard spoilage. soup base: salt	148
10772	natural shrimp powder	86
10773	disodium inosinate. sodium gualylate and sodium carbonate.	2180
10774	mono-sodium glutamate	630
10775	fish stock powder salt	148
10776	bonito extract	2181
10777	malt dextrin	197
10778	dried leeks	2168
10779	silicone dioxide.	309
10780	Yam flavor hydrated lime and seaweed powder.	85
10781	Threadfin bream fish	2182
10782	sharing ;from palm oil	201
10783	sweet flavouring glucose syrup	315
10784	yeast exeact	294
10785	caramal	452
10786	fi	8
10787	garlic and onion poedwr	45
10788	fd&c yellow #6	403
10789	fd	2183
10790	fd&c yellow #5 and fd&c blue #1.	2160
10791	natural and artificial flavors+	895
10792	pyridoxine hydroch	525
10793	gelatin artificial and natural flavor	459
10794	di	2184
10795	100% natural rolled oats.	78
10796	100% rolled oats.	78
10797	mixed tocopherols added to preserve freshness color annatto extract	154
10798	niac	466
10799	pecorino romano cheese pasteurized sheep's milk	1727
10800	Cultured pasteurized light cream	473
10801	Cultured pasteurized grade a milk and nonfat milk solids. contains active yogurt cultures including l. bulgaricus	7
10802	s. thermophilus	1389
10803	bifidobacterium bb-12	2185
10804	l. acidophilus and l. casei.	867
10805	Cultured pasteurized grade a non-fat milk	7
10806	black cherry juice concentrate for color	237
10807	live and active cultures s. thermophilus	1389
10808	l. casei.	1998
10809	live and active cultures s.thermophilus	1389
10810	l. case	295
10811	Cultured pasteurized grade a non-fat milk; live and active cultures s. thermophilus	7
10812	fruit juice concentrate for color	1770
10813	l casei.	1998
10814	live and active cultures s. thermophillus	1389
10815	American cheese milk	7
10816	pineapple juice from concentrate and ascorbic acid vitamin c to protect color.	650
10817	Raisins a fat	67
10818	cholesterol and gluten free food.	2186
10819	potassium sorbate added as a preservative.	338
10820	Roasted peanuts and peanut oil	741
10821	hydrogenated rapeseed and cottonseed oils	187
10822	hydrogenated rapeseed and cottonseed oil	187
10823	concentrated pear juice	284
10824	yellow 5 and yellow 6.	786
10825	lemon juice water	18
10826	calcium disodium edta added to protect product quality.	455
10827	potassium sorbate and sodium benzoate pr	803
10828	and red pepper	195
10829	green bell peppers.	836
10830	and extractives of paprika color.	934
10831	Enriched wheat flour flour enriched with niacin	784
10832	and potassium bromate	1933
10833	torula yea	1557
10834	spices including paprika for spice and color	55
10835	and oregano	42
10836	and silicon dioxide.	309
10837	Chili powder roasted cayenne pepper	69
10838	and silicon dioxide	309
10839	natural lemon flavor with other natural flavors	29
10840	artificial color fd&c red #40.	677
10841	Milkfat and nonfat milk	7
10842	artificia	643
10843	cookies sugar	1
10844	what	5
10845	corn sy	134
10846	orange puree concentrated orange juice	65
10847	lime puree concentrated lime juice	61
10848	guar gu	475
10849	soy l	394
10850	ethoxylated mono	2187
10851	pasteurized skim milk	472
10852	locust bean gum & guar gum stabilizers.	475
10853	Decaffeinated black tea	365
10854	Decaffeinated green tea	501
10855	Ingredients: Black Tea	365
10856	Fine black tea	365
10857	natural lemon flavor with other natural flavors.	29
10858	natural flavors wheat	143
10859	rosehip	1767
10860	beetroot	174
10861	peach	444
10862	mannitol wheat	739
10863	White hibiscus	434
10864	pineapple flavor	2188
10865	grapefruit flavor	2189
10866	grapefruit peel	2190
10867	vitamin b7biotin	492
10868	beef flavor beef stock	1930
10869	enzyme modified che	38
10870	and vanillin artificial flavor	186
10871	water. contains less than 2% of whey	5
10872	potassium sorbate and calcium disodium edta preservative	338
10873	natural and artificial maple flavors	2191
10874	yucca extract.	2192
10875	yellow #6 and red #40.	2193
10876	and neotame.	979
10877	baking powder	17
10878	sodium benzoate as a preservative and natural flavor.	454
10879	Enriched long grain rice niacin	466
10880	dehydrated vegetables garlic	4
10881	vegetable oil soybean oi	243
10882	fruit juice concentrate apple grape	373
10883	ascorbic acid v	329
10884	soybean oil and/or palm oil	2194
10885	soy lecithin e	185
10886	natural smoked flavor	1558
10887	natural brown sugar flavor	13
10888	Mango.	190
10889	contains less than 2% of soy lecithin	185
10890	sodium benzoate a preservative	454
10891	tetrasodium pyrophosphate.	879
10892	oat extrac	1465
10893	vegetable shortening contains one or more of the following: palm oil and/or soybean oil with emulsifier propylene glycol	2195
10894	mono and dieste	630
10895	vegetable shortening contains one or more of the following: palm oil and/or soybean oil with emulsifier propylene glycol mono a	2196
10896	Prunes with potassium sorbate as a preservative.	338
10897	natural cheddar flavor skim milk cheese	32
10898	whey pro	193
10899	palm and/or palm kernel and/or partially hydrogenated palm kernel oil+	201
10900	thiamin mononitrate {vitamin b1}	1085
10901	contains two percent or l	2197
10902	dehydrated chopped garlic	4
10903	tomato puree and less than 2% of: diced jalapeno peppers	487
10904	ground chipotle peppers	1363
10905	citric acid and calcium chloride	620
10906	sunflower oil and/or corn oil	1793
10907	natural flavors autolyzed yeast extrac	209
10908	corn oil and/or sunflower oil	26
10909	Whole corn	134
10910	barley malt extra	635
10911	blue corn	838
10912	artificial color red 40.	677
10913	white cheddar seasoning whey	193
10914	parmesan cheese cultured cow's milk	62
10915	citric	200
10916	Prepared white beans water	5
10917	contains 2% or less: cornstarch modified	561
10918	maple cured bacon cured with water	50
10919	maple flavor	2191
10920	cornstarch modified	561
10921	turmeri	383
10922	natural spices	834
10923	natural casing pork and/or lamb.	2019
10924	cheddar cultured milk	32
10925	colored with apo carotenal	2198
10926	potassium sorbate and natamycin preservatives	2014
10927	contains less than 2% of the following; salt	140
10928	sodium erythorbate spice extractives	363
10929	natural casing	2019
10930	natural casin	640
10931	contains 2% or less of: whey cellulose gum	193
10932	soy flo	142
10933	100% pure and natural orange juice.	65
10934	brewed tea concentrate	851
10935	tea essence	2199
10936	Pasteurized ruby red grapefruit juice.	553
10937	vitamin a palmi	562
10938	contains 2% or less of: leavening calcium phosphat	381
10939	honey roasted sesame sticks unbleached wheat flour contains malted barley flour as a natural enzyme additive	131
10940	honey coating sucrose	170
10941	tack blend maltodextrin	197
10942	Pasteurised cream	473
10943	m & m's milk chocolate candies milk chocolate sugar	461
10944	less than 1% - corn syrup	596
10945	less than 2% of the following: calcium carbonate	328
10946	natural flavor with other natural flavors	316
10947	color ad	2200
10948	less than 2% of: calcium carbonate	328
10949	color added including yellow 5 and yellow 6.	1485
10950	pimientos	195
10951	potassium sorbate and so	338
10952	baking powder corn starch	263
10953	monocalcium p	203
10954	mono-calcium	203
10955	stabilizing agent	578
10956	emulsifying agent	185
10957	no flavoring agent and no preservative added.	170
10958	contains 1% or less of the following: maltodextrin	197
10959	smoked torula yeast	1557
10960	dried corn syrup	2031
10961	Pasteurized milk & cream	7
10962	egg liquid & hydrogenated soybean &/or cottonseed oil	243
10963	pecans &/or walnuts	146
10964	cocoa processed with	118
10965	liquid & hydrogenated soybean &/or cottonseed oil	243
10966	carrot extract color.	1339
10967	Cheese sauce: cheddar cheese sauce cheddar cheese milk	32
10968	color oleoresin pa	195
10969	Enriched macaroni product: enriched semolina semolina wheat flour	451
10970	cheese sauce mix: cheddar cheese sauce cheddar cheese milk	32
10971	Enriched macaroni product: durum semolina flour enriched with iron {ferrous sulfate}	251
10972	cheese sauce: cheddar cheese sauce cheddar cheese {milk	32
10973	toasted oats whole grain rolled oats.	78
10974	high maltose corn syrup	176
10975	wheat flakes whole wheat	143
10976	fractionated palm kern	286
10977	vanilla yogurt coating sugar	1
10978	rolled oat clusters whole grain rolled oats	78
10979	brown suga	13
10980	high fructose corn	344
10981	gum cellulose gum	600
10982	and annatto vegetable color.	722
10983	Wrapper: enriched flour wheat flour	131
10984	caking powder corn starch	263
10985	sodium alum	2201
10986	red raspberries.	208
10987	milk1	7
10988	contains less than 1% of: artificial color2	648
10989	mono and diglycerides1	341
10990	natural and artificial flavors2	196
10991	oat fiber.	601
10992	Enriched semolina iron ferrous sulfate and b vitamins niacin	251
10993	flaxseed.	207
10994	vegetable oil contains one or more of the following: can	26
10995	semisweet chocolate chunks sugar	1
10996	dext	750
10997	high fruc	344
10998	Bread crumbs enriched flour wheat flour	131
10999	folic acid high fructose corn syrup	2202
11000	contains 2% or less of each of the following: partially hydrogenated vegetable oil soybean and/or cottonseed oil	881
11001	colo	2203
11002	mixed tocopherols added to preservative freshness	154
11003	mixed tocopherols added to preserve freshness. vitamins ans mine	1612
11004	Refined coconut oil.	135
11005	Virgin coconut oil.	135
11006	contains 2% or less of: iron ferric orthophosphate	251
11007	vitamin b2 riboflavin.	818
11008	less than 2% of whey	193
11009	potassium sorbate and carbon dioxide preservatives. phosphoric acid	2204
11010	contains 2% or less of whey	193
11011	sodium phosphate sodium tripolyphosphate	194
11012	potassium sorbate p	338
11013	Chicken broth water	5
11014	chicken flavor concentrate chicken stock	97
11015	contains less than 1% of: sea salt	98
11016	cane sugar. gluten free.	170
11017	cheese sea	640
11018	100% whole wheat durum flour.	283
11019	f.d. & c. red #40	677
11020	toasted sweetened coconut coconut	68
11021	sugar dextrose	750
11022	contains less than 1% of the following: salt	140
11023	benzyl benzoate	2205
11024	propylene glycol.	616
11025	artifi	549
11026	chocolate fudge ribbon corn syrup	596
11027	brownies sugar	1
11028	interseted soybean	256
11029	flavor base {sweetened condensed whole milk whole milk	891
11030	sea salt caramel swirl {sugar	1
11031	sweetened condensed skim milk co	523
11032	vegetable oil palm and/or soybean oil	26
11033	contains less than 2% of the following: nonfat milk	7
11034	dairy whey	193
11035	-modified	778
11036	contains less than 2% of the following: lemon juice solids	18
11037	whole wheat/graham flour	283
11038	molas	156
11039	Ice cream milk	7
11040	caramel ribbon {sugar	452
11041	pectin}	337
11042	flavor base {sweetened condensed whole milk condensed	2206
11043	flavor base {sweetened condensed whole milk condensed whole milk	2206
11044	sweetened condensed skim mi	942
11045	contains 2% or less of cocoa processed with alkali	118
11046	high fructose corm syrup	344
11047	cellulose g	740
11048	malt cereal syrup	1360
11049	oleores	1571
11050	bht a preservative. vitamins and minerals: redu	721
11051	cocoa processed with alk	118
11052	vitamin b2 riboflavin a b	818
11053	vitamin e mixed tocopherols added to preserve freshness. vitamins and minerals: calcium	169
11054	oat fiber tripotassium phosphate	2207
11055	preservative tocopherols	154
11056	color annatto extract. vitamin and minerals: vitamin c sodium ascorbate	722
11057	contains 2% or less of the foll	834
11058	Durum flour wheat	1968
11059	Crust: enriched wheat flour wheat flour	131
11060	contains less than 2% of wheat gluten	955
11061	soybean and/or corn oil	2061
11062	Crust enriched wheat flour wheat flour	131
11063	benzoyl peroxide bleaching agent	2095
11064	palm and modified palm oil	201
11065	shortening	80
11066	Crust	2208
11067	palm and modified palm oil shortening	201
11068	red papaya	1334
11069	yellow papaya	1334
11070	passion fruit juice	1618
11071	peach pulp and juice	444
11072	pineapple juice and citric acid.	200
11073	Enriched egg noodles semolina wheat flour	451
11074	partially hydrogenated vegetable shortening contain	881
11075	caramel color sulfur dioxide	306
11076	disodium gua	477
11077	color yellow 6	794
11078	Concentrated organic juice	1732
11079	ascorbic aci	329
11080	partially hydrogenated lard with bha and bht added to protect flavor	2209
11081	fd&c blue #1 and sulfur dioxide preservative.	852
11082	natural flavors. polysorbate 80	613
11083	cin	419
11084	sodium benzoate and sorbic acid preservatives.	1312
11085	Semolina wheat flour	451
11086	Cocoa.	118
11087	beef fat & broth	1338
11088	Enriched bleached wheat flour niacin	131
11089	sodium metabisulfite added to retain color	426
11090	Large lima beans.	1422
11091	Red kidney beans.	1602
11092	Medium grain white rice	2210
11093	thiamine thiamine mononitrate	468
11094	Long grain white rice	1057
11095	iron ferric orthophosphate and folic acid folate.	2211
11096	sorbic acid a preservat	854
11097	contains less than 2% of the following: salt potassium lactate	1068
11098	oats. contains 2% or less of each of the following: vegetable o	78
11099	and distilled acetylated monoglycerides dispersed in dextrose	938
11100	titanium dioxide artificial color	369
11101	contains less than 2% of whey	193
11102	natural and artifi	2212
11103	contains less than 2% of cream	473
11104	contains less than 2% of sweetcream buttermilk	72
11105	polysorb	2213
11106	contains less than 2% of guar gum	475
11107	yellow 5 & 6.	786
11108	contains less than 0.5% of: mono and diglycerides	341
11109	contains less than 0.5% of: sodium citrate	477
11110	calcium propionate added to maintain freshness	911
11111	a trace of lime.	200
11112	monocalciu	203
11113	whole grain whole wheat flour	283
11114	contains 2% or less of each of t	834
11115	sweetcream buttermilk	72
11116	contains less than 2% of mono and diglycerides	341
11117	fudge ripple corn syrup	596
11118	orange juice concentrate.	65
11119	enzymes and annatto vegetable color.	722
11120	red and green jalapeno peppers	1160
11121	cheese culture.	1106
11122	salt and enzymes	192
11123	anticaking agent potato starch	519
11124	powdered cellulose and natamycin natural mold inhi	740
11125	potassium sorbate a preservative and locust bean gum.	338
11126	Grade a cream	473
11127	french onion seasoning dehydrated onion	9
11128	hydrolyzed vegetable protein corn	267
11129	silicon dioxide added to help prevent caking	309
11130	and dehydrated garlic	4
11131	less than 2%: nonfat milk	7
11251	wakame seaweed	2099
11132	contains less than 2% of the following: dextrose	750
11133	extra	2214
11134	powdered cellulose and natamycin natural mold inhibitor.	740
11135	beta carotene color vitamin a palmitate added	478
11136	salt contains less than 2% of vegetable mono & diglycerides	140
11137	propylene glycol monosterate	937
11138	natural & artficial flavors	2215
11139	contains less than 2% of hydrogenated cottonseed oil	2216
11140	calcium disodium edta added t	843
11141	Beef tenderloin	33
11142	less than 2% of salt	140
11143	natural flavors including mesquite smoke	268
11144	sodium phosphates. bacon cured with: water	570
11145	bread crumbs unbleached wheat flour	131
11146	cottonseed oil and/or soybean oil	243
11147	wheat flour. contains 2% or less of: enriched wheat flour wheat flour enriched with niacin	131
11148	ri	2217
11149	contains 2% or less of: enriched wheat flour wheat flour enriched with niacin	131
11150	sugar leavening sodium acid pyrophosphate	1
11151	wheat flour. contains 2% or less of: wheat flour enriched with niacin	131
11152	sodium tripolyphosphate to retain fish moisture.	820
11153	Flounder fish	812
11154	vegetable oil cottonseed and/or canola	26
11155	and/or soybean with tbhq and citric acid as preservatives	2218
11156	Ingredients: haddock fish	2219
11157	sodium tripolyphosphate to retain fish moisture	820
11158	contains 2% or less of: wheat flour enriched with niacin	131
11159	wheat flour enriched with niacin	131
11160	soybean oil. contains 2% or less of: beer water	243
11161	hop extract	2220
11162	Tilapia fish	814
11163	wheat flour enr	131
11164	Alaska pollock fish	1849
11165	ferrous suflate	251
11166	Salmon fish	808
11167	breading bleached wheat flour	131
11168	flour predust bleached wheat flour	131
11169	batter mix wheat flour	131
11170	batter mix white corn flour	165
11171	Cod fish	2039
11172	batter mix yellow corn flour	165
11173	breading enriched flour wheat flour	131
11174	dehydrated portobello mushrooms	1826
11175	extractive of paprika color	934
11176	and ascorbic acid	329
11177	batter mix enriched wheat flour enriched with niacin	784
11178	dried whole eggs	1686
11179	dry soy lecithin	185
11180	roasted dehydrated garlic	4
11181	modified butter oil and dehydrated butter	311
11182	fish	2221
11183	extractives of turmeric and annatto	1091
11184	Crab meat	815
11185	imitation crab meat pollock	896
11186	cod and/or pacific whiting	2222
11187	natural and artificial flavors soy	142
11188	potassium tripolyphosphate	2223
11189	modified salt	140
11190	stabilizers carob bean and/or xanthan guar gums	265
11191	cane juice molasses	156
11192	hydrolyzed soy and corn proteins	2224
11193	sodium inosinate	2169
11194	black and cayenne pepper	12
11195	sodium benzoate and potassium sorbate as preservatives. `	454
11196	Clams sodium tripolyphosphate to retain clam moisture	820
11197	sea slam juice	98
11198	leavening {sodium bicarbonate }	24
11199	ranch seasoning {onion powder	121
11200	bread crumbs enriched bleached wheat flour wheat flour	131
11201	Cane sugar.	170
11202	Cane sugar artificial flavor	170
11203	red 3.	849
11204	White diamond ingredients: cane sugar. amber ingredients: can sugar	170
11205	artificial flavor. added color: titanium dioxide	637
11206	added color red 5	677
11207	added color red 3	849
11208	and less than 2% of the following: dried apples	738
11209	natural flavors contains maltodextrin milk	197
11210	collagen casings.	1853
11211	calcium chloride for firmness.	340
11212	salt for flavor.	140
11213	water salt for flavor.	148
11214	anise	2225
11215	vegetables onions	9
11216	oregano extract.	42
11217	red chili puree	195
11218	dehydrated bell pepper	536
11219	tomato juice salt	148
11220	dehydrated green chili peppers	1285
11221	Chopped broccoli.	116
11222	salt processing aid.	140
11223	Peas.	132
11224	Collard greens.	1500
11225	Cooked field peas	2226
11226	snaps	1370
11227	Broccoli and cauliflower.	2227
11228	thiamin mononitrate vitamin b 1	1085
11229	eggs. contains 2% or less of: sugar	3
11230	thiamin hydrochloride vitamin b1.	1085
11231	mango puree mango puree	1226
11232	contains 2% or less	401
11233	leavening sodium aluminum	864
11234	tamari water	5
11235	brewing starter aspergillus oryzae	278
11236	sesame seeds.	266
11237	seaweed nori.	2146
11238	Whole grain brown rice sesame seeds.	266
11239	whole grain black rice	303
11240	expeller-pressed palm oil	201
11241	wheat-free taman water	2228
11242	miso soybeans	256
11243	cultured rice	64
11244	koji sea salt	98
11245	wheat-free tamari water	5
11246	crushed red pepper	1152
11247	Freeze-dried miso water	1469
11248	soybean powder	276
11249	salt roasted soybean powder	256
11250	koji culture aspergillus oryzae	1470
11252	green onion.	870
11253	roasted soybean powder	276
11254	colors red 40 lake	1974
11255	blue 2 lake.	977
11256	red miso soybeans	277
11257	cultured rice koji	1660
11258	chili puree	2229
11259	umeboshi plum	2230
11260	shiitake mushrooms	869
11261	clov	94
11262	blue 2 lake. smarties contain none of the following: gluten from wheat	977
11263	oats and rye	2231
11264	crustacean shellfish	2232
11265	tree nuts	146
11266	peanuts or soybeans.	137
11267	Dextrose contains maltodextrin	750
11268	Grated horseradish roots	212
11269	sodium metabisulfite retains product color	1289
11270	titanium dioxide retains product color	369
11271	Ground horseradish roots	212
11272	sodium metabisulfite retai	2066
11273	#1 grade mustard seed	1138
11274	water no. 1 grade mustard seed	1138
11275	ground jalapeno peppers	195
11276	papprika	836
11277	lea & perrins worcestershire sauce	54
11278	extracti	269
11279	sweet red pepper	536
11280	sweet yellow pepper	2233
11281	louisiana cane vinegar	480
11282	tabasco brand pepper sauce distilled vinegar	73
11283	tabasco brand chipotle sauce chipotle pepper	1363
11284	tabasco brand pepper pulp distilled vinegar	73
11285	chipotle puree chipotle pepper	195
11286	natural oleoresin paprika	55
11287	Red cayenne pepper	195
11288	aged pepper mash red peppers	2234
11289	salt tabasco brand pepper sauce distilled vinegar	140
11290	citric acid "to retard spoilage." tabasco brand green pepper sauce distilled vinegar	200
11291	ascorbic acid "to preserve freshness".	329
11292	tamarind puree	453
11293	tabasco pepper mash	2235
11294	aged red	2236
11295	pear concentrate	2237
11296	xanthan gum and spices.	265
11297	garlic water	1261
11298	sea-salt and alcohol	148
11299	japanese sweet cooking rice wine mirin	1551
11300	and sodium benzoate: less than 1/10 of 1% as a preservativ	354
11301	cured anchovies	1270
11302	tamarinds	453
11303	sugar and natural flavoring.	170
11304	crushed orange	103
11305	dehydrated orange peel powder	366
11306	dehydrated garlic powder	4
11307	dehydrated onio	699
11308	Cane sugar vinegar	1
11309	dehydrated onion powder	9
11310	sea-salt	148
11311	and alcohol	384
11312	sodium benzoate: less than 1/10 of 1% as a preservative.	354
11313	ascorbic acid "to preserve freshness."	329
11314	Tomato concentrate water and tomato paste	240
11315	horseradish powder.	212
11316	calcium chloride "a firming agent	340
11317	alum. onions	612
11318	mustered seed	1138
11319	red raspberries including  potassium sorbate	208
11320	dehydrated strawberry juice	1233
11321	u.s. certified food colors including yellow #5	403
11322	red #3 and red #40.	677
11323	u.s. certified food colors including yellow #5 and #6	786
11324	Washburn old fashioned hard candy: sugar	170
11325	u.s. certified colors including yellow #5 and #6	786
11326	certified colors including yellow #5 and #6	786
11327	blue #3	2238
11328	us certified food colors including yellow #5 & #6	786
11329	red #3 & red #40.	677
11330	Ingredients: concord grape juice water and concord grape juice concentrate	2239
11331	corn syrup high fructose corn syrup	344
11332	Ingredients: strawberry juice	448
11333	Ingredients: concord grape juice	150
11334	Ingredients: concord grape puree grape puree concentrate and water	1526
11335	Ingredients: red raspberries	208
11336	Ingredients: strawberries	448
11337	Ingredients: blackberries	658
11338	apricot puree concentrate	2240
11339	orange juice water and orange juice concentrate	65
11340	potassium sorbate and calc	338
11341	Freshly roasted peanuts	137
11342	contains 2% or less of: hydrogenated vegetable oil rapeseed	187
11343	salt. molasses.	156
11344	Ingredients: pure honey	36
11345	salty	140
11346	bht to preserve freshness. vitamins & minerals: vitamin ba thiamin mononitrtae	721
11347	vitamin b2 riboflavin pyridoxine hydrochloride	818
11348	zinc oxide.	1585
11349	chocolate fudge powdered sugar sugar	1
11350	peanut butter cups sugar	1
11351	Milkfat and nonfat milk corn syrup	7
11352	natural and artificial flavor annatto and tumeric extracts colors.	2241
11353	pecans pecans	49
11354	cocoaprocessed with alkali	118
11355	xantyhan gum	265
11356	butter fudge syrup corn syrup	596
11357	high fructose fructose corn syrup	344
11358	brownie fudge pieces powdered sugar sugar	1
11359	partially hydrogenated nonfat milk	7
11360	vegetable shortening contains one or more of the following: soybean oil	243
11361	contains less than 2% of strawberry puree	1879
11362	peanut butter syrup peanut butter	123
11363	chocolate chip cookies dough cookie dough wheat flour	131
11364	brown sugar sugar	170
11365	baking soda}	258
11366	and vanillin an artificial flavoring	186
11367	cherries cherries	189
11368	fruit and vegetable concentrates blueberry	411
11369	plum	1496
11370	cherry and carrot juice concentrates for color	1740
11371	chocolate swirl powdered sugar sugar	1
11372	cake pieces sugar	1
11373	margarine liquid soybean oil	243
11374	unbleached wheat flour	131
11375	sugared egg yolk	796
11376	black cherry ribbon sugar	170
11377	raspberry juice from concentrate filtered water	961
11378	fumaric ac	421
11379	flavored and colored fruit pieces dehydrated apples treated with sodium sulfite to promote color retention	1075
11380	artificial strawberry flavor	1640
11381	citric acid red 40	200
11382	creaming agent corn syrup solis	596
11383	ferric phosphate a source of iron	251
11384	artificial peach flavor	2002
11385	creaming agent corn syrup solids	596
11386	corn starch and calcium sulfate added to prevent caking	263
11387	natural mold inhibitor.	338
11388	vanilla bean seeds	20
11389	stabilizer mono- and diglycerides	729
11390	natural butter pecan flavor	2242
11391	chocolate flakes sugar	1
11392	carrageenan guar gum	475
11393	peppermint extract peppermint flavor and color yellow 5 and blue 1	2243
11394	green color yellow 5	976
11395	blueberry fruit blueberries	411
11396	agar gum. locust bean gum	342
11397	natural blueberry flavor citric acid	200
11398	triacetin	2244
11399	cream sugar	1
11400	fudge sauce peanuts oil	173
11401	and soy lecithin	185
11402	brownie pieces wheat flour	131
11403	100% fruit juice from grape	150
11404	and apple filtered water	5
11405	juice concentrates	163
11406	100% fruit juice from grape and concord grape	150
11407	and cranberry filtered water	5
11408	and raspberry filtered water	208
11409	yellow 5 and yellow 6	1485
11410	White rice flour	138
11411	cheese cheddar and romano pasteurized milk	38
11412	butter-milk powder	1180
11413	sodium caseinate from milk butter.	640
11414	disodium edta.	455
11415	two percent or less of the following: canola oil	90
11416	yeast vinegar	73
11417	l-cysteine dough conditioner	951
11418	cheese whole milk mozzarella cheese pasteurized milk	7
11419	parmesan and romano cheese blend both made from pasteurized cow's milk	1086
11420	natural flavoring sugar	1
11421	canadian bacon pork cured with water	534
11422	two percent or less of the following: sodium lactate	1097
11423	bacon pork cured with water	534
11424	green peppers.	195
11425	salt and ferrous gluconate added to stabilize color.	140
11426	Spanish manzanilla olives	1901
11427	calcium chloride and potassium sorbate as preservative.	340
11428	Spanish queen olives	486
11429	calcium chloride and potassium sorbate as a preservative.	340
11430	and ferrous gluconate added to stabilize color.	2245
11431	potassium sorbate and sodium benoate added as preservative red # 40 and sulfur dioxide preservative.	306
11432	potassium sorbate and sodium benzoate added as preservative	803
11433	fd&c red #40 and sulfur dioxide preservative	677
11434	rebiana	1378
11435	artificial coloring fd&c red no. 40	677
11436	erythorbic acid for color retention.	775
11437	erythorbic acid to maintain color	775
11438	yellow no.5	403
11439	sodium citrate controls acidity. fumaric acid for tartness	200
11440	bha preservative	720
11441	bha preservative.	720
11442	mono and diglycerides prevent foaming	729
11443	monfat dry milk	801
11444	contains less than 2% of sour cream powder cultured sour cream	25
11445	poppyseeds	745
11446	vinegar distilled and cider	480
11447	contains 1% or less of onion powder	121
11448	contains less than 2% of lactic acid	295
11449	Cultured pasteurized grade a nonfat milk	7
11450	Cultured pasteurized grade a low fat milk	7
11451	leaving sodium acid pyrophosphate	780
11452	soybean oil. frank ingredients: mechanically separated chicken pork	243
11453	contains 2% or less of flavorings	196
11454	potassium sorbate and sodium benzoate preservative	803
11455	contains 2% or less of: king crab meat	2246
11456	and alaska pollock	1849
11457	disodium pyrophosphate	2247
11458	contains 2% or less of the following: vinegar	480
11459	chicken marinade salt	148
11460	chicken flavor contains maltodextrin	197
11461	salt and natural flavors	140
11462	natural flavors and spice	198
11463	chicken flavor chicken fat and natural flavor	1148
11464	natural flavoring. caramel color added.	2248
11465	shortening soybean oil and hydrogenated soybean oil contains 2% or less of leavening sodium bicarbonate	258
11466	l-cysteine monohydrochloride	951
11467	microcrystalline cellulose.	740
11468	pomegranate juice from concentrate	406
11469	contains less than 2% of raspberry juice concentrate	961
11470	yellow #6.	403
11471	contains less than 2% of citric acid	200
11472	vegetables oil cottonseed and/or canola and/or soybean	26
11473	dehydrates garlic	4
11474	dehydrates parsley.	22
11475	contains less than 2% of: citric acid	200
11476	dried red chile pepper	195
11477	dehydrated oregano	42
11478	natural garlic flavor	4
11617	artificial colors including fd&c yellow 6	795
11479	Ingredients: durum wheat semolina enriched with iron ferrous sulfate and b vitamins niacin	1280
11480	thiamin mononitrate.riboflavin	818
11481	yogurt powder cultured whey and non-fat milk	193
11482	contains 2% or less of: mono- and diglycerides	729
11483	vitamin b12. bht added to packaging material to help preserve freshness.	1191
11484	potassium sorbate as a preservative	338
11485	Farms fresh eggs	14
11486	Ingredients: pumpkin.	559
11487	Sunflower kernel roasted in peanut	151
11488	sunflower and/or cottonseed oil	147
11489	cellulose gum.	600
11490	dried toasted sliced onion	9
11491	dried chopped	2249
11492	egg. cooked in vegetable oil contains one or more of: corn oil	14
11493	sodium nitrite. predust ingredients: enriched wheat flour enriched with niacin	367
11494	distilled vinegar. less than 2% of: salt	73
11495	extra virgin olive oil vinegar	480
11496	sugar salt	140
11497	contains 2% or less of; lemon juice concentrate	18
11498	tbhq a preservative	1082
11499	propellant. adds a trivial amount of fat	135
11500	monosterate	2250
11501	cheese sauce mix	2251
11502	semifsoft cheese milk	7
11503	color turmeric oleorsin	383
11504	acetic acid esters of mono and diglycerides	2252
11505	calcium silicate.	1010
11506	canola and/or corn oil	2253
11507	natural flavor maltdextrin	197
11508	sodiu	594
11509	natural and aftificial flavor	316
11510	coloring.	2254
11511	Peanuts: roasted in peanut	137
11512	sunflower oil. almonds: roasted in peanut	147
11513	and vanilla.	20
11514	mustard oil.	1662
11515	Horseradish roots	212
11516	Ingredients: chicken breast meat with rib meat	57
11517	contains 2% or less of sea salt	98
11518	chicken flavor salt	148
11519	leavening baking soda and/or calcium phosphate	24
11520	high fru	344
11521	canola and/or soybean with tbhq for freshness and/or palm oil	2255
11522	contains two percent or less of: coc	118
11523	canola and/or soybean with tbhq added for freshness and/or palm oil	978
11524	contains 2% or less of: peppermint oil high fructose corn syrup	458
11525	salt vanilla	148
11526	dextrose cocoa butter	171
11527	contains 2% or less of: invert sugar	471
11528	molasses eggs	156
11529	canola and/or soy and/or palm oil	26
11530	contains 2% or less of:dextrose	315
11531	and soy lecithin an emulsifier.	185
11532	ipon	2256
11533	thiamine monontrate	468
11534	contains or less of eggs	3
11535	salt baking soda adds a travail amount of cholesterol .	140
11536	orange juice pulp	65
11537	contains less than 2% of: modified food starch	778
11538	pasteurized processed american cheese cheddar cheese milk	32
11539	chicken flavoring lactic acid	295
11540	chicken powder	2257
11541	enriched flour durum wheat flour	239
11542	natural flavor and bha antioxidant	2258
11543	beta carotene and titanium dioxide for color.	478
11544	contains less than 2% of: burgundy wine	1123
11545	spice extract contains salt	148
11546	grill flavor from vegetable oil.	2259
11547	blueberry flavor water as a manufacturing aid	2260
11548	citric acid and artificial colors fd&c red #40 and blue #1	200
11549	less than 2%	2261
11579	sodium bisulfite and citric acid.	2288
11580	Alaska pollock msc certified	1849
11581	natural and artificial flavor extracts of blue crab	1850
11582	tricalcium	381
11583	peach flavor	2002
11584	water as a manufacturing aid	5
11585	citric acid and artificial color fd&c yellow #6	2289
11586	less than 2%: tricalcium phosphate	751
11587	Tomato concentratewater	717
11588	natural flavour.	316
11589	. orange oil	649
11590	calcium chloride contains five live active cultures includes s. thermophilus	340
11591	and casei.	867
11592	natural flavor and citric acid. contains five live active cultures including s. thermophilus	200
11593	black carrot juice concentrate for color	590
11594	and calcium chloride. contains five live active cultures including s. thermophilus	340
11595	Ingredients:tomato puree water	487
11596	seasoning parmesan cheese part skim cow's milk	62
11597	spice extractives on a dextrose carrier	1295
11598	dehydrated garlic. parsley	4
11599	mixed berry juice from concentrate white grape	150
11600	red raspberry	208
11601	brown sugar whey permeate	1181
11602	baking soda colore added	24
11603	citric acid potassium sorbate a preservative	200
11604	blue 1 and 2	2290
11605	preservative tocopherols. vitamins & minerals: vitamin c sodium ascorbate	154
11606	iron ferrous fumarate	251
11607	vitamin d cholecalciferol	581
11608	folic acid. bht added to packaging to help preserve freshness.	727
11609	mixed tocopherols added to preserve freshness. vitamins and minerals: calcium carbonate	154
11610	Reduced-fat milk	2007
11611	Vegetable oil soybean and/or canola oil	872
11612	soy lecithin.  adds a trivial amount of sugar.  sweetened with nutritive and nonnutritive sweeteners.	185
11613	mono- and diglycerides for smoothness	729
11614	disodium inosinate and guanylate flavor enhancers	630
11615	fd&c yellow 6.	403
11616	artificial colors includings: fd & c yellow 6	403
11618	artificial colors including: fd&c red 40	677
11619	hydrogenated palm kernel and palm oils	201
11620	milk chocolate liquor	2291
11621	vanillin an artificial flavoring	186
11622	artificial colors including: fd&c red 40..	677
11623	artificial colors including: yellow 6	403
11624	yellow 5 and blue 1.	2160
11625	fd&c red 40.	677
11626	potassium sorbate and calcium disodium edta as prese	2292
11627	vegetable shortening contains one or more of the following: palm oil and/or soybean oil with emulsifier propylene glycol mono- and diest	2293
11628	yellow corn	162
11629	contains less than 2%: citric acid	200
11630	salt. contains 2% or less of: mono- and diglycerides	148
11631	Sugar enriched bleached wheat flour flour niacin reduced iron	131
11632	thiamine mononitrate riboflavin folic acid	2294
11633	Pretzels and bread sticks and bagel chips unbleached enriched wheat flour wheat flour	131
11634	thiamine mononitrate-b1	468
11635	riboflavin-b2	818
11636	canola and soybean oils	2295
11637	Snacks sticks unbleached wheat flour	131
11638	with malted barley flour as an enzyme	2296
11639	yellow com masa	1573
11640	natural flavors with coconut oil fractions	135
11641	Yogurt pretzels coating sugar	1
11642	yogurt powder cultured whey and nonfat milk	193
11643	pretzels en	2297
11644	Chocolate pretzels coating sugar	1
11645	mononitrate-b1	952
11646	riboflavin-	818
11647	Green jalapeno peppers peppers	2298
11648	stabilizers carbon bean	475
11649	xanthan and/or guar gums	265
11650	food starch - modified. contains 2% or less of apocarotenal color	778
11651	dextrose extractives of paprika	934
11652	and turmeric color	175
11653	turmeric oleoresin color	383
11654	cheese sauce mix dehydrated blend of cheese semisoft and cheddar cheeses pasteurized milk	38
11655	yellow 6. contains 2% or less of apocarotenal color	773
11656	enzyme modified cheese pasteurized milk	1009
11657	Part-skim mozzarella cheese pasteurized part-skim milk	531
11658	food starch - modified. contains 2% or less of dextrose	778
11659	vegetable oil shortening soybean and/or partially hydrogenated soybean oil	243
11660	Monterey jack cheese pasteurzed milk	1204
11661	cheddar cheese pasterized milk	32
11662	cheese culture salt and enzymes	148
11663	mold inhibitor.	338
11664	dried cherries cherries	865
11665	dried blueberries blueberries sugar	130
11666	sulfur dioxide added as a preservative.	306
11667	mono and diglycerides with preservative mixed tocopherols	1612
11668	contains 2% or less of: modified wheat starch	662
11669	colored with caramel color	357
11670	canola oil and/or partially hydrogenated soybean oil	243
11671	salt cinnamon	15
11672	vitamin a palminate	562
11673	calcium carbonate.	328
11674	Cashews roasted in peanut	145
11675	natural and artificial flavor and caffeine.	2299
11676	concord grape juice concentrate	2239
11677	contains less than 2% of malic acid	345
11678	green #3.	2300
11679	Flour enriched wheat flour wheat flour	131
11680	annatto for color. contains five live active cultures including: s. thermophilus	722
11681	stevia extract. contains five live active cul	859
11682	contains five live active cultures includin	109
11683	Prepared cannellini beans	1407
11684	100% orange juice.	65
11685	100% orange juice	65
11686	Concord grape juice water and concord grape juice concentrate	150
11687	contains 2% or less of: pectin	337
11688	elderberry juice concentrate added for color	1414
11689	worcestershire sauce solids molasses	156
11690	Ingredients: tomato concentrate	717
11691	less than 2% of:spice	198
11692	acesulfame	742
11693	contains less than 2%: onions	9
11694	natural bourbon flavor includes smoke flavor	878
11695	natural molasses flavor	156
11696	contains less than 2% : red bell peppers	84
11697	natural flavor includes smoke flavor	268
11698	Prepared kidney beans	605
11699	contains 2% or less of: potassium sorbate a preservative	338
11700	polysorbate 60 an emulsifier	587
11701	and vanillin an artificial flavor.	186
11702	chicken broth powder.	41
11703	+solution ingredients: water	5
11704	cooked chicken water meat chicken	57
11705	chicken thigh meat	2301
11706	less than 2% salt dextrose	750
11707	lime juice powder corn syrup solids	200
11708	grill flavor maltodextrin	197
11709	modified food starch dried onion	9
11710	chicken base cooked chicken meat	57
11711	cooked chicken white meat chicken	57
11712	less than 2%: salt dextrose	148
11713	black bean corn	669
11714	partially hydrogenate soybean oil	599
11715	dehydrated cheese whey	2302
11716	and less than 2% silicon dioxide added as an anticaking agent	631
11717	and water product 35% of weight is added ingredients cured with: water	148
11718	less than 2% potassium lactate	1068
11719	and lss than 2% silicon dioxide added as an anticaking agent	631
11720	dehydrated cheese cheddar cheese milk	32
11721	Whipped dairy cream	473
11722	riboflavin vitamin b2 folic acid	818
11723	bourbon vanilla flavor	20
11724	and l casei.	1998
11725	monterey jack	1204
11726	asiago and parmesan cheeses pasteurized milk	2303
11727	color added paprika extract	55
11728	salt natural and artificial flavors	148
11729	refinery syrup	1131
11730	halved cherries artificially colored red with carmine.	1487
11731	prune juice concentrate	1885
11732	mixed tocopherols a preservative.	154
11733	Chocolatey coating sugar	1
11734	bht preservative	721
11735	less than 2% of: sorbitol	1099
11736	mixed tocopherols antioxidant	154
11737	almond flour.	2304
11738	Chocolatey  coating sugar	1
11739	palm  kernel oil	286
11740	peanut butter flavored spread roasted peanuts	123
11741	dried coconut sorbitol	1099
11742	vegetable oils palm kernel oil	286
11743	roasted sunflower seeds sunflower seeds	151
11744	cottonseed oil and/or sunflower oil	147
11745	contain 2% or less of sea salt modified food starch	778
11746	natural applewood smoke flavor contains maltodextrain	197
11747	contains 2% less of salt	148
11748	wheat flour natural flour contains milk	131
11749	natural flavor contains pork and bacon fat	719
11750	Ingredients: chicken breast meat with rib meat. water contains 2% or less of sea salt	98
11751	garlic contains citric acid	200
11752	flavors. xanthan gum	265
11753	Fresh cucumber	122
11754	gum arabic.	390
11755	enzymes annatto vegetable color.	722
11756	soybean and canola oils	2305
11757	natural flavor red bell pepper	84
11758	potas	1340
11759	contains less than 2% of bacon bacon	50
11760	modifie	778
11761	enriched flour niacin	466
11762	pro	713
11763	spices salt	148
11764	high f	344
11765	vegetable oil consisting of one or more of the following: corn	307
11766	or cottonseed oil	583
11767	sour cream solids cream	25
11768	cheddar cheese solids pasteur	2306
11769	salt butter cream	140
11770	natural and artificial flavour	316
11771	contains less than 2% of butter cream	2
11772	betatene color	2307
11773	Wrapper: enriched	816
11774	malted wheat flour flour	131
11775	sweet whey. filling: sauce water	1025
11776	seasoning blend cornstarch-modified	561
11777	contains 2% or less of xanthan gum	265
11778	parmesan cheese {cultured partskim milk	62
11779	cooked pork and chicken pizza topping sausage made with pork	534
11780	seasoning {spices	834
11781	caramel color}	357
11782	contains 2% or less of lactic acid. may also contain 2% or less of spices	295
11783	restricted melt cheese blend mozzarella cheese pasteurized milk	531
11784	imitation cheese water	5
11785	gum blend {xanthan gum	265
11786	guar gum}	475
11787	anti-caking blend {corn starch	309
11788	calcium sulfate}	924
11789	contains 2% or less of textured soy flour	547
11790	fried in vegetable oil.	35
11791	Apple cider vinegar diluted with water to 5% acidity.	480
11792	White distilled vinegar diluted with water to 5% acidity.	480
11793	Distilled white vinegar diluted with water to 5% acidity.	480
11794	#1 mustard seed	1138
11795	hydrogenated vegetable oils rapeseed	187
11796	hydrogenated vegetables oils rapeseed	187
11797	vegetable flavor concentrate vegetable juice concentrate {carrot	119
11798	celeriac	1823
11799	onion}	9
11800	cooked vegetables {carrot	119
11801	celery}	27
11802	vinegar corn syrup	315
11803	salt onion powder	2308
11804	garlic po	4
11805	hydrolyzed s	1020
11806	Ingredients: tomato pureetomato paste	83
11807	apple filling apples	213
11808	or soybean	256
11809	contains less than 2% of sodium caseinate a milk derivative	640
11810	contains less than 1% of each of the following: soy flour	547
11811	soy protein concentrate and turmeric and beet powder color	2309
11812	cornstarch modified cornstarch	263
11813	caramel truffles sugar	1
11814	confection coating	56
11815	Yogurt peanuts and yogurt raisins confection coating sugar	1
11816	{cultured whey and nonfat milk}	193
11817	titanium dioxide {artificial color}	369
11818	soy lecithin {emulsifier}	185
11819	vanillin {artifici	186
11820	confectionary shellac	289
11821	artificial colors including: blue 1	1692
11822	yellow 5 & yellow 6 and tbhq blend tbhq	2310
11823	propylene glycol citric acid	200
11824	peanut butter contains fresh ground dry roasted peanuts	173
11825	toasted coconut contains sodium metabusulfite	2311
11826	a preservatives	354
11827	red 40 and blue 1	799
11828	artificial colors including: red 40	677
11829	blue 1 and yellow 6.	403
11830	mono and diglyceride	729
11831	artificial colors including: yellow 5	403
11832	contains less than 2% of the following: modified food starch corn	332
11833	acacia gum arabic	390
11834	artificial colors including red 40	677
11835	yellow5	403
11836	yellow6	403
11837	red 3 and blue 1.	799
11838	Refined wax	502
11839	bht to maintain freshness.	721
11840	sot lecithin	185
11841	yellow 6 & blue 1.	2312
11842	artificial colors including fd&c red 40.	795
11843	Cinnamon discs - sugar	15
11844	blue 1 and red 3. butterscotch discs - sugar	1
11845	red 40 and blue 1. peppermint discs - sugar	2313
11846	contains less than .5% of tha following: carrageenan	206
11847	mineral	2314
11848	salts to prevent cream separation in hot liquids.	477
11849	and less than 2% of carrageenan	206
11850	Ingredients: tomato pure water	2315
11851	bread crumbs enriched wheat flour	131
11852	enriched spaghetti  semolina wheat flour	131
11853	thimine mononitrate	468
11854	contains less than 2%; salt	140
11855	potassium chloridi natural flavor	1562
11856	contains less than 2% of natural and artificial flavor	316
11857	mono and dieglycerides	729
11858	strawberry seeds	2316
11859	annatto color. wafer: bleached wheat flour	722
11860	contains less than 2% of cocoa	118
11861	Low fat ice cream: milkfat and nonfat milk	7
11862	contains less than 2% pf peppermint extract	2317
11863	vitamin a palmitate. wafer: bleached wheat flour	1171
11864	corn starch - modified	263
11865	poldextrose	922
11866	contains less than 2% of: diced onions	9
11867	contains less than 2% of: refined lard bht added to protect flavor	704
11868	malt syrup. vitamins and minerals: niacinamide	176
11869	Ingredients: corn meal blend corn meal and degermed corn meal	730
11870	whole wheat and wheat bran	143
11871	rolled oats	78
11872	barley malt extract	635
11873	nonfat dry milk	2318
11874	pear juice concentrate.	284
11875	Ingredients: red pitted cherries	189
11876	Peanuts peanuts	137
11877	peanut and/or sunflower oil	26
11878	artificial coloring includes yellow 6 lake	2319
11879	confectioner's glaze. almonds and cashews almonds and cashews	502
11880	peanut and/or sunflower oil.	26
11881	Milk chocolate drops sugar	1
11882	peanut butter drops sugar	1
11883	white chocolate drops sugar	1
11884	and salt. white chocolate drops sugar	140
11885	peanut and/or 70 sunflower oil	741
11886	Almonds almonds	60
11887	cooked beef pizza topping hamburger beef	33
11888	dried potatoes dehydrated potatoes	279
11889	hydrolyzed soy protein and hydrolyzed wheat gluten	1292
11890	grill flavor from partially hydrogenated soybean and cottonseed oil	975
11891	shortening soybean oil and hydrogenated soybean oil	243
11892	contains 2% or less of leavening sodium bicarbonate	258
11893	aluminum sulfate. contains 2% or less of each of the following: dextrose	612
11894	colored with yellow 5	403
11895	aluminum sulfate. contains 2% or less of each of the following: salt	612
11896	potassium sorbate and bht and tbhq and citric acid preservatives	2320
11897	contains less than 2% of cooked turkey meat	1667
11898	hydrolyzed corn	2321
11899	corn syrup solids.	750
11900	contains less than 2% of wheat flour	131
11901	corn gluten	2322
11902	wheat gluten proteins	1925
11903	Apple juice.	322
11904	cranberry juice cranberry juice and cranberry juice from concentrate	766
11905	no artificial flavors or colors added.	2323
11906	potassium metabisulfite added to maintain flavor and freshness. no artificial flavors or colors added.	988
11907	ruby red grapefruit juice from concentrate	553
11908	grapefruit juice pulp	553
11909	ascorbic acid vitamin c. ingredient not found in regular grapefruit juice; unfortified grapefruit juice has 100% of the daily value of vitamin c per serving.	329
11910	prune juice concentrate.	1885
11911	Ingredients: wax beans	2324
11912	Prepared dry beans	2325
11913	hickory smoked torula yeast	1557
11914	calcium disodium edta to protect color retention.	455
11915	pork vinegar	480
11916	cooked all white chicken meat	117
11917	clam meat	2326
11918	soy protein concentrate butter cream	276
11919	clam base cooked clams	482
11920	unsalted butter cream	2
11921	clam extract	484
11922	dried peas	132
11923	egg white solids	244
11924	alfredo cheese sauce parmesan cheese milk culture	62
11925	romano cheese milk cultures	2327
11926	sweet cream powder	1632
11927	yeast extract and natural flavorings	209
11928	Prepared yellow corn	134
11929	Ingredients: green peas	1604
11930	disodium edta to maintain color.	455
11931	Dehydrated idaho potatoes freshness preserved with sodium acid pyrophosphate	34
11932	and citric acid	200
11933	paprika extract color. freshness protected by sodium bisulfite. dried.	55
11934	whey protein concentrate from milk	387
11935	and yellow 6. freshness protected by sodium bisulfite.	794
11936	margarine partially hydrogenated soybean oil	243
11937	annatto extract color salt	148
11938	freshness protected by sodium acid pyrophosphate	780
11939	Idaho potatoesz8	279
11940	annatto extract color. butter cream	1649
11941	turmeric extract color. freshness protected by sodium acid pyrophosphate	383
11942	and ascorbyl palmitate.  dried	650
11943	cheddar/blue cheese pasteurized milk	7
11944	modified corn and wheat starch	778
11945	yellow 5 and yellow 6. freshness preserved with sodium bisulfite. dried	2328
11946	benzoate of soda	354
11947	and sodium metabisulfite added as preservatives.	2066
11948	concentrate lime juice	61
11949	Diced tomato in juice tomatoes	240
11950	concentrate crushed tomatoes salt.	148
11951	Beef and cooked corned beef cured with salt	33
11952	glycerol ester or rosin	2329
11953	glycerol ester of rosin	2329
11954	brown sugar molasses	156
11955	peanut coating sugar	1
11956	natural peanut flavor	2330
11957	almond flour	377
11958	mixed tocopherols added to retain freshness.	154
11959	nonfat yogurt powder	2331
11960	mixed tocopherols added to retain freshness	154
11961	peanut flour.	2332
11962	blackeye peas. seasoning packet ingredients: salt	148
11963	bacon flavor cellulose powder	740
11964	rendered bacon fat	719
11965	hydrolyzed corn and soy proteins	1292
11966	ham type flavor smoke flavor	268
11967	less than 2% silcon dioxide added as an anti-caking aid.	631
11968	Precooked parboiled whole grain brown rice long grain.	305
11969	cherry puree	2333
11970	flavoring autolyzed yeast extract	209
11971	Tomato puree water and tomato paste	487
11972	phosphor	2334
11973	and raspberry juices from concentrate filtered water	961
11974	Apple and grape juices from concentrate filtered water	2335
11975	apple and grape juice concentrates	2336
11976	reconstituted vegetable juice blend water and concentrated juices of carrots	1424
11977	Pineapple sections	63
11978	ascorbic acid vitamin cto protect color.	329
11979	natural and artificial flavors natural smoke flavor	196
11980	hydrolyzed corn protein. dried	1292
11981	yeast extract. dried	209
11982	thiamine mono nitrate	468
11983	vinegar. dried	480
11984	Tomatoes puree water	487
11985	potassium benzoate preservative.	490
11986	natural artificial flavor.	316
11987	glycerol ester or wood rosin	2337
11988	brominated vegetable oil.	980
11989	Cultured pasteurized grad a nonfat milk	7
11990	Ingredients: durum whaet semolina enriched with iron ferrous sulfate and b vitamins niacin	1280
11991	Ingredients: durum wheat semolina enriched with iron ferrous sulfate and b vitaminsniacin	1280
11992	mono nitrate	952
11993	Ingredients: durum wheat semolina enriched with iron ferrous sulfate and b vitamins	1280
11994	Ingredients: durum wheat semolina enriched with iron ferroue sulfate and b vitaminsniacin	1280
11995	Ingredients: durum wheat semolinaenriched with iron ferrous sulfate and b vitamins niacin	1280
11996	thiamin mono-nitrate	1085
11997	Ingredients: semolina enriched with iron ferrous sulfate and b vitamins niacin	251
11998	dried spinach.	79
11999	Ingredients: durum wheat semolina	451
12000	Ingredients:durum wheat semolina enriched with iron ferrous sulfate and b vitamins niacin	1280
12001	sorbic acid to preserve freshness.	854
12002	yellow 6 lake and red 40 lake. dried.	1974
12003	mono- and diglycerides and sodium caseinate from milk.  dried	639
12004	nonfat day milk	887
12005	thiamine mononuitrate	468
12006	contains less than 2% high fructose corn syrup	344
12007	food starch-modified dehydrated onion	699
12008	cheese cultures salt	148
12009	contains less than 2 % of: salt	140
12010	disodium phosphates	570
12011	tomato paste water	83
12012	meatballsbeef	33
12013	breadcrumbs enriched wheat flour	131
12014	folic acid vitamin d	727
12015	contains 2% or less of : salt	140
12016	beta carotenecolor.	590
12017	enzymes modified romano cheese romano cheese pasteurized cows milk	2338
12018	Tomatoes concentrate water	717
12019	propellant. adds a trivial amount of fat.	135
12020	mon0-and diglycerides.	446
12021	Dough ingredients: enriched flour wheat flour	131
12022	contains less than 2% of each of the following: interesterified soybean oil	243
12023	l-cysteine. spread ingredients: interesterified soybean oil	951
12024	contains less than 2% of each of the following: garlic powder	45
12025	soybean oil. topping ingredients: low-moisture part-skim mozzarella	243
12026	asiago	831
12027	not smoked provolone	2339
12028	and parmesan cheese blend pasteurized milk	2340
12029	thiamin mononitrate vitamin b2 riboflavin vitamin b2	2341
12030	soybean with tbho for freshness	256
12031	Pasteuriezed part-skim milk	2342
12032	sucralose. sweetened with nutritive and nonnutritive sweeteners. not a source of lactose.	399
12033	Whole grain.	2086
12034	Whole grain brown rice.	305
12035	salt corn with germ removed	140
12036	salt cheddar & enzyme modified cheddar cheese solids milk	2343
12037	enzyme modified butter. color fd&c yellow no.5 lake	2
12038	fd&c yellow no.6 lake	2344
12039	citric acid butter solids	200
12040	natural apple flavor	2345
12041	kiwi juice concentrate	1950
12042	natural flavore	316
12043	corn starch and calcium sulfate added to prevent caking. natamycin a natural mold inhibitor.	263
12044	Stone ground corn flour	165
12045	natural flavor salt	148
12046	romano cheese cultures	2327
12047	provolone cheese pasteurized milk	1208
12048	pasteurized whey	193
12049	natural flavors.  dried	196
12050	enriched vermicell wheat flour	784
12051	monosodium glutemate	630
12052	oleoresin turmeric color	383
12053	natural flavor. dried	316
12054	caramel color dried	357
12055	Enriched parboiled long grain rice iron	251
12056	vegetables corn	134
12057	disodium inosinate and disodium guanylate. dried	2346
12058	Enriched parboiled long grain rice	999
12059	ascorbic acid. dried.	329
12060	cheddar/parmesan/blue/mozzarella cheese pasteurized milk	640
12061	yellow 5. dried	403
12062	dairy solids	777
12063	sugar.dried	1
12064	quinine hydrochloride.	1201
12065	lard partially hydrogenated lard with bha and bht added to help protect flavor	2209
12066	Cooked beans	2347
12067	dried.	2348
12068	citric acid. dried	200
12069	diced green chilies	1250
12070	diced jalapenos	1348
12071	food-starch-modified	778
12072	cheese milk	7
12073	apocarotenal	773
12074	acetic acid esters of mono- and diglycerides	2349
12075	Enriched pasta: wheat four	131
12076	citric acid. dried.	200
12077	Enriched pasta: wheat flour	131
12078	sorbic acid; seasoning blend: whey from milk	854
12079	dried broccoli	116
12080	dried chicken chicken fat	1148
12081	topping ingredients: interesterified soybean oil	243
12082	contains less than 2% of each of the following: dehydrated garlic	4
12083	montery jack cheese milk	7
12084	contains less than 2% of: green chilies	66
12085	diced tomatoes in juice diced tomat	240
12086	carra	119
12087	carrageena	206
12088	contains 2% or less of potassium sorbate a preservative	338
12089	contains 2% or less of adipic acid  for tartness	200
12090	sodium citrate  controls acidity	200
12091	natural flavorring	316
12092	Ingredients: gelatin	459
12093	adipic acid for tartness	200
12094	contains 2% or less of sodium citrate controls acidity	477
12095	sweetener	1
12096	acesulfame potassium sweeteneer	855
12097	red 40 dimethylpolysiloxanee prevents foam.	677
12098	maltodextrin acipic acid for tartness	197
12099	potassium citrate contarols acidty	904
12100	acidty	200
12101	mono-and diglycerides prevent foaming	729
12102	titanium dioxide for	369
12103	contains 2% or less of almonds roasted in safflower oil	60
12104	tetrasodium pyrophosphate for thickening	879
12105	pistachios roasted in safflower oil	320
12106	mono-and diglycerides contains propyl gallat	729
12107	Ingredients: modified tapioca starch	757
12108	colored maltodexrin with red 4	2350
12109	contains 2 % or less of salt	140
12110	mono- and diglyceridies	729
12111	titamium dioxide for color	369
12112	carrageenan thickener	206
12113	Ingredients: sugar cornstarch dextrose contains 2% or less of salt	148
12114	thickener mono and diglycerides prevent foaming	729
12115	Ingredients: prepared with beans	214
12116	codium phosphate	751
12117	Ingredients: chicken broth	41
12118	chicken meat cooked chicken meat	57
12119	contains less than 2% of : carrots	31
12120	modified food starch	778
12121	monosodiumglutamate	630
12122	chicken flavor onion powder	121
12123	margarine partially hydrogenated cottonseed oil	1142
12124	colored with annatto/ turmeric	175
12125	soybean oil mix partially hydrogenated soybean oil	599
12126	sodium bisulfite to promote color retention.	397
12127	whet flour	131
12128	beef flavor salt	148
12129	beef extract powder beef stock	1930
12130	caramel coloring.	452
12131	Ingredients: chicken broth	41
12132	thiamine hydrochloride tartaric acid	468
12133	Cooked split peas	2351
12134	contains less than 2% of: bacon cured with water	367
12135	contain less than 2% of potato starch	519
12136	cereal flours corn	165
12137	hydrolyzed yeast	209
12138	soy and wheat protein with partially hydrogenated soybean oil	2352
12139	disodium inosinte	1002
12140	turmeric color. dried	175
12141	contains less than 2% of: yeast extract	209
12142	turmeric for color and flavor	175
12143	thiamine hydrochloride flavor enhancer	468
12144	soy sauce solids salt	148
12145	ferrous sulfate iron thiamine mononitrate	251
12146	Clam broth	483
12147	sirloin beef	1519
12148	rehydrated onions	9
12149	autolyzed yeast extract.	209
12150	Multigrain blend whole grain rolled oats	78
12151	whole grain rolled rye	217
12152	dried sweetened peaches peaches	444
12153	sodium metabisulfites	397
12154	resistant maltodextrin	197
12155	dehydrated apples treated with sodium sulfate to promote color retention	213
12156	pyridoxine hydrochloride vitamin b60	525
12157	Almonds roasted in peanut and/or cottonseed oil	60
12158	Whole raw almonds.	160
12159	confectioner's glaze. almonds and cashews: roasted in peanut	410
12160	sunflower and/or cottonseed oil.	147
12161	Almonds: roasted in peanut	60
12162	sunflower oil. raisins. cashews roasted in peanut	2353
12163	peanuts roasted in peanut and/or cottonseed oil	173
12164	mango; mango	190
12165	sulfur dioxide used as a preservative	426
12166	fd&c yellow no 6	403
12167	fd&c yellow no 5	403
12168	pineapple; pineapple	63
12169	sulfur dioxide used as a preservative. apricots; apricots	306
12170	bananas; bananas	1340
12171	banana flavoring	2083
12172	almonds roasted in peanut and/or cottonseed oil. cranberries; cranberries	60
12173	Ingredients: maltodextrin from corn	197
12174	solids from milk	405
12175	Papaya red and yellow	1334
12176	Ingredients: white and cold corn	134
12177	contains less then 2% of natural and artificial flavor	316
12178	Pasteurized part skim milk	1238
12179	cream and skim milk	7
12180	vegetable oil palm and rapeseed oil	26
12181	cottonseed and/or peanut oil	741
12182	natural and blanched almonds	60
12183	hazelnuts filberts	144
12184	shelled	2354
12185	monopotassium phosphate	985
12186	acesulfame potassium and sucralose sweeteners	2355
12187	Ingredients: unbleached wheat flour enriched niacin	131
12188	Unbleached wheat flour enriched niacin reduced iron	131
12189	Graham cracker meal enriched flour wheat flour	131
12190	vegetable shortening contains hydrogenated palm kernel	286
12191	thiamine mononitrate riboflavin	818
12192	soybean and/or cottonseed oil and/or canola and corn oils	243
12193	may contain salt	140
12194	yeast nutrients contains one or more of the following: mono calcium phosphate	2356
12195	mono-and diglycerides freshness protected by sodium acid pyrophosphate	729
12196	beta carotene color. freshness protected by sodium acid pyrophosphate	478
12197	and citric acid. dried	200
12198	romano and monterey jack cheese pasteurized milk	1009
12199	reduced lactose whey from milk	405
12200	yellow 6. freshness preserved with sodium acid pyrophosphate	780
12201	sodium bisulfite and citric acid.  dried	1494
12202	chicken mechanically separated chicken	626
12203	lactose from	405
12204	turmeric and paprika extracts color. dried	1896
12205	parmesan and romano and blue cheeses pasteurized milk	2357
12206	disodium phosphate and dipotassium phosphate	194
12207	tocopherols and ascorbyl palmitate preservatives.	2358
12208	thiamine mononitrtae	468
12209	disodium inosinate and sodium caseinate from milk	2359
12210	natural flavor and soy lecithin. dried	394
12211	turmeric extractcolor. dried	383
12212	yellow 6. dried	794
12213	dry whey	193
12214	natural and artificial flavoring added	407
12215	butterfat milk	393
12216	and artificial flavoring added.	643
12217	propylene glycol sustains freshness	616
12218	sodium metabisulfite preservatives whiteness.	2066
12219	sodium metabisulfite preserves whiteness.	2066
12220	vegetable shortening contains one or more of the following: palm oil and/or soybean oil with emulsifier propylene glycol mono-and diesters	201
12221	soy lecithin with preservative bht	185
12222	vegetable shortening contains one or more of the following: palm and/or soybean oil with emulsifier propylyene glycol mono- and diesters	201
12223	and/or soybean oil with emulsifier propylene glycol mono- and diesters	243
12224	mono-and diglycerides and soy lecithin with preservative bht	2360
12225	emulsifier mon- and diglycerides with preservatives mixed tocopherols	2361
12226	modified wheat starch natural and artificial flavor	1936
12227	partially hydrogenated vegetable shortening contains one or more of the  following: partially hydrogenated soybean oil	599
12228	natural and artificial flavor with soy lecithin	407
12229	cultured whey milk	193
12230	wheat and corn protein	326
12231	sodium caseinate milk	640
12232	granular and blue cheeses milk	2362
12233	natural flavor including soy	142
12234	citric acid and potassium sorbate preservative	200
12235	contains less than 2% of: silicon dioxide	309
12236	turmeric for color spice	175
12237	thiamine hydrochloride flavor enhancer.	468
12238	contains less than 2% of: beef stock	1930
12239	and turmeric	175
12240	contains less than 2% of modifie	778
12241	contains less than 2% of caramel color	357
12242	pineapple juice from concentrate water	497
12243	disdoium phosphate	779
12244	contains less than 2% anchovies fish	1270
12245	potassium sorbate and calcium d	338
12246	disod	594
12247	red bull pepper	536
12248	mal	204
12249	potassium sorbate a preservative xanthan gum	338
12250	locust bea	339
12251	contains less than 2% of mustard flour	95
12252	contains less than 2% modified food starch	778
12253	soy flour contains soybean oil and soy lecithin	547
12254	paprika color. dextrose	55
12255	spices. garlic powder	4
12256	maltodextrin from corn. paprika extract color.	197
12257	partially gydrogenated soybean and cottonseed oils	881
12258	color onoin	1102
12259	dried	1003
12260	contains 2% or less of: onion	9
12261	vegetable mono and diglycerides.	729
12262	vegetablemono and diglycerides	446
12263	beta-carotene color.	590
12264	potassium sorbate and sorbic acid as preservatives	854
12265	Nutritive dextrose	750
12266	saccharin	756
12267	potassium iodide 0.006% and sodium bicarbonate.	913
12268	Ingredients: orange pekoe and cut black tea.	851
12269	Orange pekoe and cut black tea.	851
12270	Naturally decaffeinated orange pekoe and cut black tea.	851
12271	Pure green tea.	501
12272	mini marshmallows sugar	1
12273	vegetable oil may contain partially hydrogenated coconut	135
12274	natural and a	170
12275	artificial flavors. not a source of lactose	637
12276	artificial flavors. not a source of lactose.	637
12277	soy lecithin. not a source of lactose.	185
12278	organic unrefined cane sugar	170
12279	corn starch and calcium sulfate added to prevent caking. natamycin  a natural mold inhibitor.	263
12280	vegetable oil blend canola	90
12281	contains less than 2% of the following: nonfat dry milk	801
12282	Lowfat ice cream: nonfat milk	7
12283	and fd&c red # 3	849
12284	enriched bleached flour wheat flour niacin	131
12285	modified wheat starch. dried	662
12286	green chili powder	195
12287	beet powder color.	768
12288	margarine liquid and hydrogenated soybean oil	243
12289	contains less than 2% of vegetable mono and diglycerides	1511
12290	vitamin a plamitate added	1171
12291	potassium sorbate to protect flavor	338
12292	disodium pyrophosphate to maintain color	2247
12293	titanium dioxide color.	369
12294	cooked enriched macaroni semolina wheat flour	131
12295	enriched with niacin	466
12296	pasteurized process american cheese food cultured milk	2363
12297	sorbic acid preservatives annatto color	854
12298	cheese sauce powder cheese blend {pasteurized milk	7
12299	coloring {yellow 5	403
12300	yellow 6}	794
12301	cheese blend cheddar	32
12302	granular	1
12303	semisoft	2364
12304	and blue cheese {pasteurized milk	837
12305	water modified food starch	778
12306	spices caramel color	357
12307	natural smoke flavor pineapple juice concentrate	1179
12308	100% whole grain wheat. bht added to packaging material to help preserve freshness.	143
12309	monocalcium aluminum phosphorus	715
12310	palm and palm kernels oils	201
12311	enriched wheat flour breached wheat flour	131
12312	sorbitan monostearte	591
12313	dicalcium phsphate	646
12314	soium alginate	645
12315	ditric acid	200
12316	whole grainrolled oats	78
12317	solluble conr fiber	2365
12318	reuced iron	251
12319	ribofalvin vitamin b2	818
12320	thiamin hydrochloried vitamin b1	1085
12321	Rolled oat clusters rolled oats	78
12322	Ingredients: 100% rolled oats	78
12323	vitamin b6 pyridoxine chloride	525
12324	bht added to packaging to help preserve freshness.	721
12325	Whole oat flour  sugar	2366
12326	tripotassium phoshate	848
12327	vitamin d cholecalcifero	1184
12328	vitamin b1 thiamine hydrochloride	1085
12329	vitamin b12 cyanocobalamin. bht added to packaging to help preserve freshness.	1790
12330	marsmallows sugar	1
12331	natural and artificial flavor color red 40	677
12332	preservatives tocopherols.	1983
12333	Flour corn	165
12334	oleoresin	1571
12335	vitamin b2 ribofavin	818
12336	vitamin d cholecaciferol	581
12337	Degermed yellow cornmel	2367
12338	vitamin b1 thiamine mononitrtae	1085
12339	viatmin b12 cyanocobalamin	526
12340	Ingredients: wheat bran	301
12341	malt extract. vitamins & minerals: iron ferric orthophosphate	391
12342	tripotassium phospahte	714
12343	niacianamide	466
12344	vitamin b12 cyanocobalamin.bht added to packaging to help preserve freshness.	1790
12345	calcium calcium carbonate	328
12346	vitamin b6 pyridoxide hydrochloride	2093
12347	Ingredients: white hominy grits made from corn	134
12348	folic acid. one of the b vitamins	819
12349	Ingredients: whole grain rolled oats	78
12350	whole grain rolled wheat	143
12351	folic acid. one of the b vitamins.	819
12352	oat flour whole	274
12353	vitamin b6 pyridoxine hydrocholoride	525
12354	colorcaramel	357
12355	sugar rice	1
12356	contains less than 2% of the following: almonds	146
12357	partially hydrogenated cottonseed and/or soybean oil	881
12358	nonfat dry fatty acids	801
12359	soy lecithin. vitamins and mnerals: iron ferric orthophosphate	185
12360	zinc zincoxide	1585
12361	vitamin b12 cyanocobalamin.	526
12362	color added annatto.	722
12363	palm oil with tbhq	201
12364	peanut and/ or canola and/or cottonseed oil	26
12365	artificial flavor vanillin.	186
12366	canola and/or peanut and/or cottonseed oil	26
12367	peanut and/or canola and/or canola and/or cottonseed oil	26
12368	vegetable oilcontains one or more of the following ; canola	90
12369	contains two percent or less of ; whey from milk	193
12370	eggs+	14
12371	Ingredients:enriched flour wheat flour	131
12372	vegetable oil contains one or more of the following:palm	201
12373	Ingredients: enriched bleached wheat flour bleached wheat flour	131
12374	figs preserved with sulpur dioxide	306
12375	partially hydrogenated vegetable oil shortening contains one or more of the following: soybean and/or cottonseed oil	243
12376	corn binder	263
12377	caramel color. adds a trivial amount of trans fat.	357
12378	natural and artificial flavors =	196
12379	sodium metabisulphite dough conditioner.	2368
12380	Ingredients: enriched wheat flour wheat flour	131
12381	graham flour whole grain wheat flour	283
12382	calcium phosphateleavening	381
12383	baking soda and/or calcium phospahte leavening	2369
12384	riboflavinvitamin b2	818
12385	soybean and palm oil with tbhq added to preserve freshness	243
12386	contains 2 or less of: malt syrup from barley and corn	1360
12387	vegetable color annatto extract	722
12388	vitamin niacinamide	466
12389	zinc oxide & reduced iron mineral nutrients	2370
12390	c orn syrup	596
12391	bht preservatives. vitamins and minerals: calcium carbonate	721
12392	niavinamide	1492
12393	pyrodoxine hydrochloride vitamin b6	525
12394	thiamin mononitate vitamin b1	1085
12395	Pure honey.	36
12396	Ingredients: pure honey.	36
12397	calcium lactate ingredients not found in regular orange juice .	857
12398	concentrated grape juice sugar syrup	170
12399	less than two percent of sodium caseinate from milk	847
12400	m\\natural flavors	1004
12401	ligh	2371
12402	Unbleached enriched white flour wheat flour	131
12403	ferrous sulfate or reduced iron	251
12404	soybean oil and/or canola oil	872
12405	enzyme added for improved baking	1596
12406	pyridoxine hydrochlorine	525
12407	blueberry bits dextrose	750
12408	natural and artificial blueberry flavor.	1565
12409	Beef liver	2372
12410	Swiss cheese milk	7
12411	whey. contains 2% or less of each of the following: leavening	193
12412	artificial smoke flavor	268
12413	dry cream	473
12414	annatto and oleoresin papika color	722
12415	soy lecithin release agent.	185
12416	cream contains less 2% of: whey	193
12417	food starch - modified corn	561
12418	contains less than 2% of modified food starch corn	332
12419	calcium sulfat	924
12420	Pasteurized part- skim milk	1205
12421	enzymes taco spice blend maltodextrin	197
12422	corn starch and calcium sulfate added to prevent caking natamycin a natural mold inhibitior	263
12423	pasteurized soy milk	1895
12424	stabilizr carob bean and/or xanthen and/or guar gums	475
12425	modified foot starch	1559
12426	red 40 color.	677
12427	white corn flour. contains 2% or less of each of the following: potassium chloride	165
12428	dextrose. contains 2% or less of each of the following: salt	750
12429	pattasium sorbate and citric acid and tbhq preservatives	2373
12430	folicacid	819
12431	dextrose. contains 2% or less of each of the following: potassium chloride	750
12432	sodium stearoyl lactylate xanthan gum	875
12433	soyflour.	547
12434	aluminum sulfate. contains 2% or less of each of the following: sugar	612
12435	contains 2% or less of each of the following: sugar	1
12436	thiamin mononirate vitamin b1	1085
12437	soybean and /or cottonseed oils. contains 2% or less of each of the following: leavening baking soda	2374
12438	sorbic and citric acid preservatives	854
12439	citric acid and sodium propionate and potassium sorbate added to retard spoilage	2375
12440	contains 2% oe less of: sugar	1
12441	degerminated yellow corn flour	165
12442	azodicarbonamide.	1052
12443	degermed yellow corn flour	165
12444	calcium phosphate.	381
12445	100% orange juice from concentrate filtered water	65
12446	orange juice pulp.	65
12447	100% pure and natural grapefruit juice.	553
12448	contains less than. 5% artificial color	2376
12449	and vitamin a added.	562
12450	contains less than 5% of the following: carrageenan	206
12451	mineral salts to prevent cream separation in hot liquids.	477
12452	potassium sorbate  preservative	338
12453	calcium propionate a preservative	911
12454	dough conditioner sodium metabisukfate.	2066
12455	vegetable shortening palm oil with monoglycerides	201
12456	calcium propionate a preservative.	911
12457	sodium bicarbonate sodium aluminium phosphate	2377
12458	calcium propionate  a preservative	911
12459	dough conditioner sodium metabisulfite.	2066
12460	sugar syrup water and sugar.	310
12461	less than two percent of sodium caseinate from milk. natural flavors. xanthan gum. guar gum. polysorbate 60. sorbitan monostearate. and beta carotene for color.	478
12462	Large brown eggs	1384
12463	Cooked squash.	2378
12464	cellelose gum	600
12465	calcium sulfate. cheese filling ingredients: low-moisture part-skim mozzarella cheese pasteurized part-skim milk	924
12466	enzymes. topping ingredients: interesterified soybean oil	192
12467	contains less than 2% of each of the following: water	2379
12468	seasoning dehydrated garlic	4
12469	natural flavour	1302
12470	silicon dioxode	631
12471	mono-& deglycerides with citric acid preservative	2380
12472	sodium acid pyrophosphate added to maintain natural color	780
12473	Ingredients: bacon cured with water	140
12474	green peppers onion	9
12475	black olives olives	1458
12476	cheese culture salt enztmes	148
12477	whey modified potato starch	519
12478	soribic acid as a preservative	854
12479	Skim milk cheese cultured nonfat milk	472
12480	waater	5
12481	protein concentrate	713
12482	natural and artificial cheddar cheese flavor	38
12483	food starch- modified tapioca	757
12484	whey food starch-modified corn	332
12485	Pastured milk	7
12486	coffee culture	550
12487	Cow's milk	1163
12488	enzymes. powdered cellulose added to prevent caking.	2381
12489	Parmesan cheese cultured	62
12490	stabilizers carob bean and/or xanthan guar gums.	265
12491	natural flavor pectin	337
12492	vegetable juice and beta carotene color	478
12493	modified food	2382
12494	turmeric and annatto extract color	383
12495	vitamin s palmitate	1171
12496	Cultures pasteurized grade a nonfat milk	7
12497	Liquid & partially hydrogenated soybean oil	243
12498	whey solids+	193
12499	vitamin a palmitate added. +adds trivial amount of cholesterol.	1171
12500	vitamin a palmitate added. adds a trivial amount of cholesterol.	1171
12501	Enriched bleached four wheat flour	131
12502	water dextrose	750
12503	sugar. contains 2% or less of each of the following: partially hydrogenated vegetable oil soybean and/or cottonseed oils	1
12504	turmeric extract color. dried	383
12505	Prepared chick peas	1150
12506	caramel coloring	452
12507	less than 1% of the following; natural flavors	2383
12508	color contains beta carotene	478
12509	maltodextrin. vitamins and minerals: calcium sulfate	197
12510	margarinepalm oil	201
12511	annattocolor	722
12512	enriched wheat barley flour bleached wheat flour	131
12513	niacin. reduced iron	466
12514	soy lecithin and vanilla an artificial flavor	185
12515	corn palm oil	201
12516	less than 2% of: lecithin	185
12517	mixed tococpherols a preservative.	1983
12518	malted barley four	993
12519	dehydrated marshmallows sugar	1
12520	gelatin. artificial flavor	459
12521	honey graham cookie pieces wheat flour	131
12522	glycerin. less than 2% of: palm oil	234
12523	whey protein concentrate. natural and artificial flavors	387
12524	mixed tocopherols a preservative. caramel color	1612
12525	citric acid preservative	200
12526	contains 2% or less of each of the following; skim milk	472
12527	Whole durum wheat flour.	239
12528	Ingredients: dehydrated potato with preservative sodium bisulfite	279
12529	partially hydrogenated soybean oil with emulsifier mono and diglycerides	243
12530	reduced-lactose whey	193
12531	aged cheddar cheese milk	640
12532	chilies	195
12533	msg	541
12534	one of the b vitamins. adds a negligible amount of sugar.	466
12535	citric acid and natural orange flavor.	2384
12536	Ingredient: pure honey	36
12537	contains two percent or less of:cornstarch	263
12538	corn syrup dextrose	750
12539	corn flour contains two percent or less of: cornstarch	263
12540	#6	140
12541	cocoa processed with a alkali	118
12542	moo ' natural and artificial flavors and soy lecithin an emulsifier.	394
12543	cinnamon titanium dioxide an artificial color	15
12544	thiamin monitrate	1085
12545	riboflavin and folic aicd	1695
12546	contains two percent or less of: salt sodium bicorbonate	258
12547	contains 2% or less of the following: potassium lactate	1068
12548	flavoring. coated with caramel color.	407
12549	cocoa processed with alkali modified whey partally hydrogenated vegetable oil may contains coconut soybean sunflower palm and/or canola calcium carbonate non fat dry milk contains less than 2% of salt	118
12550	sodium caseinate dipotassium phosphate cellulose gum artificial flavor mono and diglycerides carrageenan	847
12551	Ingredients: sugar corn syrup solids cocoa processed with alkali modified whey partially hydrogenated vegetable oil may contain coconut soybean sunflower palm and or canola  mini marshmallows sugar corn syrup	118
12552	modified corn starch gelatine artificial flavor calcium carbonate non fat dry milk	332
12553	contains less than 2% of salt sodium caseinate dipotassium phosphate cellulose gum	2385
12554	artificial  flavor mon and diglycerides	921
12555	geltain	459
12556	leavening sodium aluminium phosphate	1548
12557	malic acid citric acid	200
12558	niacinamide ginseng extract panax	1492
12559	potassium sorbate preservati	338
12560	acesulfame potassium and sucralose sweetener	2386
12561	2% or less of high fructose corn syrup	344
12562	hydrolyzed corn soy wheat gluten protein	1292
12563	romano cheese solids from cow's milk pasteurized milk	62
12564	oil of onion	2387
12565	rivboflavin	818
12566	yeast salt 2% or less of high fructose corn syrup	148
12567	whey spices	193
12568	azodicarbon-amide	1052
12569	sodium stearoyl lactlate	875
12570	disodium unosinate	1002
12571	disodium guanylae	2388
12572	or less of: yeast	294
12573	romano cheese solids from cow's milk	62
12574	parsley dehydrated	22
12575	annatto and tumeric color	236
12576	vegetable gums gum tragacanth	1912
12577	arabic	390
12578	and xanthan	265
12579	fd&c colors red 3	849
12580	arabic & xanthan	265
12581	fd&c colors which include yellow 5	2389
12582	red 3 & red 40.	677
12583	artificial banana flavor	2390
12584	fd&c yellow 5.	403
12585	vegetable gums gm triglycerides	668
12586	fd&c colors which include yellow 5 & 6	2391
12587	partially hydrogenated vegetable oil cottonseed	881
12588	cottonseed & soybean	243
12589	cottonseed & soy	243
12590	sugar roasted peanut	137
12591	vegetable gum tragacanth	2392
12592	and arabic	2393
12593	vegetable gums tragacanth	2392
12594	blue 1 and red 40.	2394
12595	peppermint oil.	458
12596	xanthan and arabic	2395
12597	artificial colors red 3	849
12598	arabic and xanthan fd & c colors red 40	677
12599	yellow 6 and blue 1	2160
12600	vegetable gums  tragacanth	2392
12601	freeze dried orange powder	103
12602	invertase.	2396
12603	artificial cherry flavor	2397
12604	& fd&c red 3.	849
12605	artificial color red 3	849
12606	artificial colors  red 3	849
12607	yellow 6 and blue 1.	2160
12608	artificial cinnamon flavor	15
12609	artificial colors red 40.	677
12610	natural peppermint flavor	2243
12611	xanthan and arabic artificial colors yellow 5	2398
12612	chocolate liquior	2399
12613	vanillin sugar	186
12614	condensed whole milk	891
12615	gelatin vegetable gums tracacanth xanthan and arabic	265
12616	glycerine gelatin	459
12617	fdc colors red #3	849
12618	blue #2 lake	977
12619	red #40 lake.	677
12620	Sweet chocolate sugar	1
12621	seeds seeds contain sugar & corn starch.	134
12622	mono/diglycerides	729
12623	bittersweet chocolate chocolate liquor	118
12624	malted milk wheat flour	131
12625	fd&c colors yellow 5	403
12626	anhydrous butter oil	2400
12627	seeds seeds contain sugar & corn starch	2401
12628	fd&c colors including red 3	2402
12629	blue 1 and blue 2.	2403
12630	vegetable gum gum tragacanth	1912
12631	and blue 1.	2404
12632	malted milk powder wheat flour	131
12633	sorbitan tristearate	2405
12634	Sweet chocolate  sugar	1
12635	seeds sugar	1
12636	fd&c colors red 3. red 40	677
12637	sweetened condensed whole milk milk	523
12638	natural &artificial flavors	196
12639	fd&c	2406
12640	fd&c colors yellow 5 & 6	786
12641	and red 40.	677
12642	seasoning blend chili pepper	710
12643	fermented w	295
12644	malt extract. vitamins and minerals: iron ferric orthophosphate	391
12645	Enriched macaroni product semolina	451
12646	iron {ferrous sulfate}	251
12647	folic acid salt	727
12648	dehdrated onion	699
12649	enriched flour flour	816
12650	hydrolyzed corn and soy and wheat protein	1292
12651	dehydrated soy sauce soybeans	39
12652	partially hydrogenated soybean oil with emulsifier mono- and diglycerides	243
12653	folic acid dehydrated tomato	727
12654	color yellow 5 lake	863
12655	halved cherries artificially colored red with carmine and sugar.	1
12656	Pork ribs	2407
12657	barbecue sauce corn syrup	596
12658	contains less than 2% molasses	156
12659	artificial color yellow 5	403
12660	contains two percent or less of: cocoa processed with alkali	118
12661	no. 1 mustard seed	1138
12662	turmeric and spice.	383
12663	aquaresin paprika	55
12664	contains less than 1% of modified food starch	778
12665	contains less than 1% of garlic	4
12666	contains less than 1% garlic	4
12667	Aged red cayenne peppers	195
12668	caramel. vitamins and minerals: vitamin c sodium ascorbate	452
12669	reduced i	1561
12670	iron reduced	251
12671	preservative bht. vitamins and minerals: calcium carbonate	721
12672	degermed yellow	2367
12673	trisodium phosphate. vitamins and min	714
12674	tricalcium phosphate. vitamins and minerals: reduced iron	751
12675	vitamin b12 cyanocobala	526
12676	preservative tocopherols. vitamins and minerals: vitamin c sodium	154
12677	preservative tocopherols. vitamins and minerals: vitamin c sodium ascorbate	154
12678	vegetbales shorteninh partially hydrogenated soybean and/or cotton seed oils	881
12679	partially hydrogenated soybean & cottonseed oils	881
12680	anhydrus dextrose	750
12681	sorbitan monostearate & polysorbate 60 & soya lecithin emulsifiers	591
12682	dried eggs.	14
12683	vegetable shortening partially hydrogenated soybean and/or cottonseed oils	881
12684	dried eggs	772
12685	leavening baking powder sodium acid pyrophosphate	780
12686	emulsifier water	5
12687	artificial colors yellow #5	403
12688	red #40. filled with: water	677
12689	artificial color red #40.	677
12690	dough conditioners contains one or more of the following: sodium stearoyl lactylate	875
12691	monoglycerides and/or diglycerides	729
12692	yeast food ammonium sulfate	915
12693	calcium propionate to retard spoilage.	911
12694	iodized salt	148
12695	partially defatted cooked pork fatty tissue tocopherol	154
12696	salt. contains 2% or less of: mustard	140
12697	contains 2% or less of: hickory smoke flavor	749
12698	figs preserved with sulphur dioxide	2408
12699	partially hydrogenated vegetable oil shortening+ contains one or more of the following: soybean and/or cottonseed oil	881
12700	and malt.	635
12701	contains 2% or less of fumaric acid for tartness	421
12702	sodium bisulfite added to stabilize color.	1289
12703	Peanuts roasted in peanut and/or cottonseed and/or sunflower seed and/or canola oil	741
12704	contains less than 2% of dipotassium phosphate	779
12705	glycerine modified corn starch	332
12706	leavingsodium aluminum phosphate	864
12707	natural and artificial flavor. potassium sorbate a preservative	316
12708	colors added yellow 5	976
12709	Basmati long grain brown rice.	305
12710	White basmati rice.	1718
12711	autilyzed yeast extract	209
12712	and	2409
12942	fd&c yellow #5 and yellow #6	786
12713	potassium sorbate and carbon dioxide to preserve freshness	338
12714	and enzyme.	1596
12715	less than 2% of: partially hydrogenated lard with bha and bht to protect flavor	2209
12716	diced tomatoes in juice	240
12717	Tomato puree water. tomato paste	487
12718	chocolate cookies sugar	1
12719	ground celery seed	931
12720	and tricalcium phosphate.	751
12721	and black pepper.	10
12722	fd&c red #3 and 40.	677
12723	tri calcium phosphate and silicon dioxide added to make free flowing	751
12724	and fd&c yellow #5 lake.	403
12725	spices including turmeric for spice and color	383
12726	yellow lake #5	976
12727	red lake #40.	677
12728	Wheat  Gluten	326
12729	100% pure olive oil.	6
12730	red 40 and blue 1 color.	2410
12731	potassium metabisulfite preservative.	988
12732	high fructose corn syrup with sulfur dioxide	344
12733	calcium propionate to preserve freshness.	911
12734	partially hydrogenated vegetable shortening contains soybean and cottonseed oil with emulsifier soy lecithin	243
12735	gelatinized yellow flour	131
12736	enriched bleached flour bleached flour	16
12737	thiamin mon	1085
12738	Young baby corn	1777
12739	and cyanocobalamin.	526
12740	mustard powder.	95
12741	Portabella mushrooms	1826
12742	roasted red peppers peppers	75
12743	oregano and marjoram.	42
12744	sweet red peppers peppers	536
12745	calcium chloride garlic	340
12746	marjoram.	42
12747	stabilizers xanthan	265
12748	and guar gums.	475
12749	guava puree	1564
12750	passionfruit juice concentr	1618
12751	sunflower oil and /or canola oil contains ascorbic acid and rosemary	650
12752	protease	2411
12753	sodium metabisulphite.	2130
12754	sunflower oil and/or canola contains ascorbic acid and rosemary	1382
12755	wheat germs	180
12756	natural flavor maltodextrin	197
12757	malt flour	386
12758	sodium metabisulphite	2368
12759	protease.	2411
12760	semi sweet chocolate chips sugar	1
12761	contains 2% or less of: cornstarch	263
12762	sodium bicarbonate l	24
12763	contains 2% or less of the following:	140
12764	deproteinized dairy whey	2412
12765	dehydrated horseradish	212
12766	diced tomatoes citric acid	200
12767	Clams and clam juice soybean oil	243
12768	clams and clam juice	482
12769	spices and natural flavorings.	834
12770	natural blood orange flavor including blood orange juice. citric acid	1580
12771	blue 1 and beta carotene for color.	1692
12772	natural flavor including lemon juice citric acid	200
12773	glycerol ester of wood rosin.	769
12774	natural lemon flavor including lemon juice	18
12775	grape skin extract for color	237
12776	contains 2% or less of the following: citric acid	200
12777	artificial coloring may or may not contain: blue 1	1692
12778	less than 1/10 of 1% of sodium benzoate and potassium sorbate as preservative.	354
12779	cream milk product	473
12780	whey milk product	193
12781	natural orange flavors	649
12782	lime oil and other citrus oils	1118
12783	tbhq to preserve freshness	1955
12784	natural & artificial flavors red 40	677
12785	Durum wheat	1968
12786	glycerol esters of wood rosin	2337
12787	Milk and milk fat	639
12788	artificial vanilla	186
12789	Enriched elbow macaroni semolina wheat flour	131
12790	sweet peas	1370
12791	calcium chloride to maintain firmness	340
12792	sodium acid pyrophosphate. contains 2% or less of each of the following: beef tallow	780
12793	vegetable oil soybean and/or cottonseed oils	243
12794	potassium sorbate and tbhq and citric acid preservatives	2413
12795	contains 2% or less of the following: brown sugar	1
12796	concentrated chicken stock	97
12797	Beef flavored stock water	1930
12798	carrot powder.	119
12799	Minced fish blend pollock	896
12800	whiting	2414
12801	sole	2415
12802	and/or cottonseed oil	583
12803	contains less than 2% of following: salt	140
12804	extractives of paprika and annatto for color	934
12805	mono-calcium phosphate	2416
12806	sodium hexametaphosphate to retain moisture	1275
12807	Partially hydrogenated vegetable oil shortening soybean oil	243
12808	tamari soy sauce water	39
12809	alcohol preservative	338
12810	contains 2% or less of: sesame seeds	266
12811	lemon juic	200
12812	fermented black soybeans	2417
12813	disodium gu	594
12814	riboflavin.	818
12815	interesterified soy bean oil	243
12816	contains less than 2% of sodium citrate	477
12817	fudge sauce corn syrup	596
12818	strawberry sauce corn syrup	596
12819	artificial color red #40	677
12820	yellow 5 or yellow 6	403
12821	may also contain: sugar	1
12822	maple flavor natural and artificial propylene glycol	2191
12823	flavor {contains corn syrup and caramel color}	316
12824	Bleached flour wheat flour	131
12825	paprika and silicon dioxide added to prevent caking	55
12826	dimethyl siliconefor anti-foaming	1595
12827	also contains propellant to dispense spray. adds a trivial amount of fat.	2418
12828	vegetable oil contain one or more of the following: palm	201
12829	dex	750
12830	high	1
12831	Sun dried tomatoes	700
12832	Ground tomatoes in puree	487
12833	imported olive oil	6
12834	red pepper seeds.	195
12835	Imported italian tomatoes	240
12836	imported pecorino romano cheese pasteurized sheep's milk	2419
12837	vodka	1577
12838	crushed red pepper seeds.	195
12839	asiago and provolone cheeses pasteurized cow's milk	2420
12840	ricotta cheese whole milk	971
12841	modified corn starch. vitamins and minerals: calcium carbonate	778
12842	vitamin b6 cholecalciferol	2421
12843	malt extract. vitamins and minerals: vitamin c sodium ascorbate	391
12844	sodium hexametaphosphate natural and artificial flavor	1275
12845	preservative tocopherols. vitamins and minerals: calcium carbonate	154
12846	color annatto extract. vitamins and minerals: vitamin c sodium ascorbate	722
12847	ascorbic acid vita	329
12848	tomato past	240
12849	Pork mechanically separated turkey	2422
12850	maple flavor natural flavor	2191
12851	Frozen dessert: milkfat and nonfat milk	7
12852	partially hydrogenated vegetable oil cottonseed and/or soybean	1142
12853	soy leicthin	185
12854	natural & artificial flavoring	407
12855	may or may not contain blue 1	1
12856	less than 1% of sodium benzoate and potassium sorbate as preservativ	354
12857	hydrolyzed corn and soybean protein	1292
12858	less than 0.1% of potassium sorbate	338
12859	pomegranate and lemon flavor including lemon juice	2423
12860	grape skin extract as color	2424
12861	glycerol ester of wood rosin as stabilizer.	2337
12862	confectioner's glaze and fd&c yellow #5.	2425
12863	soybean and palm oil with tbhq for freshness	243
12864	contains 2% or less of yellow corn flour	165
12865	contains less than 2% of propylene glycol monoester	1128
12866	contains less than 2% of strawberries	88
12867	contains less than 2% propylene glycol monoester	1128
12868	why	193
12869	contains less than 2% or strawberries	448
12870	corn starch- modified	561
12871	contains less than 2% of propylene glycol	616
12872	less than 2% of propylene glycol monoester	1128
12873	Milkfat and nonfat milk. sugar	7
12874	corn starch - modified propylene glycol monoester	332
12875	viatmin a palmitate.	1171
12876	chocolate flavored chips powdered sugar sugar	1
12877	soybean and cottonseed oil	243
12878	palm hydrogenated coconut and soybean oils	201
12879	contains less than 2% of citrus pulp	1636
12880	mono& diglycerides	729
12881	locust bean g	205
12882	vegetable oil margarine vegetable oils soybean	243
12883	modified palm	201
12884	soy mono-and diglycerides	394
12885	Enriched bread: enriched wheat flour	131
12886	molasses wheat gluten	955
12887	Scone: enriched wheat flour wheat flour	131
12888	non-hydrogenated vegetable oil shortening palm	201
12889	soybean and modified palm oil	243
12890	dried blu	411
12891	belgian chocolate liquor	2291
12892	enriched wheat flour niacin	131
12893	thiamine mon	468
12894	color fd&c red #40	677
12895	diacetyl tartaric acid esters of mono and diglycerides	327
12896	soybean and modified palm oils	2426
12897	monog	592
12898	dehydrated lemon juice	18
12899	gelatin. battered and breaded with: bleached wheat flour	459
12900	spice extractive. breading set in vegetable oil.	199
12901	dehydrate chicken broth	41
12902	gelatin. battered and breaded with; bleached wheat flour	459
12903	breading set in vegetable oil.	2427
12904	battered and breaded with: bleached wheat flour	131
12905	spice extractive. breading set in vegetable oil	199
12906	distilled and cider vinegar	480
12907	calcium disodium edta added to protect flavor.	843
12908	sodium saccharin	756
12909	fd&c blue no.1.	2155
12910	fd&c yellow no. 5.	403
12911	brominated vegetable oil fd&c yellow no. 5. fd&c blue no. 1.	1536
12912	fd&c yellow no. 6.	403
12913	vegetable oil canola and soybean	26
12914	whey milk ingredient	193
12915	soy mono- and diglycerides	2428
12916	vegetable oil may contain one or more of the following: canola oil	90
12917	hydrogenated soybean and/or cottonseed oil	243
12918	disodium dihydrogen pyrophosphate to promote color retention	1713
12919	contains 2% or less of mono- and diglycerides	729
12920	guar gum and/or cellulose gum	475
12921	fd&c red #40 lake	677
12922	fd&c yellow #5 lake	403
12923	fd&c yellow #6 lake	2344
12924	fd&c blue #1 lake	852
12925	fd&c red #3	849
12926	fd&c blue #1	852
12927	natural and/or artificial vanila flavor	20
12928	rd 40	2429
12929	fd&c blue #2.	2430
12930	Angus beef	33
12931	encapsulated salt salt	148
12932	roasted in peanut	137
12933	and/or cottonseed	207
12934	and/or sunflower seed	151
12935	and filberts hazelnuts	144
12936	acid	200
12937	sodium bicarbonate leavening	24
12938	curcumin for color	175
12939	sodium benzoate and citric acid preservatives	2431
12940	sorbitol syrup	1099
12941	natural starch	139
12943	contains less than 2% of enzyme modified cheese cheddar cheese cultured milk	32
12944	artificial colo	648
12945	monterey jack cheese cultured milk	1204
12946	slices of cooked beef	33
12947	tomato extract	2432
12948	corn syrup solids. contains 2% or less of each of the following: coconut oil	596
12949	anti-caking agent silicon dioxide	309
12950	canola and soybean oil	26
12951	sodium bicarb	24
12952	ribolfavin	818
12953	cocoa processed with alakli	118
12954	lea	2433
12955	caramel c	452
12956	rainbow chips dark chocolate flavored chips sugar	1
12957	blend of	2434
12958	soybean or canola oil	243
12959	vanil	186
12960	Pink salmon sodium tripoly phosphate to retain moisture.	820
12961	Swai	2040
12962	artificial flavor and mica.	637
12963	yellow #5 blue #1	2160
12964	red #40 lake	677
12965	yellow #6 lake	2344
12966	yellow #5 lake	403
12967	blur#1 lake. confectioners glaze natural and artificial flavor	2435
12968	shortening partially hydrogenated cottonseed and soybean oils	881
12969	with mono and diglycerides added	341
12970	blue #!	2436
12971	meringue powder corn starch	263
12972	sodium aluminium su	1641
12973	cream of	473
12974	Pure cane confectioner's sanding sugar	170
12975	confectioner's glaze and fd&c blue #2.	2437
12976	reduced protein whey milk	2438
12977	carob	800
12978	colors yellow 5	403
12979	soy lecithin natural and artificial flavors	185
12980	hydrogenated soybean oil	243
12981	icing sugar	170
12982	vegetable oil soybean and/or cottonseed oil	243
12983	pr	713
12984	contains less than 2% of: fully hydrogenated vegetable oils rapeseed	187
12985	ann	2439
12986	asadero c	1830
12987	Cultured pasteurized skim milk. contains live and active cultures including s. thermophilus	7
12988	locust bean gum. contains live and active cultures including s. thermophilus	339
12989	natural flavor and citric acid.	200
12990	and calcium chloride. contains live and active cultures including s. thermophilus	340
12991	fruit and vegetable juice concentrates for color and calcium chloride. contains live and active	340
12992	citric acid and calcium. chloride. contains live and active cultures including s. thermophilus	200
12993	and l	1438
12994	vegetable juice concentrate for color	409
12995	l. a	295
12996	parley flakes	22
12997	dehydrated chives.	99
12998	seasoning mix salt	148
12999	less than 2% soybean oil	243
13000	enzymes. cooked beef topping: hamburger beef	920
13001	seasonings salt	148
13002	caramel color. tomatoes	357
13003	degeminated yellow corn meal	149
13004	seasoning blend modified food strach	778
13005	natural falvor	316
13006	srbic acid  preservative	650
13007	enrichement blend  magnesium oxide	1431
13008	pyrioxide hydrochloride	363
13009	pyridoxine hydrochloride vitamin b6.	525
13010	mozzarella cheese blend; mozzarella cheese substitute water	531
13011	zinc code	2440
13012	enzymes. cooked pork pork and chicken pizza topping: sausage made with pork and chicken pork	192
13013	con syrup solids	750
13014	contains 2% or less of lactic acid starter culture	2441
13015	may also contain 2% or less of spices	834
13016	water garlic powder.	1343
13017	soy flour sauce: water	547
13018	mozzarella cheese blend: mozzarella cheese substitute water	531
13019	pyrdoxine hydrochloride	525
13020	niacinamde	466
13021	low-moisture part-skim mozzarella cheese water	531
13022	citric acid. may also contain 2% or less of spices	200
13023	parmesan cheese cultured mil	62
13024	modified food starch. cheese blend: cheddar cheese pasteurized milk	778
13025	imitation cheddar cheese water	5
13026	vitamin b12. cooked beef topping: hamburger beef	1191
13027	Cupcake mix: sugar	1
13028	dried pumpkin	559
13029	mono and diglcerides	729
13030	food starch-modi	778
13031	Cup cake mix: enriched cake flour wheat flour. malted barley flour	131
13032	dried apple	738
13033	mono and digycerides	729
13034	enriched cake flour wheat flour	131
13035	bak	698
13036	Marshmallows: corn syrup	596
13037	tetrasodium pyrophosphate. crispy rice cereal: milled rice	879
13038	corn and barley malt extract. icing pen: sugar	391
13039	partially hydro	1142
13040	Cookie mix: enriched wheat flour wheat flour	131
13041	Mocha cupcake mix: enriched cake flour wheat flour	131
13042	natural and artificial coffee flavor	550
13043	cocoa processed with alka	118
13044	baking powder sodium acid pyrophosphat	780
13045	monocalcium phospha	381
13046	cocoa cocoa processed with alkali	118
13047	soy lecithin and artificial flavor.	185
13048	partially hydrogenated vegetables oil cottonseed and/or soybean oil	881
13049	yellow 6 and artificial flavor.	643
13050	may contain yellow 6	403
13051	beta	2442
13052	contains 2% or less of	834
13053	contains 2% or less of: food starch-modified	778
13054	cocoa processed with al	118
13055	ramano	2443
13056	whet protein concentrate	2444
13057	disodium inosinate & disodium guanylate	1039
13058	artificial maple flavor.	2191
13059	disodium inosinate and disodium gu	2445
13060	artificial color yellow 6	403
13061	Enriched cornmeal cornmeal	149
13062	bu	2446
13063	wheat oat	78
13064	niacinamid	466
13065	niacinamide: zinc	1492
13066	vitamin b6 propylene hydrochloride	2447
13067	vitamin b2 riboflavin vitamin b1 thiamine mononitrate	468
13068	vitamin b6 pyridoxin	525
13069	vitamin a palm	590
13070	tripotassium phosphate almonds	2207
13071	vitamin b6 pyridoxine hydr	525
13072	spices including paprika & turmeric for color and spice	55
13073	tricalcium phosphate to make free flowing	751
13074	and red lake #40.	677
13075	calcium chloride. contains five live active cultures including s. thermophilus. l.	340
13076	and turmeric for color. contains five live active cultures including s. thermophilus	867
13077	partially hydrogenated soybean and/or cottonseed oil and less than 2% of sodium caseinate a milk derivative	243
13078	and less than 2% of natural and artificial flavors	940
13079	and less than 2% of sodium caseinate a milk derivative	640
13080	corn syrup solids partially hydrogenated soybean and/or cottonseed oil and less than 2% of sodium caseinate a milk derivative	243
13081	palm oil and/or interesterified soybean oil	243
13082	contains 2% or less of the following: cocoa processed with alkali	118
13083	contains 2% or less of the following: high fructose corn syrup	344
13084	ammonium bicarbonate monocalcium phosphate.	634
13085	contain less 2% of beef stock	1930
13086	salt. contains 2% or less of each of the following: natural flavor	140
13087	contains 2% or less of each of the following: natural flavor	210
13088	folic acid. water egg	727
13089	cocoa powder processed with alkali modified corn starch	118
13090	leavening sodium acid pyrphosphate	780
13091	Wild caught american shrimp	86
13092	Contains: shrimp	86
13093	crunchy rice milled rice	64
13094	salt. barley malt	2448
13095	alpha tocophe	154
13096	chocolate chips semi-sweet chocolate sugar	1
13097	vanilla baking soda.	24
13098	Crust: enriched wheat flour flour	131
13099	gum arabic cellulose gum	390
13100	confectioner's glaze carrageenan	206
13101	titaniium dioxide	369
13102	blue 2 lake and artificial flavor.	2449
13103	cheese culture carrageenan	206
13104	whole flour	131
13105	strawberry puree soybean oil	1879
13106	dry milk	1182
13107	veget	2450
13108	nonfat dairy milk	887
13109	contains less than 2% of each of vegetable mono	2451
13110	Enriched wheat flour flour wheat flour	131
13111	raspberry filling water	5
13112	cellul	740
13113	contains 2% or less of: maragarine palm oil	201
13114	pickle relish pickles	1898
13115	corn sweeteners	596
13116	salted bell pepper	536
13117	natural spice flavors	199
13118	edta	455
13119	contains less than 2% of the following: nonfat milk. dairy	887
13120	whey butter	193
13121	tapioca de	2088
13122	t	420
13123	ta	420
13124	contains less than 2% of the following: food starch-modified	778
13125	soybean and/or palm oil	243
13126	less than 2% of cocoa processed with alkali	118
13127	less than 2% of sodium caseinate a milk derivative	847
13128	rhubarb	2452
13129	contains 2% or less of: eg	2453
13130	canola and/or soybean and/or palm	26
13131	contains 2% oe less of: baking soda	24
13132	natural lem	18
13133	dark chocolate flavored confectionary chip sugar	1
13134	cocoa powder processed	118
13135	Cashwes	145
13136	peanut and/or cottonseed and/or sunflower seed and/or canola oil	26
13137	cottonseed and	583
13138	Enriched bleached wheat four wheat flour	131
13139	partially hydrogenated vegetable oil  cottonseed and/or soybean	881
13140	natural and arti	1403
13141	vegetable oil palm kernel and/or palm oil	201
13142	natural and ar	650
13143	confectioner's glaze corn syrup	596
13144	bleached wheat flour wheat flour	131
13145	short	1
13146	margarine soybean and modified palm oil	243
13147	fo	8
13148	shortening palm	201
13149	orange puree	1122
13150	leavening sodium ac	258
13151	leavening sodium acid pyrophospha	780
13152	fd&c red #3 and fd&c blue #1 lake.	2454
13153	haydrogenated palm kernel oil	286
13154	fd&c blue #1 lake.	852
13155	glaze	1818
13156	yellow #6 lake.	2344
13157	fd&c yellow #5 and fd&c yellow #5 lake.	403
13158	cornstarch hydrogenated palm kernel oil	286
13159	fd&c red #40 lake.	677
13160	cocoa processed w/ alkali	118
13161	food starch - modified	778
13162	caramel colo	357
13163	contains less than 2%: mustard distilled vinegar	73
13164	and annatto color.	722
13165	dried red and green bell peppers	536
13166	romano cheese from cow's milk cultured	969
13167	degerminated yellow c	134
13168	hydrogenated vegetable oils coconut and palm kernel oils	1588
13169	less than 2% of sodium caseinate from milk artificial flavor	847
13170	malic acid for tartness.	345
13171	vitamin cascorbic acid	329
13172	calcium chloride to maintain firmness.	340
13173	calcium chlorideto maintain firmness	340
13174	and ascorbic acid.	329
13175	Ingredients: prepared red kidney beans	1602
13176	wholeeggs	14
13177	contains 2% or less of the following: modified corn starch	332
13178	contains 2% or less of soybean oil	243
13179	color yellow 6 lake	794
13180	Prepared from meat fats and vegetable oils with mono and diglycerides	292
13181	bha and bht added to help protect flavor	1857
13182	Peanut and soybean oil.	741
13183	processed with alkali	2455
13184	preservative sodium benzoate	354
13185	natural and artificial strawberry flavors	1640
13186	animal and vegetable shortening contains one or more of the following: beef fat	1319
13187	lard	704
13188	soybean oil with emulsifier mono- and diglycerides	243
13189	and preservative tbhq	1955
13190	contains 2% or less of: natural and artificial flavor	316
13191	Specially processed degerminated white corn grits	134
13192	sodium phosphate. sugar	2456
13193	natural and artificial flavorings	196
13194	Apple juice water and apple juice concentrate	322
13195	Bleached enriched wheat flour niacin	131
13196	grape juice water	150
13197	cottonseed and soybean salt and corn syrup.	148
13198	sodium hexametaphosphate and citric acid.	2457
13199	thiamin mononitrate{vitamin b1}	1085
13200	riboflavin{vitamin b2}	248
13201	contains two percent or less of: corn flour	165
13202	contains two percent or less of corn flour	165
13203	paprika and paprika extracts	195
13204	paprika color and spice	55
13205	mace	2076
13206	and bay.	114
13207	mono- and diglycierdes	729
13208	fudge sauce water	5
13209	locust bean gum and carrageenan.	2458
13210	annatto color and artificial color blue 1	722
13211	calcium stearoyl-2-lactylate.	884
13212	contains less than 2% of molasses	156
13213	crushed oranges	103
13214	tamarind extract.	453
13215	soya lecithin an emulsifier and vanillin an artificial flavoring	185
13216	cherries treated with sulfur dioxide a preservative	189
13217	Milk chocolate sugar. cocoa butter	171
13218	chocolate. soya lecithin an emulsifier and vanillin an artificial flavoring	118
13219	cherries treated with sulfur dioxide a preservative. sugar	306
13220	sodium benzoate a preservative. artificial flavor	454
13221	calcium chloride and artificial color fd&c red 40.	340
13222	Semi-sweet chocolate {sugar	1
13223	soy lecithin an emulsifier}	185
13224	artificial c	648
13225	Semi sweet chocolate sugar	1
13226	chocolate processed with alkali cocoa butter	171
13227	soy lecithin - an emulsifier vanillin an artificial flavor	185
13228	corns syrup	750
13229	artificial color fd&c red 40	677
13230	milk.	7
13231	Milk chocolate {sugar	1
13232	vanillin an artificial flavor}	186
13233	partially hydrogenated cottonseed and soy oil	881
13234	and sodium propionate preservatives	1601
13235	glucono delta-lactone	1444
13236	sodium stearyl lactate	2459
13237	vegetable oil palm and/or soybean	26
13238	sodium propionate and citric acid preservatives	2460
13239	di-alpha-tocopherol.	169
13240	contains less than 2% of the following: food starch - modified	746
13241	potassium sorbate and sodium propionate preservatives	2461
13242	l-cysteine enzymes.	951
13243	nonfat dry-milk	801
13244	contains less than 2% of the following: natural flavor	210
13245	corn syrup; contains less than 2% of the following: modified food starch	596
13246	contains less than 2% of the following: dairy whey	2412
13247	and potassium sorbate preservatives.	338
13248	dextrose salt	750
13249	mono- and diglycerdes	446
13250	artificial color. sodium benzoate and sodium propionate preservatives.	795
13251	food-starch modified	778
13252	sodium propionate and potassium sorbate	2462
13253	preservatives.	402
13254	dairy whey rice syrup	2463
13255	sodium propionate and potassium sorbate preservatives.	2462
13256	butylated hydroxyl anisole	1367
13257	natural color turmeric and annatto	1091
13258	glucono delta lactose	516
13259	potassium sorbate and sodium propionate preservatives.	2461
13260	contains less than 2% of the following: rice flour	138
13261	yellow color #375	1744
13262	food starch-modifed	778
13263	sodium propionate and sodium benzoate preservatives.	2464
13264	fresh lemon juice	200
13265	red wine vinegar water	73
13266	contains sulfites	397
13267	italian parsley	22
13268	Apricot preserve apricot	275
13269	hoisin sauce sugar	1
13270	sweet potato	370
13271	sea salt and spices.	148
13272	hydrogenated oil rapeseed and/or cotton seed and/or soybean	187
13273	curry powder	133
13274	plums contains sulfites	397
13275	peppadew peppers	2465
13276	red bell peppers cornstarch	536
13277	garlic sea salt	148
13278	chili peppers.	195
13279	natural lemon oil	910
13280	natural spinach extract color	1445
13281	Seasoned tomatoes tomatoes	19
13282	roasted portabella mushrooms	2466
13283	roasted roma tomatoes	240
13284	cajun spice	2467
13285	red chili powder	195
13286	sun-dried tomatoes lemon juice from concentrate	19
13287	contains less than 2% of olive oil	6
13288	natural flavorings soy lecithin.	185
13289	pineapples	63
13290	coconut cream with natural stabilizers	2468
13291	apricot concentrate	275
13292	tequila	384
13293	white sugar	170
13294	Ingredients: distilled vinegar	480
13295	red raspberry vinegar white vinegar	480
13296	horseradish root	212
13297	toasted garlic	4
13298	minced onions	9
13299	calcium disodium edta added to prote	455
13300	pineapples pineapples	63
13301	pineapple juice citric acid	200
13302	pineapples pineapple	63
13303	garlic olive oil	6
13304	worcestershire sauce molasses	156
13305	dijon mustard distilled vinegar	73
13306	crushed red chili peppers.	195
13307	natural flavoring and color	2469
13308	dillweed	840
13309	hatch chile peppers green chile peppers	1365
13310	monocalcium phosphate monohydrate a leavening agent.	259
13311	palm oil cheese culture	1106
13312	apocarotenal color	773
13313	mint candy corn syrup	596
13314	natural oil of peppermint	458
13315	bleu cheese	2470
13316	parsley flakes and calcium disodium edta added to protect flavor.	22
13317	high fructose com syrup	344
13318	potassium sorbate and sodium benzoate as preservatives0	2471
13319	parsley flaked and calcium disodium edta added to protect flavor.	22
13320	palm oil brown sugar	1
13321	sodium benzoate and potassium	354
13322	monocalcium phosphate monohydrate leavening agent	259
13323	pectin lemon juice from concentrate	337
13324	monocalcium phosphate monohydrate.	259
13325	tomato juice citric acid	200
13326	heirloom tomatoes heirloom tomatoes	240
13327	watermelon	2085
13328	and ginger.	28
13329	peppadew peppers piquante peppers	2472
13330	beer hops	530
13331	mascarpone cheese milk and cream	2473
13332	mozzarella flavor cheese cult	531
13333	gingerbread cookies enriched flour wheat flour	131
13334	vegetable shortening soybean and/or cottonseed oil	26
13335	ginge	28
13336	lime juice contains sulfites	397
13337	monocalcium phosphate monohydrate leavening agent.	259
13338	red raspberry vinegar distilled vinegar	480
13339	red raspberry puree	208
13340	red raspberry preserves red raspberry puree	208
13341	candied ginger	28
13342	seedless raspberry preserves raspberry puree	208
13343	Champagne garlic honey mustard sugar	4
13344	champagne	2474
13345	grapefruit puree grapefruit juice and/or grapefruit concentrate	2475
13346	citrus pulp cells	1636
13347	grapefruit oil	2476
13348	hoisin sauce soybeans	277
13349	turmeric and paprika color	1080
13350	ghost chile pepper flakes	195
13351	celery seeds.	2477
13352	worcestershire flavor maltodextrin	197
13353	lemon juice c	200
13354	champagne vinegar	2478
13355	ground cayenne pepper	195
13356	calcium d	203
13357	Dill pickles cucumbers	122
13358	alum and benzoate of soda as a preservative	2479
13359	garlic paprika and turmeric color	2480
13360	Yellow mustard vinegar	73
13361	shishito peppers	2481
13362	bourbon	878
13363	soy lecithin as an emulsifier.	185
13364	chipotle chiles	1363
13365	crushed red chill peppers	195
13366	dijon mustard grain vinegar	73
13367	cream grade a cream	473
13368	whiskey	384
13369	white miso whole soybeans	277
13370	sun-dried sea salt	98
13371	blue pepper	12
13372	orange extract	2482
13373	lemon extract	2483
13374	natural onion flavor	9
13375	chardonnay wine	2484
13376	orange flavor	649
13377	alcohol to preserve freshness	384
13378	jalapeno pepper sauce red ripened jalapeno peppers	725
13379	lemon juice concentrate.	200
13380	merlot wine	2485
13381	habanero peppers.	836
13382	crushed red chili peppers	195
13383	shortening partially hydrogenated soybean and cotton seed oils	881
13384	Wheat flour wheat flour	131
13385	buttermilk powder cultured buttermilk	72
13386	dried wild blueberries wild blueberries	411
13387	natural meyer lemon flavor	29
13388	vanilla powder	20
13389	Mix packet: wheat flour wheat flour	131
13390	ground chocolate chocolate liquor and cocoa powder processed with alkali	118
13391	van	20
13392	Gluten free brown rice	305
13393	all natural fried rice sauce water	5
13394	soy sauce - gluten free - less sodium water	39
13395	organic vinegar.	480
13396	seasoning blend dehydrated onion	9
13397	less t	2486
13398	Gluten free cooked long grain brown rice	305
13399	fried rice sauce water	5
13400	fried rice seasoning dehydrated onion	9
13401	un-sulfured molasses.	156
13402	all natural cooked chicken breast boneless skinless chicken breast with rib meat	117
13403	seasoning tapioca and potato starch	757
13404	chicken broth powder	41
13405	all natural general tso sauce water	5
13406	seasoning blend sugar	1
13407	gluten free soy sauce powder {fermented soybeans	39
13408	refiners syrup	471
13409	sweet pepper flaked	195
13410	less than 2% silicon dioxide added as a processing aid.	631
13411	natural fully cooked chicken breast meat boneless skinless chicken breast with rib meat	117
13412	Filling: white meat chicken	57
13413	may contain tbhq and citric acid to help preserve freshness and dimethylpolysiloxane added to reduce foaming.	1595
13414	flavor enhancer maltodextrin	197
13415	lemon flavor citric acid	200
13416	bleached wheat flour enriched niacin	131
13417	enriched corn flour niacin	466
13418	vegetable shortening partially hydrogenated soybean and/or cottonseed oil	881
13419	may contain mono and diglycerides and/or tbhq and citric acid to help preserve freshness and dimethylpolysiloxane added to reduce foaming.	341
13420	calcium propionate as a preservative	911
13421	cornstarch with tricalcium phosphate added	263
13422	bicarbonate sodium	258
13423	acid phosphate of calcium.. sauce: water	2487
13424	pineapple juice pineapple juice and ascorbic acid.	650
13425	less than 0.1% sodium benzoate as a preservative.	354
13426	textured vegetable protein	1532
13427	sriracha flavor red pepper	195
13428	natural flavor contains milk. crust: wheat flour	131
13429	thai chili flavor red pepper flakes	195
13430	natural flavoring. crust: whea	407
13431	natural flavor spices	834
13432	disodium gyanylate. crust	1002
13433	natural flavoring natural flavor	407
13434	and m	652
13435	white meat chicken	117
13436	textures vegetable protein	1532
13437	natural flavor contains milk.. crust: wheat flour	131
13438	and green onion.. crust: wheat flour	870
13439	parboiled rice	1411
13440	cooked chicken - gluten free white chicken meat	57
13441	fried dehydrated onion dehydrated onion	9
13442	Chow mein noodles water	5
13443	vegetable mix cabbage	113
13444	rapeseed flower.	2488
13445	Chow mein noddle water	5
13446	vegetable mix olyster mushrooms	46
13447	black mushrooms	2489
13448	champignon mushrooms	2490
13449	asparagus.	1371
13450	wheat.	143
13451	basil puree	48
13452	Filling: pork	534
13453	autolyzed yeast extract flavoring	209
13454	and tbhq.	1082
13455	cornstarch with tricalcium phosphate added. sauce: water	263
13456	less than 0.1% sodium benzoate a preservative.	354
13457	natural spice	198
13458	flavor enhancer natural flavor	2491
13459	maltodextrin. crust: wheat flour	197
13460	cornstarch. sauce: water	263
13461	shrimp shrimp	86
13462	sodium tri-polyphosphate to retain moisture	2058
13463	vegetable oil soybean oil with tbhq and citric acid added as preservatives.	243
13464	natural flavoring contains maltodextrin salt	2492
13465	artificial lemon flavor citric acid	200
13466	vegetable shortening partially hydrogenated soybean oil.	243
13467	cornstarch cornstarch	263
13468	tricalcium phosphate.. sauce: water	751
13469	sesame oil. crust: wheat flour	112
13470	may contain tbhq and citric acid to help preserve freshness and dimethylpolysiloane added to reduce foaming.	358
13471	and protein with no greater than 2% vegetable oil added to prevent caking.. crust: enriched bleached wheat flour bleached wheat flour enriched niacin	131
13472	natural flvor	316
13473	less than 1/10 or 1% sodium benzoate & edta.	354
13474	dried red peppers	195
13475	less than 1/10 of 1% sodium benzoate & edta.	354
13476	Natural coconut water	438
13477	aloe vera.	2493
13478	Brewed thai tea water	5
13479	thai tea	365
13480	natural cane sugar	170
13481	Brewed thai coffee water	5
13482	thai coffee	550
13483	natural cane juice	170
13484	non-dairy creamer corn syrup solids	596
13485	sodium metabisulfite e223 as anti-oxidant.	397
13486	Coconut juice	438
13487	coconut meat	68
13488	sodium metabisulfite e223 as anti-oxidant	426
13489	coconut pulp.	2494
13490	fd&c yellow no6	403
13491	red chilli	195
13492	natural coconut nectar	609
13493	natural lime flavor.	85
13494	chili extract	195
13495	Coconut water	438
13496	matcha green tea.	2495
13497	Dried rainier cherries with nothing added.	865
13498	Milk and semisweet chocolate sugar	2496
13499	chocolate liquor processed with potassium carbonate	118
13500	cacao beans	2497
13501	pure vanilla	20
13502	dried montmorency cherries cherries	2498
13503	cocoa processed with potassium carbonate	118
13504	Semisweet chocolate cacao beans	2499
13505	roasted pistachios	320
13506	dried bing cherries.	865
13507	Cultured pasteurized grade a lowfat milk	7
13508	pectin. contains active lactobacillus bulgaricus and streptococcus thermophilus cultures.	337
13509	natural and artificial flavors replaced with natural flavors for passover. contains active lactobacillus bulgaricus and streptococcus thermophilus cultures.	2500
13510	coffee. contains active lactobacillus bulgaricus and streptococcus thermophilus cultures.	550
13511	sour cream pasteurized cultured grade a nonfat milk	25
13512	carob seed gum	205
13513	enzyme eg	330
13514	preservatives sodium propionate	1601
13515	contains less than 2% of each of the following: vegetable shortening palm oil	2501
13516	sorbitan monstearate	2502
13517	natural & artificial flavor.	316
13518	contains less than 2% of each of t	397
13519	contains less than 2% of each of the following: pumpkin puree	559
13520	sodium benzoate as preservati	354
13521	Wheat flour whole wheat flour and enriched flour niacin	131
13522	evaporated apples treated with sulfur dioxide to preserve c	1074
13523	evaporated apples treated with sulfur dioxide to preserve	1074
13524	contains less than 2% of each of the following: evaporated apples treated with sul	306
13525	contains less than 2% of each of the following: sal	594
13526	evaporated apples treated with sulfur dioxide to preserve color	1074
13527	contains 2% or	306
13528	contains less than 2% of e	185
13529	Parmesan cheese made from cow's milk aged over 10 months	62
13530	romano cheese made from sheep's milk aged over 5 months	969
13531	potassium sorbate added to protect flavor.	338
13532	Pork & beef	1376
13533	flavorings spice &spice extractives	198
13534	yellow 5 yellow 6	786
13535	artificial vanilla flavor.	20
13536	fruit juice from concentrate apple	322
13537	confectioner's glaze shellac	289
13538	fd&c 3	849
13539	titanium dioxide {color	369
13540	partially hydrogenated vegetable oils palm kernel	1926
13541	blue 1 freshness preserved b	1692
13542	vegetable oil palm kernel and/or palm	201
13543	sunflower lecithin an emulsifier	185
13544	blue 1 lake.	885
13545	artificial and natural cinnamon flavors	15
13546	sucralose splenda brand.	399
13547	whole milk powder.	405
13548	lipolyzed milkfat	2503
13549	ethyl vanillin	186
13550	carbauba wax	2504
13551	cottonseed and/or palm kernel	286
13552	partially hydrogenated vegetable oil soybean cottonseed and/or palm kernel	881
13553	soybean and cottonseed	243
13554	emulsified with soy lecithin	185
13555	bifidolactis	2505
13556	l. rhamnosus	2506
13557	l. casei	1998
13558	fruit & vegetable juice for color	1770
13559	vitamin a palmitate. vitamin d3 and live active cultures s. thermophilus	1171
13560	bifido. lactis	2505
13561	l.casei.	2507
13562	Plum tomatoes tomato juice	240
13563	oregano.	42
13564	Lingonberries	2508
13565	black currant juice	2094
13566	concentrated black currant juice	2094
13567	Sour cherries	2509
13568	Grade a pasteurized organic lowfat milk	7
13569	organic inulin	1220
13570	lactase	1186
13571	vitamin d3 and live active cultures s. thermophilus	1189
13572	organic raspberry flavor	636
13573	red cabbage for color	237
13574	bifido. lactus	2505
13575	organic lnulin1	1220
13576	lactase2	1186
13577	l. acidphilus	867
13578	bifido	2510
13579	lactis	295
13580	l. casel.	295
13581	Ingredients: grade a pasteurized milk	7
13582	marionberries	2511
13583	marionberry juice concertrate	2511
13584	vegetable and fruit juice for color	343
13585	thermophilus	2512
13586	l bulgarlcus	867
13587	sifielo	170
13588	l rhamnosus	2506
13589	l casel	951
13590	Ingredients: grade a pasteurized milk and skim milk	7
13591	l.rhamnosus	2506
13592	Grade a pateurized milk and skim milk	7
13593	Grade a pasteurized milk and skim milk	7
13594	l. rhamnosus. l. casei.	2513
13595	Ingredients: cultured pasteurized grade a milk	7
13596	wild blueberries	2025
13597	organic topica starch	757
13598	black current juice concentrate for color	237
13599	bifido.lactus	2505
13600	l casel.	951
13601	natural honey powder cane sugar	1
13602	l.casel.	640
13603	and live active cultures s. thermophilus	1389
13604	l. rhamnous	2514
13605	vitamin d3 and live active cultures s. themophilus	2515
13606	l builgaricus	2516
13607	bifidio lactis	2505
13608	l rihandsus	18
13609	l case.	951
13610	fruit juice	2517
13611	for color	888
13612	l. casie.	951
13613	annatto extract for color. vitamin a palmitate	590
13614	Cultured pasteurized grade a nonfat maltodextrin	197
13615	l. balgaricus	2518
13616	honey powder sugar	1
13617	Cultured cultured pasteurized grade a nonfat milk	7
13618	Cultured pasteurized grade a milk and cream	7
13619	basmati rice	1718
13620	yogurt cultured pasteurized skim milk	7
13621	tomatoes tomato juice	240
13622	tur	383
13623	Chicken curry-chicken breast	117
13624	onion tomatoes whole peeled tomatoes	9
13625	cream canola oil	90
13626	dextrose/dextrin	678
13627	green chili paprika oleoresin	725
13628	fenugreek leaves. rice-water	232
13629	Chicken tikka masala - chicken breast	117
13630	tomatoes whole peeled tomatoes	240
13631	clarified butter	2519
13632	fenugreek leaves	232
13633	mango powder. rice - water	2520
13634	cumin seeds.	43
13635	100% clarified butter	2521
13636	noodles rice flour	138
13637	jaggery a natural unrefined brown palm sugar	2522
13638	tofu water	5
13639	vinegar 'chinese' broccoli	116
13640	wheat-free soy sauce water	5
13641	paneer pasteurized whole milk	2523
13642	clarified butter.	2519
13643	bay leaves.	107
13644	Gram	2524
13645	Kofta curry: water	5
13646	squash	2378
13647	wheat farina	131
13648	Matpe beans	2525
13649	Moong beans.	2526
13650	Red chili 60%	195
13651	salt 11%	140
13652	fennel seeds 5% mustard	2527
13653	preservative sodium benzoate e211	354
13654	Green chilli 70%	195
13655	mustard 6%	95
13656	sodium benzoate e211.	354
13657	Sorghum	2112
13658	Mango 65%	190
13659	red chilli powder	195
13660	preservative sodium benzoate e211.	354
13661	Lime 45%	61
13662	sugar 35%	170
13663	jaggery 10%	2528
13664	Mango 25%	190
13665	lime 25%	85
13666	carrot 10%	119
13667	green chilli 8%	2529
13668	fresh turmeric	828
13669	gunda gumberry	2530
13670	Sugar 55%	170
13671	mango 42%	190
13672	clove	1655
13673	cardamom	230
13674	cardamon	230
13675	preservatives sodium benzoate e211.	354
13676	Mango 45%	190
13677	sugar 30%	170
13678	Lime 70%	200
13679	salt 12%	140
13680	tamarind 14%	453
13681	fenugreek 14%	232
13682	chilli 11%	195
13683	salt 7%	148
13684	Tamarind 20%	453
13685	coriander 10%	106
13686	cumin 5%	43
13687	lentil	1891
13688	turmeric ginger	383
13689	mangoes 42%	190
13690	sodium benzoate preservative e211.	354
13691	Dry dates	159
13692	Pressed rice - thick.	1411
13693	Kerda berry 70%	2531
13694	red chilli powder.	195
13695	black pepper bay leaves	12
13696	tamarind 11%	453
13697	red chilli powder 5%	195
13698	condiments	2532
13699	Tomaoes 36%	240
13700	coriander powder 12%	106
13701	cumin powder	43
13702	fenugreek powder	232
13703	Ginger 80%	28
13704	salt 8%	140
13705	emulsifier xanthan gum e415	265
13706	Chick pea flour	667
13707	coriander seeds	106
13708	caraway	521
13709	fennel seeds.	231
13710	Chickpea flour 80%	667
13711	sugar 8%	1
13712	Split moong beans	2533
13713	sodium bicarbonate citric acid.	2534
13714	moong beans	2526
13715	Rice flour 55% chickpea flour 19%	2535
13716	matpe beans flour urad dal 18%	2536
13717	Rice flour 64%	138
13718	matpe beans flour urad dal 15%	2536
13719	wheat flour 15%	131
13720	hydrogenated vegetable oil	1001
13721	Rice flour 72%	138
13722	matpe beans flour urad dal 19%	2536
13723	Ginger 40%	28
13724	garlic 40%	4
13725	Filling: potatoes	34
13726	green chilli	2529
13727	coriander leaves. pastry: wheat flour	106
13728	pomegranate juice 35%	406
13729	sugar 7%	1
13730	aronia juice concentrate	1721
13731	microbial cultures	987
13732	tomato puree tomatoes	487
13733	coriander leaves	2081
13734	green chill peppers	195
13735	paneer cheese pasteurized milk	1209
13736	Cultured pasteurized low fat milk	7
13737	vitamins & minerals added.	2537
13738	live & active probiotic bifidus with s. thermophilus	2538
13739	l. bulgaricus yogurt cultures	1390
13740	rose flavor	2539
13741	natural beet color	768
13742	Cultured pasteurized skim milk & cream	7
13743	natural rose flavor	2539
13744	vitamins & minerals.	2540
13745	Arachides.	173
13746	roasted split chickpeas	1150
13747	corn oil and/or canola oil	26
13748	curry leaves	2541
13749	unbleached unbromated wheat flour	131
13750	preservatives: les than 1% calcium propionate	911
13751	potassi	1340
13752	Stone ground whole wheat	802
13753	high protein flour	2542
13754	m water	5
13755	wheat flour lactic acid	295
13756	preservatives: less than 1% calcium propi	911
13757	pre	1
13758	coriander.	106
13759	Wheat flour 56%	131
13760	milk 5%	7
13761	Kesar mango pulp	2543
13762	Unrefined cane sugar 99%	170
13763	sulphite.	426
13764	sulfite.	306
13765	Rajgaro amaranth.	168
13766	Puffed sorghum	2112
13767	Rice flour 90%	138
13768	palmolien oil	201
13769	palmolein oil	201
13770	Rice flour 90% palmolien oil	138
13771	salt green chili	148
13772	Wheat flour 60%	131
13773	hydrogenated vegetable oilcontains one or more of the following: sesame oil	112
13774	soybean oil palm oil	201
13775	hydrogenated vegetable oil contains one or more of the following: sesame oil	112
13776	Whole soya bean	256
13777	spices. mango powder	2520
13778	asafoetida.	2544
13779	green chili	1250
13780	jaggery	2528
13781	xanthum gum emulsifier	265
13782	fd&c red no. 40 allura red.	416
13783	Mint leaves	2243
13784	xantham	265
13785	gum emulsifier	292
13786	spearmint oil	2545
13787	fdc blue no. 1 brilliant blue fcf	375
13788	fd&c yellow no. 5 tartrazine.	403
13789	fd&c blue no.1 brilliant blue fcf	375
13790	fd&c yellow no.5 tartrazine.	403
13791	green chili ginger	28
13792	xanthan gum emulsifier	265
13793	fd&c blue no. 1 brilliant blue fcf	375
13794	Wheat flour 82%	131
13795	sago starch 8%	2546
13796	tapioca starch 8%	757
13797	fenugreek.	2547
13798	palmolein oil.	201
13799	Peanuts 53%	173
13800	sugar 21%	170
13801	jaggery 11%	2528
13802	palmolien oil.	201
13803	Mango 60%	190
13804	corn oil 14%	307
13805	garlic 6%	4
13806	red chilies 5%	195
13807	asafoetida	2544
13808	preservative e211 sodium benzoate.	354
13809	Peanuts 70%	137
13810	gram flour 20%	2548
13811	Gram flour	2548
13812	red chili salt	148
13813	Rice flour 57%	138
13814	chickpea flour 17%	667
13815	sesame	153
13816	seeds	1873
13817	Wheat flour 85%	131
13818	split chickpeas	222
13819	cashew nuts	145
13820	mustard seeds.	395
13821	iodised salt	148
13822	edible gum	390
13823	yellow peas flour	2549
13824	matpe beans flour	2549
13825	chilli	195
13826	Carrot 60%	119
13827	salt 10%	148
13828	green chilli 5%	195
13829	Fresh turmeric 60%	828
13830	Organic pure maple syrup	102
13831	freeze dried raspberries	208
13832	organic butter flavor diacetyl free organic annatto color.	2052
13833	Ingredients: organic pinto beans.	1268
13834	organic dehydrated cane syrup solids	170
13835	organic dehydrated apples treated with ascorbic acid	650
13836	citric acid and calcium chloride to preservative color	200
13837	organic maple sugar	950
13838	organic mustard seeds	395
13839	Organic sweet potatoes	370
13840	Organic squash	2378
13841	organic apple puree	1690
13842	organic chicken	57
13843	organic brown rice flour.	261
13844	organic raspberry puree	1691
13845	organic blueberry flavored nuggets organic powdered sugar	1
13846	organic corn flour	165
13847	vegetable extracts purple carrot	2550
13848	organic blueberry powder	411
13849	organic eggs.	3
13850	vegetable oil canola and or safflower and/or sunflower oil	26
13851	cherry base cherries	189
13852	red beet c	174
13853	organic roasted garlic	4
13854	organic dried onion	9
13855	organic dried garlic	4
13856	organic dried basil	48
13857	organic parmesan cheese cultured organic milk	62
13858	organic mango puree	1226
13859	expeller-pressed canola oil	90
13860	coconut unsulphured	68
13861	crisp rice with sugar	1
13862	almonds walnuts natural banana flavor	60
13863	milled sesame seeds	153
13864	soy flakes	142
13865	soy grits	2551
13866	soy powder	1291
13867	flax seed meal	916
13868	cultured wheat starch and wheat flour	131
13869	cheddar cheese solids	2306
13870	natural flavor includes enzyme modified parmesan cheese solids	62
13871	distilled white vinegar.	480
13872	Macaroni product wheat flour	131
13873	cheese sauce mix cheddar cheese cultured pasteurized milk	32
13874	organic prune puree	2552
13875	organic corn starch.	263
13876	salt and spices.	140
13877	spices turmeric	383
13878	chickpeas chi	222
13879	organic red and green chard and organic baby kale.	841
13880	Organic hearts of romaine.	1815
13881	organic cauliflower	1041
13882	organic carrots.	119
13883	organic edamame shelled.	1594
13884	organic chopped green jalapeno chili peppers	195
13885	Prepared organic great northern beans	1433
13886	Prepared organic pinto beans	1268
13887	Prepared organic cannellini beans	1407
13888	organic pear juice concentrate citric acid	200
13889	organic tomato juice water	450
13890	Organic sesame seed.	1967
13891	Vegetables green beans	1044
13892	romanesco	2553
13893	grilled red bell peppers	84
13894	garden peas	560
13895	sauce vegetable oil sunflower oil	147
13896	emulsifier {canola lecithin}	185
13897	thickness x	2554
13898	Seasoned semolina durum wheat semolina	451
13899	water extra virgin olive oil	5
13900	seasoned bulgur and quinoa bulgur	914
13901	cooked red quinoa water	2027
13902	red quinoa	167
13903	vegetable md grilled zucchini	87
13904	yel	2555
13905	black pepper. wrapper ingredients: water	10
13906	th	1085
13907	extractive of spices	199
13908	natural hickory smoked flavoring	2556
13909	extractive of paprik	934
13910	pineapple juice pineapple juice	497
13911	sodium benzoate: less than 1/10 of 1% as a preservative	354
13912	spices sodium nitrite.	367
13913	malt vinegar diluted with water to 5% acidity	480
13914	soy protein concentrate.	276
13915	kona coffee cold brewed	550
13916	chocolate covered chips	56
13917	natural color	1637
13918	mango pieces	190
13919	vegetable oil corn oil and/or sunflower oil	26
13920	modified corn starch and extracts of paprika	2557
13921	oil peanut oil	741
13922	or sunflower oil	147
13923	seasoning: salt	148
13924	torula yest	1557
13925	modified corn starch and extractives of paprika.	332
13926	vegetable oil corn oil or sunflower oil	26
13927	dehydrated mango powder	190
13928	honey powder maltodextrin & honey	197
13929	vegetable oil  corn oil and/or sunflower oil	26
13930	honey powder refinery syrup	36
13931	oleoresin turmeri	175
13932	corn oil or sunflower oil	26
13933	sugar sodium diacetate	1062
13934	corn gluten & wheat gluten proteins	326
13935	vegetable oil sunflower oil or corn oil	26
13936	natural flavors includes smoke	2558
13937	citric acid and extractives of paprika.	2559
13938	VEGETABLE OIL PEANUT OIL	741
13939	honey powder maltodextrin and honey	36
13940	honey salt	148
13941	extractives o	2560
13942	Ingredients: snack ring corn meal	730
13943	maltodextrin torula yeast	197
13944	garlic powder natural flavor	4
13945	disodium reserve & disodium guanylate and spices	2561
13946	artificial color fd&c yellow # 5	403
13947	vegetable oil corn oil	307
13948	Pasteurized cheese product american cheese pasteurized milk	2562
13949	polysorbate  60	587
13950	carotenol color.	2563
13951	Vanilla pudding water	5
13952	disodium phosphate and tetrasodium pyprophosphate	1253
13953	partially hydrogenated soybean oil with bha	599
13954	yellow #5 yellow #6 color	786
13955	flour bleached wheat flour	131
13956	eg	1
13957	artificial maple flavor	2191
13958	vitamin b1	247
13959	dry roasted macadamia nuts	1349
13960	natural guava flavor and natural red color beet juice concentrate and sodium benzoat	354
13961	and natural coffee flavor	550
13962	natural lilikoi passion fruit	1032
13963	flavor and natural red color beet juice concentrate	409
13964	contains 2% or less of each of the following: autolyzed yeast extract	209
13965	dehydrated lemon peels	200
13966	White fish	2564
13967	contains 2% or less of the following: wheat gluten	955
13968	mirin wine	1551
13969	hyd	2565
13970	soy lecithin an emulsifier and vanilla .	185
13971	soy lecithin an emulsifier and vanilla.	185
13972	vanilla maltodextrin	197
13973	& titanium dioxide	369
13974	soy lecithin an emulsifier and vanilla	185
13975	flavouring: natural peppermint oil; emulsifier: soya lecithin; invertase.	458
13976	Brazil nuts 33%	728
13977	emulsifier: soya lecithin. dark chocolate 67% contains cocoa solids 55% minimum.	185
13978	banana	136
13979	emulsifier soya lecithin e322 & sorbitan tristearate e492	185
13980	caramel color e150d	357
13981	flavor ban	316
13982	full cream milk	891
13983	banana powder	136
13984	emulsifier soya lecithin e322	185
13985	caramel colour	2566
13986	banana flavor.	2083
13987	caramel colour.	2567
13988	pork gelatin	459
13989	artificial color includes: yellow 6	794
13990	artificial colors yellow 5 lake	403
13991	modified whey milk	193
13992	corn starch and artificial flavors.	263
13993	oil of peppermint	458
13994	and brominated vegetable oil.	1536
13995	and natural and artificial flavor.	316
13996	citric acid. sodium benzoate preservative	200
13997	and artificial flavor.	637
13998	sodium citrate and natural flavor.	2568
13999	Enriched wheat flour contains niacin	131
14000	shortening soybean oil or canola oil	243
14001	and/or partially hydrogenated soybean oil lea	243
14002	vegetable oil shortening partially hydrogenated soybean oil and/or cottonseed oil	2092
14003	creamy milk	7
14004	corn starch and artificial flavors	263
14005	artificial colors including yellow 5	403
14006	natural spearmint oil	2545
14007	blue 1 and red 3.	2569
14008	hydrogenated vegetable oil soybean	243
14009	reduced minerals	2570
14010	sodium chloride	140
14011	brominated vegeta	26
14012	potassium benzoate a preservative.	490
14013	riboflavine	818
14014	vegetable oil contains one or more of the following : canola oil	90
14015	Spring water	1880
14016	fruit juices from concentrate filtered water	2517
14017	Dates.	159
14018	sulfor dioxide	306
14019	soy and wheat protein	1491
14020	dehydrated vegetables onio	9
14021	natural lemon flavor soybean oil	910
14135	and sea salt	98
14022	partially hydrogenated cottonseed/soybean oil	881
14023	passionfruit lemon flavored fruit pieces fruit concentrated apple puree	1690
14024	passionfruit juice	1618
14025	hydrolyzed soy prote	276
14026	hydrogenated vegetable oil palm kernel	286
14027	and/or palm	1174
14028	cranberry juice cranberry juice from concentrate and cranberry juice	766
14029	vegetable concentrate for color.	768
14030	Vapor distilled water	5
14031	potassium bicarbonate.	655
14032	Vapor	2571
14033	passionfruit juice concentrate	1032
14034	H2O	5
14035	Mission figs	282
14036	vegetable oil contains one or more of the following; palm	201
14037	palm kernel coconut and/or soybean	286
14038	mon-and diglycerides	921
14039	hydrogenated vegetable oil may contain coconut and/or palm kernel and/or palm oils	1001
14040	emulsifier mono- and diglycerides of fat acids	729
14041	artificial colors including yellow 6	403
14042	caffeine and acesulfame potassium.	855
14043	cheese sauce mix dairy product solids	1575
14044	modified corn	134
14045	cheddar cheese pasteurized m	32
14046	Bananas bananas	1340
14047	blackberry juice concentr	489
14048	cranberry juice from concentrate filtered water	5
14049	Cashews roasted in peanut and/or cottonseed and/or sunflower seed and/or canola oil	741
14050	Corn chips: whole grain corn	2572
14051	vegetable oil contains one or more of the following: canola corn	26
14052	or sunflower	147
14053	bbq seasoning corn flour	165
14054	Peanuts: roasted in peanut and/or cottonseed oil	741
14055	bittersweet chocolate chunks sugar	118
14056	peanut butter candies peanut butter flavored coating sugar	1
14057	vegetable oil contain one or more of the following: canola oil	90
14058	contains 2% or less of the following: sodium bicarbo	258
14059	cheese sauce mix maltodextrin	197
14060	Filtered carbonated water and natural flavors.	356
14061	Filtered carbonated water.	356
14062	Enriched flour bleached and unbleached wheat flour	131
14063	apricots apricots	275
14064	contains less than 1% of the following: fructose	1
14065	apple cider vinegar powder malt	480
14066	strawberry juice concentrate red 40.	2573
14067	corn syrup marshmallows corn syrup	596
14068	almond oil and/or safflower oil	26
14069	stabilizer mono-	729
14070	pistachio nuts roasted in canola oil	320
14071	natural & artificial pistachio flavor water	2574
14072	artificial coloring water	5
14073	vegetable shortening partially hydrogenated soybean and cottonseed oil	881
14074	dry malt dry barley malt extract	635
14075	corn syrup sol	750
14076	chocolate chocolate liquor	2291
14077	vegetable oil coconut and soybean	26
14078	pecans roasted in cottonseed oil	49
14079	turmeric added as color	175
14080	natural and artificial vanilla flavor propylene glycol	616
14081	sodium benzoate and potassium sorbate	926
14082	as preservatives	402
14083	fd&c red 40 and fd&c blue 1	799
14084	coconut pineapple puree pineapple	2575
14085	stab	139
14086	dried egg yolks	796
14087	orange sherbet base water	5
14088	lemon puree water	2576
14089	fd&	2577
14090	strawberries sugar	1
14091	stabilizer mono- and diglycer	729
14092	marble cream caramel corn sweeteners corn and high fructose corn syrups	596
14093	potasium sorbate a	338
14094	brownie fudge sugar	1
14095	sweetened condensed milk condensed milk	523
14096	corn star	263
14097	chocolate chip cookie dough un-enriched wheat flour	131
14098	natural van	186
14099	corn syrup strawberry marble high fructose corn syrup	344
14100	stabilizer mono-and diglycerides	729
14101	chocolate swirl maltitol syrup	1169
14102	glucono delta lact	516
14103	organic apple juice concentrate	322
14104	organic cranberry juice from concentrate water	766
14105	organic cranberry juice	766
14106	organic cranberry concentrate	2578
14107	organic grape juice concentrate	150
14108	organic cranberry flavor	2579
14109	organic purple carrot ju	119
14110	organic cherry juice concentrate	500
14111	organic purple carrot juice concentrate for color.	237
14112	maltode	197
14113	wheat glucose syrup	315
14114	fruit and vegetable extracts	2580
14115	treacle	156
14116	Dark chocolate chocolate liquor	118
14117	sugar confectioner's glaze.	289
14118	dried sweetened blueberries cultivated blueberries	130
14119	dried sweetened cherries red tart pitted cherries	865
14120	contains less than 1% of the following: gum acacia	390
14121	raisins coated with less than 1% sunflower and/or canola oil.	1382
14122	soybean and/or sunflower seed.	185
14123	Dark chocolate cocoa mass	118
14124	and natural vanilla extract	21
14125	pure soybean oil	243
14126	toffee bits sugar	1
14127	chocolate cookie crumbs enriched flour wh	56
14128	and natural vanilla extract.	21
14129	dried pomegranate	412
14130	dried blueberry	2581
14131	dried acai.	264
14132	vegetable oi	26
14133	Yogurt flavored confectionary coating dried cane syrup	2582
14134	corn syru	596
14136	vegetable oil may contain one or more of the following: peanut	741
14137	sunflower and	151
14138	sriracha seasoning sugar	1
14139	hot sauce aged cayenne peppers	69
14140	vegetable oil may contain one or more of the following: peanuts	741
14141	Vanilla bites enriched bleached flour wheat flour	131
14142	riboflavin vitamine b2	818
14143	Yogurt raisins yogurt coating sugar	1
14144	sour cream flavor	25
14145	caramel balls caramel bits; sugar	1
14146	butteroil m	674
14147	dried strawberry cranberries cranberries	2583
14148	dried blueberry cranberries cranberries	2581
14149	Tan chocolatey ernies sugar	1
14150	artificial color fd&c blue #2 lake	2584
14151	methyl and propyl parabeans	2585
14152	monifat milk powder corn syrup	596
14153	sulfur dioxide added for color retention	306
14154	vegetable oil may contain one or more of the following: p	2586
14155	chocolatey pieces sugar	1
14156	artificial color blue 1	1692
14157	phosph	770
14158	soy lecithin an	185
14159	vanilla sugar	170
14160	and less than 2% of honey	36
14161	canola and/or safflower and/or palm oil	26
14162	parsley juice concentrate	22
14163	lettuce juice concentrate	2587
14164	watercress juice concentrate	1425
14165	spinach juice concentrate	79
14166	grape juice from concentrate cane or beet sugar	1
14167	natural flavors sodium citrate ascorbic acid vitamin c	2588
14168	color added red 40 lake	677
14169	yellow 6 lak	794
14170	modified dextrose	750
14171	color added red 40	677
14172	Multi grain blend whole grain rolled oats	78
14173	walnuts coated with rosemary extract	58
14174	dried sweetened apples sugar	1
14175	Multi grain blend wholegrain rolled oats	78
14176	wholegrain rolled rye	217
14177	Whole grain steel cut oats.	78
14178	blh extract	2589
14179	contains less than 1% of salt	140
14180	tocopherols from soy to ensure freshness	169
14181	pecorino romano cheese sheep milk	441
14182	purple sweet potato	2590
14183	prunes prunes	1824
14184	potassium sorbate as a preservatives	338
14185	potassium metabisulfite for color retention	1884
14186	sodium sulfite for color retention	426
14187	sodium metabisulfite color retention	426
14188	worcestershire sauce powder maltodextrin	197
14189	soybean and/or safflower seed	243
14190	milkfat from milk	639
14191	artificial colors fd&c yellow 6	403
14192	contains less than 2% of the following: butter cream milk	393
14193	soy lecithin and caramel color	185
14194	Spicy peanuts peanuts	173
14195	cheese blend {romano	969
14196	raisins coated with less than 1% sunflower and/or canola oil	147
14197	partially hydrogenated palm ke	286
14198	propylene glyco	616
14199	sodium bicarbonate leaveni	24
14200	White popcorn	589
14201	beta carotene artificial flavors	478
14202	Air popped popcorn	1954
14203	Whole grain white corn masa flour	165
14204	vegetable oil contains one or more of the following: sunflower	147
14205	canola or corn oil	90
14206	vegetable medley red & green bell pepper	536
14207	and carrot	119
14208	sprouted ancient grain medley	2591
14209	Whole grain corn masa flour	165
14210	or corn oil	307
14211	whole brown flax seed	157
14212	ancient whole grain medley amaranth	168
14213	cheddar c	32
14214	yeast with ascorbic acid	294
14215	and/or palm oil	201
14216	gleoresin.	390
14217	marshmallow drops sugar	1
14218	and soy lecithin emulsifier	185
14219	graham cracker squ	2592
14220	potassium citrate.	904
14221	Brewed tea filtered water	851
14222	black tea concentrate.	365
14223	black tea concentrate	365
14224	Cold brewed coffee water	550
14225	mango juice from concentrate f	190
14226	calcium saccharin or sodium saccharin 36mg per 1.0g packet	756
14227	Sweetened banana chips bananas	136
14228	sugar and natural flavor	170
14229	dried sweetened pineapple sugar	1
14230	dried sweetened mangoes mangoes	190
14231	Honey roasted peanuts peanuts	173
14232	frosted walnut pieces	58
14233	vegetable oil flaunt	26
14234	contains 2% or less of soy lecithin emulsifier	185
14235	modified food starch potato	519
14236	artificial colors including fd&c red 40	795
14237	lactic acid red 40	295
14238	sugar gelatin	459
14239	contains less that 2% of natural and artificial flavor	316
14240	sodium casseinate a milk derivative	640
14241	mono-and diglyceri	729
14242	Sunflower kernels vegetable oil peanut cottonseed soy bean and/or sunflower seed	147
14243	cocao butter	171
14244	vegetable oil contains one or more of the following: ca	203
14245	hydrogenated vegetable oil palm kernel and/or palm	201
14246	ground peanuts	137
14247	soy lecithin and sorbitol emulsifier. vanillin artificial flavor.	185
14248	u.s. certified colors including fd&c yellow 6	794
14249	white mineral oil.	1401
14250	natural peppermint oil.	458
14251	soy lecithin emulsi	185
14252	malt salt	148
14253	White fudge sugar	170
14254	titanium dioxide an artificial coloring	369
14255	reduce	295
14256	b	2593
14257	soy lecithin and sorbitol emulsifiers	185
14258	Peanuts dry roasted.	137
14259	Pasteurized goats' milk	2594
14260	Goat cheese pasteurized goats milk	1728
14261	Crumbled goat cheese pasteurized goat's milk	1728
14262	Pasteurized cow's cream	473
14263	culture.	2595
14264	Pasteurized cows' cream milk	473
14265	pure bourbon madagascar vanilla extract	20
14266	vanilla bean powder	20
14267	glucono delta lactone.	516
14268	Pasteurized cows' cream	473
14269	sea salt crystals	148
14270	Organic cocoa mass	118
14271	organic vanilla pods. .	20
14272	organic baobab fruit powder 5%	2596
14273	organic vanilla pods. cocoa: 60% min. chocolate.	20
14274	sweetener sucralose. cocoa: 31% min.	399
14275	sweetener steviol glycosides.	859
14276	organic pomegranate preparation 12% organic pomegranate	412
14277	thickener pectin organic cocoa butter	337
14278	organic vanilla pods. cocoa: 60% min. chocolate	20
14279	may contain	295
14280	organic coconut milk powder 10% coconut milk	2129
14281	organic ground coconut flakes 10%	68
14282	organic vanilla pods.	20
14283	Fontina and parmesan cheese pasteurzed milk	1009
14284	potato starch and/or cornstarch to prevent caking	139
14285	potato starch and/or corn starch to prevent caking.	139
14286	asiago and romano cheese pasteurized milk	2597
14287	potato starch and/or cornstarch to prevent caking.	139
14288	to prevent caking.	309
14289	Bellavitano cheese pasteurized milk	1009
14290	roasted ground coffee.	550
14291	sundried tomato	240
14292	ancho chili pepper.	1782
14293	Pasteurized cow's	1009
14294	Bellavitano cheese pasteurized cow's milk	2598
14295	balsamic vinegar.	480
14296	merlot wine grapes	2599
14297	coarse black pepper.	12
14298	Fontina cheese pasteurized cow's milk	1362
14299	penicillium roquefortii.	1236
14300	crushed peppermint candy.	2243
14301	chai tea black tea	365
14302	bourbon whiskey corn	134
14303	Bellavitand cheese pasteurized milk	1009
14304	seasoning blend spices including ginger	28
14305	orange peal	366
14306	dutch cocoa powder	118
14307	chili powder ground chilies	195
14308	Made from cultured pasteurized milk	735
14309	jalapeno peppers salt enzymes.	2600
14310	American	1
14311	swiss milk	7
14312	Heavy cream.	52
14313	100% durum wheat semolina	1280
14314	Selected potatoes	279
14315	peanut oil vinegar and salt seasoning processed form: lactose	148
14316	bht and citric acid 0.01% added to preserve freshness	721
14317	less than 2% silicon dioxide added to prevent caking.	631
14318	bbq seasoning	834
14319	torula	1557
14320	less than 2% silicon dioxide to prevent caking.	631
14321	Imitation pasteurized processed cheddar cheese water	5
14322	Imitation pasteurized cheddar cheese product water	5
14323	xan	265
14324	contain 2% or less of modified food starch	778
14325	s dextrose sodium phosphate	750
14326	sodium nitrite paprika	367
14327	fd&c red no. 3.	849
14328	sodium hexametaphosphate to protect flavor	1275
14329	potassium sorbate preserves freshness	338
14330	calcium disodium edta to protect fla	843
14331	potassium benzoate preserves freshness	490
14332	calcium disodi	2601
14333	citrus pectin calcium disodium edta to prot	200
14334	calcium disodium edta to pro	455
14335	Contains: brewed starbucks coffee water	5
14336	calcium disodium ed	477
14337	Panax ginseng extract.	1426
14338	white and green tea	851
14339	potassium sorbate preserve freshness	338
14340	sodium benzoate preserves freshness	354
14341	erythorbic acid preserves freshness	775
14342	sodium benzoate preser	354
14343	Starbucks coffee water	5
14344	panax ginseng root extract	1426
14345	guarana paullinia cupana seed extract	1542
14346	cellulos	740
14347	BREWED STARBUCKS COFFEE WATER	5
14348	fruit juices from concentrate white grape	2602
14349	green coffee bean extract	585
14350	rebaudioside-a stevia leaf extract	859
14351	panax ginseng root powder e	1426
14352	potassium sorbate preserves flavor	338
14353	erythritol calcium caseinate milk	1014
14354	root fiber chicory	1220
14355	monk fruit extract	2603
14356	ascorbic acid to protect flavor.	329
14357	Brewed tea	851
14358	ascorbic acid to protect flavor	329
14359	coconut water from concentrate	438
14360	passion fruit juice from concentrate	1618
14361	ascorbi	329
14362	Orange juice concentrate filtered water and concentrate orange juice	65
14363	Brewed starbuckreg coffee water	5
14364	calcium disodium edta t	843
14365	Guarana Seed Extract	585
14366	Yerba Mate Extract	2604
14367	Brominated Vegetable	1536
14368	ISOBUTYRATE	2605
14369	natural and artificial flavor. citric acid	200
14370	sodium benzoate preserves freshness caffeine	354
14371	erythorbic acid preserves freshness gum arabic	775
14372	purified stevia leaf extract.	859
14373	sodium benoate preserves freshness	454
14374	calcium dissodium edta to protect flavor	455
14375	caffine guarana seed extract. niacinamide vitamin b3	585
14376	calcium pantothenate vitamin b5 calcium	496
14377	potassium sorbate and potassium benzoate preserve freshness	787
14378	sodium hexametaphosphate  to protect flavor	1275
14379	potassiu	1340
14380	coffee.	585
14381	sugar natural flavor	1
14382	purple carrot juice concentrate color	237
14383	purified stevia leaf extract	859
14384	kola nut extract	585
14385	ginger oleoresin	28
14386	apple juice concentrated color	373
14387	potassium sorbate preserves freshness.	338
14388	calcium disodium edta to protec	843
14389	glycerol ester of r	729
14390	citric acid. natural flavor	200
14391	tbhq antioxidant.	1082
14392	Ingredients: corn oil	307
14393	sweet dairy whey - milk	405
14394	lactose - milk	405
14395	sodium caseinate - milk	640
14396	soy lecithin - on emulsifier	185
14397	and 2% or less of the following: silicon dioxide	309
14398	ground fennel.	231
14399	contains less than 2% of: stevia leaf extract	859
14400	magnesium oxide.	1431
14401	mono- and diglycerides prevents foaming	729
14402	organic cultured wheat starch	662
14403	baking powder sodium a	258
14404	malted barley flour niacin	993
14405	organic culture	2606
14406	baking powder sodium ac	258
14407	cultured organic wheat flour	131
14408	vegetable oils: rapeseed oil	90
14409	yeast powder	294
14410	cheese powder	38
14411	flavour enhancer: monosodium glutamate: wheat flour	708
14412	sunflower oil: salt and vinegar flavour whey extract milk	147
14413	Macaroon coconut desiccated coconut	68
14414	chocolate decorettes 9sugar	1
14415	cottonseed and/or soybean	185
14416	confectioner's gla	315
14417	White confectionery coating sugar	170
14418	vegetable shortening partially hydrogenated soybean and	599
14419	vegetable shortening hydrogenated soybean and cottonseed oils	1001
14420	partially hydrogenated veget	881
14421	yellow decorettes sugar	1
14422	soybean and cottonseed oils soy lecithin emulsifier	185
14423	cocoa may be processed with alkali	118
14424	whey po	193
14425	dark confectionery coating sugar	1
14426	partially hydrogenate	1142
14427	bread flour potassium bromate	1933
14428	enzyme sugar	170
14429	raspberry filling	208
14430	yellow decorates sugar	170
14431	partially hydrogenated vegetable oil soybean and/or cottonseed oils soy lecithin	881
14432	vegetable shortening partially hydrogenated soybean and cotton seed oils	881
14433	pure and artificial flavors	196
14434	Enriched bleached flour wheat	131
14435	soy lecithin emulsifier tbhq and citric acid in propylene glycol	185
14436	folic acid decorettes sugar	727
14437	corn cornstarch	263
14438	vegetable shortening partially hydrogenated vegetable oil soybean	243
14439	citric acid in propylene glycol preservative	200
14440	citric acid in propyl	200
14441	citric acid in propylene glycol	200
14442	confecti	2607
14443	soy lecithin tbhq and citric acid in propylene glycol preservative wate	185
14444	vegetable shortening modified palm oil	201
14445	rspo palm kernel oil	286
14446	vegetable shortening partially hydrogenated soy and cottonseed oils	881
14447	Double stuffed baked potatoes	34
14448	Potato and edamame salad	2608
14449	Golden potatoes.	34
14450	A spicy yet flavorful sea salt blend ingredients: jalapeno chile	195
14451	garlic granules	4
14452	organic rice hull	2609
14453	mexican oregano. made from pure sea salt and a mix of 4 smoky sweet red chiles ingredients: new mexico chile	42
14454	Fingerling potatoes.	2610
14455	Petite sweet potatoes.	370
14456	soy lecithin an emulsifer	185
14457	extracts of natural spices	834
14458	extract of paprika.	55
14459	contains less than 2% of corn syrup	596
14460	Ingredients: turkey	1095
14461	paprika sodium erythorbate	363
14462	isolated soy	1291
14463	Freeze-dried peas.	132
14464	Freeze-dried mangos.	190
14465	Freeze-dried bananas	136
14466	Freeze-dried strawberries.	88
14467	Freeze-dried strawberries and bananas.	2611
14468	Freeze-dried organic cherries.	189
14469	Pure	1
14470	natural honey.	36
14471	Pure and natural honey.	36
14472	unsweetened tapico syrup.	2612
14473	Sparkling apple juice from ripe	322
14474	fresh	5
14475	whole apples	213
14476	Organic dehydrated cane juice.	170
14477	Organic blue agave nectar	893
14478	Organic blue agave nectar light	893
14479	Organic blue Agave nectar.	893
14480	Organic raw blue agave nectar	893
14481	Organic blue agave nectar amber.	893
14482	Organic raw blue agave nectar.	893
14483	Erythritol.	983
14484	Organic evaporated cane juice fair trade certified by fair trade usa	2613
14485	Organic brown sugar fair trade certified by fair trade usa	13
14486	Organic invert sugar cane syrup	170
14487	Raw cane turbinado sugar.	170
14488	Organic blackstrap molasses	2614
14489	Organic blackstrap molasses.	2614
14490	organic powdered sugar organic sugar	170
14491	organic black cocoa powder	118
14492	less than 2% of the following: natural chocolate flavor	2615
14493	unbleached s	1
14494	Organic powdered sugar organic evaporated cane juice	170
14495	less than 2% of the following: organic corn starch	866
14496	unbleached sunflowe	147
14497	unbleached sunflower l	147
14498	Organic honey. fair trade certified by fair trade usa	36
14499	Organic coconut palm sugar	609
14500	Organic agave inulin	1220
14501	organic stevia extract stevia rebaudiana	859
14502	silica.	631
14503	roasted in peanut oil and/or cottonseed oil.	2616
14504	salt fd&c blue #1	148
14505	red #40 & yellow #5.	403
14506	gum base; less than 2% of: adipic acid	2617
14507	bht to maintain freshness	721
14508	Peppermint - made of sugar	2243
14509	gum base	2617
14510	artificial and natural flavoring	407
14511	candelilla wax	2504
14512	partially hydrogenated cottonseed oil and water soluble chlorophyll.	2618
14513	blue 2 and blue 1.	2619
14514	Strawberry artificially flavored ingredients: sugar	1
14515	gum base; less than 2% of: acesulfame potassium	2617
14516	gum base; less than 2% of: artificial; and natural flavoring	2617
14517	red 40 lake and soy lecithin. sour apple artificially flavored ingredients: sugar	2620
14518	artificial and natural flavoring; less than 2% of: bht to maintain freshness	747
14519	soy lecithin and titanium dioxide color.	185
14520	Red 40 lake and soy lecithin.	1974
14521	Artesian water	2621
14522	natural caffeine.	585
14523	Semolina wheat; durum flour wheat; niacin; iron ferrous sulfate; thiamin mononitrate; riboflavin; folic acid.	727
14524	Semolina wheat	451
14525	nicotinamide niacin	466
14526	Semolina wheat; durum flour wheat; niacin; iron ferrous sulfate; thiamin mononitrate	1085
14527	Bagel tapioca starch	757
14528	egg whites egg whites	376
14529	canola oil and/or sunflower oil and/or safflower oil	26
14530	sodium algin	1173
14531	natural milled sugar	170
14532	salt. vitamins & minerals: ferric orthophosphate iron source	140
14533	niacinamide a b vitamin	466
14534	folic acid a b vitamin	819
14535	zinc oxide zinc source	1585
14536	cyanocobalmin vitamin b12	526
14537	85% soybean oil and 15% extra virgin olive oil.	2622
14538	100% pure olive oil	6
14539	juice concentrate	429
14540	1/40 of 1% sodium benzoate and 1/40 of 1% sodium bisulfite as preservative	354
14541	Fried out pork fat with attached skin	704
14542	Cured with salt	148
14543	pepper sodium nitrate.	952
14544	cooked grape must.	1919
14545	Baby red chard	1810
14546	baby tat soi	1802
14547	baby green swiss chard	2623
14548	baby kale.	841
14549	contains less than 2% of each of the following: sodium propionate preservative	1601
14550	monoglycerides of fatty acids	729
14551	artificial flavor dextrose	750
14552	egg whits	376
14553	contains less than 2% of each of the following: adipic acid	1061
14554	calcium propionate  preservative	911
14555	natural & artificial flavors dextrose	750
14556	sodium lauryl sulfate	1982
14557	enriched bleached flour flour	816
14558	calcium sulphate	924
14559	sodium p	594
14560	shortening interesterified soybean oil	243
14561	with mono- and diglycerides	729
14562	bleached flour bleached wheat flour	131
14563	ribofla	818
14564	cake base enriched	2624
14565	propylene glycerol	234
14566	mono and diesters	2625
14567	bleached enriched flour wheat	131
14568	color {water	5
14569	with mono-and diglycerides	729
14570	bleached flour bleached wheat	131
14571	thiami	1085
14572	bleached flour flour bleached wheat flour	1030
14573	contains 2% or less of the following: cellulose gum	600
14574	color fd&c	2626
14575	may contain: soybean	142
14576	cottonseed and/ or palm oil; corn sugar	170
14577	soyflour	547
14578	sodium propionate and natural flavors.	1601
14579	chilipeppers	195
14580	acetic acid spices xanthan gum	480
14581	sodium benzoate 0.1%.	354
14582	extractives of paprika and spices	934
14583	Whole artichoke hearts	1342
14584	Only carbonated water	356
14585	naturally essenced.	2627
14586	natural hickory smoke flavoring	2556
14587	sodium benzoate and potassium sorbate as	2628
14588	jack daniel's tennessee whiskey flavoring natural and artificial flavoring	2629
14589	mustard smoke flavoring	2630
14590	sodium benzoate and po	354
14591	natural mesquite smoke flavoring	2631
14592	jack daniel's tennessee whiskey flavoring natural and artificial flavorin	2629
14593	Vine-ripened whole unpeeled ground tomatoes	240
14594	Corn and potato starch	139
14595	lupin flour	540
14596	mono and diglycerides emulsifier.	341
14597	chocolate flavored drops sugar	1
14598	chocolate liqour	2632
14599	soy lecithin en emulsifier	185
14600	vanillin an artificial flavor . pretzels enriched flour wheat flour	186
14601	toffee sugar	170
14602	riboflavon	818
14603	vanilla an artificial flavor	20
14604	pretzel enriched flour wheat flour	131
14605	thiamine monocitrate	468
14606	milk fat. soy lecithin an emulsifier	639
14607	vanillin an artificial flavor. pretzel enriched flour wheat hour	186
14608	Vanilla flavored candy wafers sugar	1
14609	artificial flavor. pretzel enriched flour wheat flour	637
14610	vitamin a palmitate & vitamin d3 added.	2633
14611	Reduced fat milk with vitamin a palmitate and vitamin d3 added.	2634
14612	palmitate & vitamin d3 added.	2635
14613	cocoa natural & dutch process	118
14614	vanillin an artificial flavor vitamin d3 added.	186
14615	Milk sugar	270
14616	coca natural & dutch process	118
14617	and vitamin d3 added.	1189
14618	Grade a nonfat milk	7
14619	Fat free skim milk	472
14620	potassium sorbate to retain freshness	338
14621	whole milk mozzarella cheese pasteurized milk	531
14622	sauce tomato pu	487
14623	Organic wheat flour organic wheat flour	131
14624	organic malted barley flour	993
14625	organic semolina	451
14626	cultured organic	735
14627	sour culture	867
14628	caramel nuggets sugar	1
14629	Unbleached enriched wheat flour wheat flour. niacin	131
14630	sprouted whole wheat flour	2636
14631	contains 2% or less of canola oil	90
14632	cu	2637
14633	ground white pepper	960
14634	sour cream cultured grade a pasteurized milk and cream	25
14635	butter with natural flavor pasteurized	2
14636	white degerminated corn meal.	730
14637	soybean and/or canola oils	872
14638	sour cream milk ingredie	25
14639	cream cheese mil	30
14640	orange peel orange	366
14641	fancy molasses	156
14642	thiamine monoitrate	468
14643	white degerminated corn meal wheat germ	730
14644	marjoram basi	1822
14645	ascorbic acid added as a dough conomoner	329
14646	enzyme added for improved baking. sour culture	2638
14647	Crust unbleached enriched wheat flour wheat flour	131
14648	contains 2% or less of wheat gluten	955
14649	propylene glycol esters of fatty acids	2639
14650	natural flavors contains milk	7
14651	colors added juice concentrates radish	372
14652	turmeric and annatto extracts	2640
14653	mono- and	2641
14654	gums agar	342
14655	acacia	390
14656	chocolate sprinkles sugar	1
14657	white sprinkles sugar	1
14658	leave	888
14659	contains 2% or less of : soy flour	547
14660	contains 2% or less of: whey milk	193
14661	turmeric and annatto extracts color.	2642
14662	natural vanilla extra	20
14663	natural flavor includes	316
14664	greek nonfat yogurt cultured nonfat	109
14665	cheek nonfat yogurt cultured nonfat milk	109
14666	multigrain blend rye sourdough water fermented rye flour	235
14667	whole grain groats	2086
14668	millet seed	298
14669	dried molasse	156
14670	Crust enriched flour wheat flour	131
14671	contains 2% or less of: semolina	451
14672	sauce tomato puree water	487
14673	fermented wheat flour	1093
14674	oa	2038
14675	Multigrain flatbread crust water	5
14676	wheat sourdough water	5
14677	soybean and palm oil	243
14678	contains 2% or less of: lemon puree	2576
14679	emulsifiers mono-& diglyceri	729
14680	gluten-free blend corn starch	866
14681	rice four	138
14682	amaranth flour	1682
14683	psyllium	2643
14684	modified cellulose gum	600
14685	gluten free blend corn starch	866
14686	contains 2% or less of: dried egg white	2644
14687	sour citrate	200
14688	semolina.	2645
14689	vegetable oil contains soya bean oil and partiallyhydrogenated palm oil	2426
14690	imported skimmed milk powder	7
14691	low fat coca	118
14692	soy lecithin and vanillin an artificial flavor.	185
14693	vegetable oil contains one or more of the following soybean and/ or cottonseed	243
14694	artificial and natural flavors.	196
14695	soybean and/or canola	872
14696	leavening disodium dihydrogen pyrophosphate	518
14697	disodium dihydrogen pyrophosphate to retain natural color	518
14698	leavening disodium dihydro	258
14699	disodium dihydrogen pyrophosphate	1713
14700	vegetable color.	590
14701	papain.	935
14702	Granulated rice	64
14703	bht to preserve freshness.	721
14704	dry molasses	156
14705	non-dairy creamer partially hydrogenated soybean oil	243
14706	dipotassium phosphat	779
14707	thiamine mononittrate	468
14708	contains less than 2% of each of th	594
14709	goat milk	442
14710	vanilla extract vanilla bean extractives in water	21
14711	alcohol 35%	384
14712	and sugar	170
14713	alcohol 35% and sugar	2646
14714	an emulsifier; salt; artificial flavor	185
14715	dark sweet chocolate sugar; chocolate; cocoa butter; natural & artificial flavors; soy lecithin	118
14716	an emulsifier	185
14717	hig	1
14838	dried cranberry cranberries	1764
14718	Apple flavor / ingredients: sugar	1
14719	colorings blue 1	1692
14720	coloring red 40 and artificial flavors.	2647
14721	palm oil and/or palm kernal oil	201
14722	salt and color added	140
14723	yellow 5 & yellow 6.	2648
14724	colorings	2649
14725	artificial flavors and natural flavors.	196
14726	milk chocolate sugar; cocoa butter; milk	171
14727	dark sweet chocolate sugar; chocolate; cocoa butter; natural & artificial flavor; soy lecithin	118
14728	M&m's fun size milk chocolate: milk chocolate sugar	461
14729	less than 1% corn syrup	596
14730	coloring	343
14731	and/or soybean oil	243
14732	soy lecithin added as an emulsifier.	185
14733	Cherry ingredients: dextrose	315
14734	and less than 2% of citric acid	200
14735	red 40 lake. razzapple ingredients: dextrose	1974
14736	grape corn syrup	315
14737	acerola extract vitamin c	329
14738	artificial flavors and red 40	2650
14739	yellow 5 & blue 1.	2312
14740	palm oil and/or palm kernel oil	201
14741	and red 4 / blue 1 / yellow 5.	677
14742	and red 40 / blue 1 / yellow 5.	2651
14743	red 40 and artificial flavors.	2647
14744	Ssugar	1
14745	hi	2017
14746	and artificial flavors. toffee candy - sugar	1
14747	palm oil or palm kern	201
14748	vegetable oil  coconut	135
14749	palm and/or soybean oil	26
14750	red#3	849
14751	blue#1.	1692
14752	Baker's request yellow cake mix sugar	1
14753	dry egg white	244
14754	sodium alumin	1438
14755	May contain one of the following cheeses: neufchatel cheese pasteurized cultured milk and cream	2652
14756	stabilizers xanthan and/or carob bean and/or guar gums and/or neufchatel cheese milk	265
14757	neufchatel cheese pasteurized milk	2653
14758	carob be	800
14759	Neufchatel cheese milk	2654
14760	neufchatel cheese pasteurized milk and cream	2653
14761	citric acid as a preser	200
14762	White corn grits	2655
14763	dehydrated cane juice crystals natural milled sugar	1
14764	vitamins and iron: vitamin c	329
14765	artificial flavoring.	653
14766	Flan sugar	170
14767	ferric pyrophosphate	251
14768	pyridoxine hcl	525
14769	acesulfame k	2656
14770	sucr	170
14771	thiamin thimin mononitrate	1723
14772	iron ferric acid folate.	251
14773	thiamin thiamin nomonitrate	1723
14774	folic acid folate.	819
14775	spices and parsley.	22
14776	hydrated silicon dioxide anti caking agent	309
14777	grill flavor	975
14778	contains less than 2% of sesame seed	1967
14779	Aged cayenne pepper	1643
14780	contains less than 2% of vegetable oil soybean and/or canola	243
14781	honey modified food starch	2657
14782	galric	4
14783	chipotle pepper sauce red jalapeno peppers	195
14784	worcestershire concentrate vinegar	73
14785	vidalia onions 7%	9
14786	contains less than 2% of: onion	9
14787	sodium benzoate and calcium disodium edta as preservatives	454
14788	contains less than 2% of spice	198
14789	high fructose corn syrup solids	344
14790	chipotle pepper sauce red jalapeno pepper	195
14791	tamarind. dried	453
14792	contains less than 2% of: garlic	4
14793	Ingredients: high fructose	344
14794	cola syrup high fructose corn syrup	344
14795	sodium benzoate as a	354
14796	caramel color sugar	357
14797	sriracha chili sauce red chili	195
14798	gar	4
14799	contains less than 2% of: bourbon	2658
14800	hydrolyzed corn and	2321
14801	dijon mustard distilled vinegar and water	73
14802	paprika co	55
14803	sodium benzoate and calcium disodium edta as a preservatives	354
14804	yellow #5.	403
14805	apple sauce apples	213
14806	contains less than 2% of: water	5
14807	vinegar distilled	480
14808	contains less than 2% of: sesame seeds	266
14809	artificial butter flavor diacetyl-free	2659
14810	contains less than 2% of: vegetable oil soybean and/	243
14811	Supreme sweet rice	2114
14812	lecithin an emulsifier	2660
14813	vanillin an artificial flavoring.	186
14814	Fair trade white chocolate sugar	1
14815	sweet whey powder	474
14816	soya lecithin emulsifier vanilla natural flavor	185
14817	crisp rice	64
14818	natural color beet juice extract	409
14819	baking soda raising agent.	258
14820	Milk chocolate  sugar	1
14821	full milk powder	1958
14822	vanilla natural flavor	20
14823	coconut oil / palm kernel oil	668
14824	salted butt	148
14825	xanthan gum vanillin an artificial flavoring.	265
14826	Fairtrade chocolate: sugar	1
14827	greek yogurt powder nonfat milk solids	405
14828	greek yogurt powder nonfat milk soli	887
14829	Fairtrade chocolate sugar	1
14830	greek yogurt powder	405
14831	nonfat mil	887
14832	greek yogurt powder nonfat milk	1182
14833	crisp rice made with organic brown rice	2661
14834	cocoa b	118
14835	Fairtrade milk chocolate sugar	1
14836	hazelnut	300
14837	vanilla dried roasted almonds	60
14839	Enriched	816
14840	bleached flour bleached flour	2662
14841	citric acid add	200
14842	ascorbic a	329
14843	pork stomachs	2663
14844	natural smoke flavorings	2664
14845	isolated oat product	274
14846	ground yellow mustard	95
14847	sodium di-acetate	602
14848	ascorbic acid to retain flavor	329
14849	pasteurized process cheddar cheese cheddar cheese pasteurized milk	32
14850	annatto coloring and powdered cellulose added to prevent caking	722
14851	Scrambled egg mix whole eggs	14
14852	0.15% water added as a carrier for citric acid	5
14853	richard's andouille sausage pork	534
14854	spi	1
14855	richard's cheese and jalapeno sausage pork	534
14856	smoke powder.	2665
14857	caesar dressing mayonnaise soybean oil	243
14858	calcium disodium edta {added to protect flavor}	455
14859	ranch dressing buttermilk cultured skim milk	7
14860	calcium disodium edta {protect quality}	843
14861	ranch sa	2666
14862	Cooked enriched linguine durum semolina	451
14863	expeller-pressed sesame oil	112
14864	cooked bulgur wheat	914
14865	spearmint.	824
14866	stabilizers xanthan gum	265
14867	and gum gum	390
14868	imitation crabmeat fish protein pollock and/or whiting	809
14869	mirin wine water	5
14870	egg whi	376
14871	Enriched wheat flour unbleached wheat flour	131
14872	ascorbic acid as a dough conditioner	329
14873	half & half cream	473
14874	contains less than 1% sodium citrate & disodium phosphat	477
14875	ascorbic acid added as dough conditioner	329
14876	cooked leeks leeks	558
14877	black pepp	12
14878	Cooked rainbow tortellini pasta: enriched semolina flour ferrous sulfate	451
14879	annatto. filling: ricotta cheese whey	236
14880	Cooked cavatappi pasta enriched durum wheat semolina	1280
14881	grape tomatoes mozzarella cheese pasteurized part skim milk	240
14882	roasted tomatoes tomatoes canola o	240
14883	Cooked red potatoes potato	279
14884	Black olives ripe olives	1459
14885	ferrous gluconate to stabilize color	251
14886	canola oil green olives green olives	90
14887	pimientos diced red peppers	75
14888	capers capers	1473
14889	green olives green olives	1458
14890	pimientos dice	1478
14891	Yogurt cultured grade a pasteurized milk	7
14892	Cranberry sauce water	5
14893	balsamic vinegar contains sulfites	397
14894	gorgonzola cheese pasteurized milk	1613
14895	powdered cellulose prevent caking	740
14896	natamycin to pro	1008
14897	and/or guar gums	475
14898	graham crumbs whole whea	802
14899	whole basil	48
14900	romano cheese pasteurized part skim milk	969
14901	rice v	64
14902	Ingredients: milk chocolate sugar	1
14903	fatty acid esters	1166
14904	flours maize	165
14905	wheat contains gluten}	326
14906	gelling agents modified potato starch	331
14907	cornflakes 26% maize	162
14908	malt extract contains gluten	391
14909	emulsifier mono & diglycerides	341
14910	wheat contains gluten	326
14911	Nougat creme sugar	1
14912	roasted hazelnuts. soybean oil	144
14913	emulsifier soybean lecithin	185
14914	maitodextrin	197
14915	sat anti-caking agent magnesium carbonate	1783
14916	emulsifier mono and diglyc	234
14917	Pasteurizen goat milk.salt	148
14918	cheest cultures	1162
14919	contains milk	7
14920	Ingredients:pasteurized goat milk	442
14921	anzyme	330
14922	coagulant.	924
14923	garlic and chives	4
14924	Pasteurized goat	442
14925	rennet potassium sorbate preservative.	338
14926	cranberry flavor with other natural flavors cheese cultures rennet	38
14927	Ingredients: rice pasta  white and brown rice flour tapioca starch	64
14928	cheddar cheese  cultured pasteurized milk	32
14929	non-animal enzymes	1063
14930	cultured whole milk	735
14931	Organic pasta organic wheat flour	131
14932	dried cheddar cheese cultured pasteurized milk	32
14933	silicon dioxide for anticaking.	309
14934	Organic whole wheat shell pasta	143
14935	ORGANIC WHEAT SHELL PASTA	143
14936	Organic whole grain wheat graham flour	131
14937	organic expeller-pressed sunflower oil	147
14938	orga	2667
14939	Organic wheat macaroni organic wheat flour	131
14940	sunflower l	147
14941	expeller-pressed sunflower oil	147
14942	celery seed powder	931
14943	organic whole wheat flour graham flour	283
14944	organic invert cane syrup	471
14945	organic chocolate cookie bits	56
14946	annatto extract for colo	722
14947	organic tapioca syrup	642
14948	mixed tocopherols vitamin e to protec	169
14949	organic expeller-pressed vegetable oil organic sunflower oil	147
14950	dried organic cheddar cheese pasteurized organic milk	38
14951	organic cheddar chees	32
14952	organic cheddar cheese pasteurized organic milk	2668
14953	organic yeast	294
14954	cultured whol	2669
14955	organic vegetable juices from concentrate carrot	119
15546	citric acid and organic flavor	200
14956	sweet potato organic lemon juice concentrate	18
14957	organic tapioca syrup solids	2088
14958	natural butter flav	2
14959	Organic wheat pasta organic wheat flour	143
14960	Best ingredients: annie's friends bunny grahams:	131
14961	color black carrot juice	2670
14962	beet juice	409
14963	annato extract	236
14964	expeller-	26
14965	uncured pepperoni no nitrates or nitrites added except those naturally occurring in celery powder pork	1069
14966	contains l	295
14967	uncured pepperoni no nitrates or nitrites added	2671
14968	organic whole wheat graham flour	283
14969	mixed tocopherols vitamin e to protect flavor	169
14970	organic distilled white vinegar. sauce: water	480
14971	Bagel half: organic wheat flour	131
14972	organic tomat	240
14973	organic white grape juice concentrate	150
14974	colors organic black carrot	590
14975	organic annatto	722
14976	sodium citra	200
14977	pea flour	2549
14978	powdered cane sugar cane sugar	170
14979	pecti	337
14980	sunflowers lecithin	185
14981	Granola whole grain oats	78
14982	semisweet chocolate chips cane sugar	1
14983	rice crisp rice	64
14984	rice crisp brown rice flour	261
14985	sunflo	147
14986	organic barley malt extract	391
14987	Organic pizza crust wheat flour	131
14988	brown cane sugar	170
14989	asbcorbic acid	329
14990	organic bbq sauce water	5
14991	ORGANIC WHEAT MACARONI	143
14992	Organic ancient grains elbow macaroni organic durum wheat	1968
14993	organic kamut wheat	1047
14994	Organic wheat spiral pasta organic wheat	143
14995	natural butter and cheese flavor	2672
14996	la	295
14997	silicon	309
14998	Organic wheat peace pasta	143
14999	organic parmesan cheese organic cultured pasteurized milk	62
15000	dried organic cheddar cheese organic cultured pasteurized milk	32
15001	organic annatto extract for color	722
15002	Organic wheat elbow pasta	143
15003	four cheese sauce cheddar	1388
15004	parmesan and monterey jack cheeses pasteurized milk	2673
15005	natural vitamin e	169
15006	Organic Valley Organic Cheddar Cheese organic pasteurized milk	7
15007	Organic cultured whole Milk	7
15008	Organic Ground Celery Seed	931
15009	Natural Vitamin E to protect flavor	169
15010	Best ingredients: tapioca syrup	2088
15011	tapioca syrup solids	2088
15012	color black carrot	2674
15013	black currant extracts	349
15014	carnauba	415
15015	Gluten free toasted oats whole grain oats	78
15016	rice crisp	64
15017	chocolate chips cane sugar	1
15018	rice fib	2675
15019	rice fiber	2675
15020	Best ingredients: cultured pasteurized grade a organic milk	7
15021	organic strawberry puree	1879
15022	organic beet juice concentrate for color	409
15023	live and active cultures l. bulgaricus	1390
15024	Best strawberry ingredients: cultured pasteurized grade a organic milk	7
15025	s. ther	306
15026	Berry patch best ingredients: cultured pasteurized grade a organic milk	7
15027	organic blueberry puree	2676
15028	live and active cul	2677
15029	Best ingredients: organic wheat flour	131
15030	organic expeller-pressed sunflower and canola oils	2678
15031	organic invert syrup	1
15032	organic semi-sweet chocolate chips. organic cane sugar	118
15033	organic whole grain oat flour	274
15034	organic invert can	1
15035	Best ingredients: organic popcorn	1954
15036	organic dried cheddar cheese organic cultured pasteurized milk	7
15037	mixed tocopherols vitamin e to protect flavor.	169
15038	Best ingredients: apple puree concentrate	1690
15039	color organic black carrot	2674
15040	organic blackcurrant extracts	374
15041	soy lec	185
15042	dark cherry juice concentrate	2679
15043	ammon	652
15044	organic va	20
15045	organic semi-sweet chocolate chips organic cane sugar	118
15046	organic expeller-pressed	26
15047	rice flou	138
15048	Rice pasta white and brown rice flour	138
15049	annatto extract fo	722
15050	Rice pasta shells white and brown rice flour	64
15051	stevia leaf extract	859
15052	dextrose and potassium iodide 0. 006%.	750
15053	silicon dioxide free-flowing agents	309
15054	potassium iodide.	2680
15055	tricalcium phosphate free-flowing agent.	751
15056	dextrose and potassium iodide 0.006%.	750
15057	sodium silicoaluminate anticaking agent	309
15058	and sodium bicarbonate.	24
15059	Salt and sodium silicoaluminate anticaking agent.	140
15060	Icing sugar sugar	170
15061	cream cheese pasteurized cultured milk & cream	30
15062	carob gum and/or guar gum and/or xanthan gum	578
15063	unbleached flour wheat flour	131
15064	cage-free whole eggs	1366
15065	walnu	733
15066	sour cream cultured pasteurized cream	25
15067	buttermilk cu	72
15068	buttermilk cultured lowfat	1303
15069	cocoa processed with a	118
15070	organic soft white wheat flour	131
15071	pasteurized organic egg whites	376
15547	organic lemon oil and less tha	910
15072	organic cocoa powder processed with alkali organic butter certified organic cream derived from milk	118
15073	organic expeller	2681
15074	organic powdered sugar	170
15075	organic sour cream cultured pasteurized grade a organic milk	25
15076	pasteurized organic cream	473
15077	organic unsweetened chocolate	118
15078	certified organic wheat flour	131
15079	organic dark chocolate chips	118
15080	organic 100% soft white wheat flour	131
15081	organic butter certified organic cream derived from milk	2
15082	cult	735
15083	Organic light brown sugar	170
15084	organic bread flour	2682
15085	organic whole eggs	14
15086	organic sour cream cultured	25
15087	Vegan granulated sugar	170
15088	vegan powdered sugar	170
15089	vegan spread natural oil blend palm fruit	201
15090	and olive oils	6
15091	filtere	2683
15092	certified 100% organic wheat flour	131
15093	organic cultured cream cheese organic skim milk	30
15094	organic skim milk powder	7
15095	non-gmo lactic culture	867
15096	cage free organic whole eggs	14
15097	organic skim mi	472
15098	o	5
15099	organic strawberry fruit filling organic sugar	448
15100	organic lemon j	200
15101	unsalted butter pasteurized cr	2
15102	organic cultured cream cheese o	30
15103	folic acid whole eggs	727
15104	unsalted butter pasteurized cream	2
15105	ghirardelli sweet ground chocolate and cocoa sugar	118
15106	cocoa-processed with alkali	118
15107	cocoa - processed with alkali	118
15108	unsweetened chocolate soy lecithin - an emulsifier	185
15109	ghirardelli unsweetened chocolate	1817
15110	b.bifidum	1215
15111	past	704
15112	Tomato paste and salt	148
15113	Ingredients: wine vinegar	480
15114	Ingredients: white wine vinegar	480
15115	Ingredients: cooked grape must	150
15116	persian & key lime juices	61
15117	organic agave nectar real cucumber oil	2684
15118	real mint oil	458
15119	and 0.1 sodium benzoate	354
15120	unsweetened dosicated coconut treated with sodium metabisulfate	68
15121	coconut cream oil.	135
15122	chili seasoning chili peppers	195
15123	Organic whole wheat organic cracked whole wheat	802
15124	organic whole wheat flour water	5
15125	blues mix organic sunflower seeds	271
15126	organic ground whole flax seeds	157
15127	organic blue cornmeal	838
15128	organic un-hulled brown sesame seeds	266
15129	good seed mix organic whole flax seeds	157
15130	organic un-hulled black sesame seeds	2685
15131	organic dried cane sugar	170
15132	organic steel cut oats	78
15133	organic oat fiber	601
15134	organic cultured whole wheat.	802
15135	Organic whole wheat organic whole wheat flour	283
15136	organic rolled whole wheat	802
15137	organic cracked whole rye	217
15138	organic dried cane syrup sugar	170
15139	organic caraway seeds	521
15140	organic cultured whole wheat	802
15141	organic cracked whole wheat	802
15142	21 whole grains and seeds mix organic whole flax seeds	157
15143	organic rolled spelt	302
15144	organic rolled barley	255
15145	organic yellow cornmeal	149
15146	organic rolled kamut khorasan wheat	296
15147	organic buckwheat flour	166
15148	organic sorghum flour	1611
15149	organic poppy seeds	1310
15150	Organic whole spelt flour	262
15151	powderseed mix organic whole flax seeds	157
15152	organic fruit juices pear	284
15153	organic barley malt.	635
15154	powerseed mix organic whole flax seeds	157
15155	Organic wheat organic sprouted whole wheat flour	131
15156	sprouted flake mix organic sprouted barley flakes	255
15157	organic sprouted oat flakes	78
15158	organic sprouted eye flakes	157
15159	Organic wheat organic wheat flour	131
15160	ancient grains flour blend organic barley flour	993
15161	organic rye flour	235
15162	organic spelt flour	262
15163	organic millet flour	2686
15164	organic quinoa flour	167
15165	organic wheat gluten.	955
15166	Organic flour organic whole wheat flour	283
15167	organic rice bran extract.	2687
15168	Organic flour organic wheat flour	131
15169	organic un-hu	2688
15170	sin dawg mix organic sunflower seeds	271
15171	organic raisins seeds	67
15172	Organic wheat flour tortilla organic wheat flour	131
15173	baking powder monocalcium phosphate	259
15174	organic brown rice	2661
15175	pasteurized process nonfat cheddar cheese skim milk cheese cultured skim milk	32
15176	cheddar flavor	1388
15177	paprika and turmeric color	2689
15178	organic tamari water	5
15179	arrowroot.	757
15180	and pepper.	12
15181	Bread crumbs Enriched wheat flour Niacin	131
15182	contains 2% or less of : sugar	1
15183	&/or soybean &/or sunflower oils	243
15184	Ammonium chloride calcium sulfate	924
15185	dough conditioners L - cysteine monochloride	353
15186	Chicken flavoring salt	148
15187	dried chicken broth	41
15188	natual flavor	1302
15189	Bread crumbs enriched bleached wheat flour	131
15190	contains two percent or less of sugar	1
15191	leavening sodium bicarbo	258
15192	contains two 2 percent or less of: sugar	1
15193	dough conditioners	1052
15194	l - cysteine monochloride	951
15195	disodium inosinate and disodium guanylate flavor enhancers.	1039
15196	natural vanilla extract.	21
15197	cocoa liqour	118
15198	potassium metabisulphite as preservative.	2690
15199	Boneless skinless chicken breast meat.	117
15200	isolated potato product.	519
15201	Boneless	2691
15202	skinless chicken breast chunks with rib meat	117
15203	onion powder. breaded with: rice flour	9
15204	bre	2692
15205	skinless chicken breast strips with rib meat	117
15206	breaded and battered with: yellow corn flour	263
15207	breaded with: rice flour	138
15208	Boneless skinless chicken breast fillets with rib meat	117
15209	glazed with water and natural flavor.	1818
15210	cider and or concentrate.	373
15211	Durum flour niacin	466
15212	Blended aged peppers habanero	2693
15213	tabasco & cayenne peppers	195
15214	rhizopus oryzae culture	2694
15215	California extra virgin olive oil	6
15216	natural basil flavor.	48
15217	Aged balsamic vinegar	480
15218	natural raspberry flavor.	636
15219	California extra virgin olive oil cold pressed & unfiltered	6
15220	blood orange oil.	2695
15221	Raw kombucha made with organic white tea	851
15222	dried lavender tips	2696
15223	Raw kombucha made with naturally un-caffeinated organic white tea	851
15224	Wheat flour bleached wheat flour enriched niacin	131
15225	1/10 of 1% sodium benzoate as preservative and yellow no. 5 food color.	2697
15226	Cranberries apple juice concentrate	373
15227	dark red grape juice concentrate	150
15228	natural flavors incl bergamot	196
15229	juniper berry	2698
15230	black currant juice concentrate	2094
15231	dark or milk chocolate	118
15232	baking soda. contains one or more of the following: walnuts	258
15233	almond flavor	1466
15234	ammonium bicarbonat	24
15235	clam	482
15236	natural smoke	1314
15237	confectioner sugar	170
15238	teriyaki sauce soy sauce	39
15239	oranges orange zest	200
15240	ground orange pulp	1212
15241	confectioner sugar sugar	170
15242	distiled vinegar	480
15243	hababero peppers	2693
15244	sodium benzoate as a preservatives	454
15245	Stone-ground cacao	2499
15246	cacao butter	171
15247	coconut palm sugar.	170
15248	Roasted wheat bran	301
15249	maltodextrin from corn.	197
15250	salt cream cheese pasteurized cultured milk and cream	2699
15251	xanthan and/or guar gums salsa crushed tomatoe	265
15252	Gluten free certified oats	78
15253	non-gmo peanut butter peanuts organic evaporated cane juice	123
15254	non-gmo oil blend palm fruit	201
15255	flax and olives oils water	2700
15256	pea protein	564
15257	sunfl	147
15258	non-gmo peanut butter peanuts	123
15259	flax and olive oils water	2701
15260	hop oil	2702
15261	caramelized onion	2703
15262	smoked paprika.	55
15263	crushed chili	2229
15264	spices and salt.	148
15265	California yams	370
15266	organic peanut butter organic peanuts	123
15267	rice puffs rice	64
15268	organic dried currants	2704
15269	port wine	2705
15270	natural red wine coloring caramel color	357
15271	red beet juice	409
15272	purple	2706
15273	Cheddar cultured pasteurized milk	7
15274	carob and/or guar gum	475
15275	beer 9.5% alcohol.	384
15276	xanthan and/or guar gums beer 5.3% alcohol mus	265
15277	jalapenos water	1348
15278	Dark chocolate evaporated cane juice	2613
15279	fruitrim fruit juices	2517
15280	natural grain dextrins	2707
15281	superfood blend beet juice	409
15282	concord grape	2708
15283	pomegranate	412
15284	acai	264
15285	spirulina	351
15286	aloe vera	856
15287	barley grass	2709
15288	soy lecithin 98% oil free	185
15289	chlorella	2710
15290	wheat grass powder	2711
15291	wheat sprout	2712
15292	red raspberry leaf	2713
15293	hydrilla verticillata root	2714
15294	nova scotia dulse purple seaweed	2715
15295	mangosteen	2716
15296	resveratrol	2717
15297	soy protein crisps	276
15298	hemp powder	2718
15299	sunflower butter	2719
15300	pasley	22
15301	peanut paste.	1673
15302	pepitas	177
15303	walnut	733
15304	Almond	160
15305	peptas	2720
15306	to protect flavor	401
15307	Dry roasted unsalted peanuts	137
15308	Organic coconut milk	2129
15309	organic coconut syrup.	609
15310	vegetable or annatto color	174
15311	celtic sea salt	98
15312	juniper berries.	2698
15313	natural fig flavor	2721
15314	crystallized cane sugar.	170
15315	Pineapple rings	63
15316	clarified pineapple juice and sugar	1
15317	Pine apple slices	63
15318	organic unsweetened coconut	68
15319	organic flaxseed	157
15320	organic almond extract	2722
15321	organic cinnamon.	15
15322	calcium chloride added to maintain firmness	340
15323	calcium disodium edta added to help promote color retention	455
15324	ketchup tomatoes	19
15325	vinegar from glacial acetic acid	480
15326	hydrolyzed vegetable prot	267
15327	100% grass fed ground beef	33
15328	Organic apples.	213
15329	Organic mangos.	190
15330	organic flavors	2215
15331	coconut nectar	609
15332	unsweetened chocolate.	118
15333	Apples.	213
15334	Granny Smith Apples	2723
15335	Coconuts	68
15336	organic unsweetened cocoa.	118
15337	ground ginger.	28
15338	pork casing.	2724
15339	sheep casing.	2725
15340	Pie crust flour	131
15341	vegetable shortening hydrogenated soybean & cottonseed oil	1001
15342	margarine partially hydrogenated palm & palm kernel oil	201
15343	nonfat d	801
15344	Reduced fat milk vitamin a plamitate	1171
15345	Cultured pasteurized nonfat milk	7
15346	food starch corn	263
15347	potassium sorbate a flavor	338
15348	sodium and na	148
15349	carrageenan locust bean gum	2726
15350	Cultured low fat milk	735
15351	contains less than 2% of nonfat milk	7
15352	Soymilk Water	1895
15353	Blueberry Purée	411
15354	Less Than 2% of: Milk Protein Concentrate	291
15355	Vegetable and Berry Extracts Purple Carrot	2550
15356	Black Carrot	2674
15357	Lingonberry	2508
15358	Zinc Gluconate	2440
15359	less than 2% of: tricalcium phosphate	751
15360	cottonseed and/or sunflower and/or safflower oil	26
15361	extractives of capsicum and paprika	759
15362	vegetable oil may contain one or more of the following: sunflower	147
15363	corn and/or cottonseed oils	243
15364	salt dextrose	750
15365	cottonseed oil and/or sunflower oil and/or safflower oil	26
15366	cottonseed oil and/or sunflower oil and/or safflower oil. sugar	1
15367	garlic natural flavors	4
15368	romano cheese powder milk	969
15369	Potatoes. cottonseed oil and/or sunflower oil and/or safflower oil	34
15370	dehydrated yellow mustard distilled vinegar	95
15371	dehydrated veget	2727
15372	Vegetable Oils Palm Kernel	286
15373	Palm and/or Interesterified and Hydrogenated Soybean and/or Hydrogenated Cottonseed	243
15374	Chocolate Liquor Processed with Alkali Dutched	118
15375	Contains 2 Percent or Less of: Cornstarch	263
15376	Dehydrated Reduced Mineral Whey	193
15377	Natural Flavors and Leavening Baking Soda.	24
15378	Unbromated unbleached enriched wheat flour flour	131
15379	soybean oil; contains 2% or less of: salt	243
15380	vegetable oils palm and/or interesterified and hydrogenated soybean and/or hydrogenated cottonseed	26
15381	DEHYDRATED SKIM MILK	472
15382	BUTTER OIL SOY LECITHIN	185
15383	MILKFAT AND LEAVENING BAKING SODA.	24
15384	CONTAINS 2 PERCENT OR LESS OF: LEAVENING BAKING SODA	24
15385	NATURAL FLAVORS AND TREE NUT MEAL PECAN	2728
15386	MACADAMIA	753
15387	ALMOND.	160
15388	Unbleached enriched wheat flour	131
15389	vegetable oils palm and/or interesterified and hydrogenated soybean	243
15390	Vegetable Palm Kernel	286
15391	Palm And/Or Interesterfied And Hydrogenated Soybean And/Or Hydrogenated Cottonseed	2729
15392	Contains 2 Percent Or Less Of: Dextrose	750
15393	vegetable oils canola	90
15394	contains 2 percent or less of: salt	148
15395	baking soda and annatto extract	2730
15396	huito juice concentrate	1953
15397	watermelon juice concentrate for color	1952
15398	spices contains celery and dehydrated onions.	834
15399	CONTAINS 2 PERCENT OR LESS OF: SUGAR	1
15400	ENZYME MODIFIED CHEDDAR CHEESE MILK	1284
15401	SPICES CONTAINS CELERY	27
15402	CALCIUM LACTATE. NATURAL FLAVORS AND MILKFAT.	857
15403	CONTAINS 2 PERCENT OR LESS OF: YEAST	294
15404	SPICES AND DEHYDRATED ONIONS. ADDS A TRIVIAL AMOUNT OF CHOLESTEROL.	9
15405	Made from: whole wheat flour	283
15406	rye meal	2731
15407	unsulphured molasses	156
15408	contains 2 percent or less of: rye flour	235
15409	cocoa processed with alkali dutched	118
15410	calcium propionate and sorbic acid to retard spoilage	966
15411	Pistachios.	320
15412	Ingredients: pistachios.	320
15413	red chili pepper	195
15414	maize starch	263
15415	acidity regulator: cream of tartar; flavorings	2732
15416	colours e120	2733
15417	e141	729
15418	e161b.	768
15419	amaze starch	139
15420	acidity regulator: cream of tartar	2732
15421	fruit and vegetable concentrates	2734
15422	natural flavouring.	210
15423	cellulose gum guar gum	475
15424	natural strawberry flavor with other natural flavors water	448
15425	dark chocolate flavor corn syrup	596
15426	non-fat-dry milk	801
15427	natural/artificial vanilla flavoring propylene glycol	2735
15428	caramel flavoring	452
15429	New zealand wagyu beef	2736
15548	Organic peppercorns black	12
15430	contains less than 2% of the following: sea salt	98
15431	natural flavor onion	9
15432	cherry powder.	371
15433	refined sugar	1131
15434	chocolate flavor	186
15435	artificial colors fd & c red 40	677
15436	jalapeno peppers.	195
15437	vegetable and olive oil blend	6
15438	red wine vinegar 5% acidity	480
15439	sweet onion	2737
15440	basil garlic powder	48
15441	turmeric coloring.	175
15442	artificial colors including fd&c blue 1	795
15443	turmeric coloring	175
15444	and bht added as a preservative.	747
15445	artificial colors including fd&c red 40 and fd&c blue 1	795
15446	turmeric coloring and titanium dioxide.	383
15447	and turmeric coloring.	383
15448	fd&c blue 1 lake	2738
15449	fd&c blue 1 lake and turmeric coloring.	2738
15450	and bht added as preservative.	721
15451	bht added as a preservative.	721
15452	artificial colors including fd&c red 40 and fd & c blue 1	795
15453	and and titanium dioxide.	369
15454	artificial color including fd&c red 40	677
15455	artificial color fd&c red 40.	677
15456	artificial colors including fd&c blue 1 and fd&c red 40 and turmeric coloring.	795
15457	fd&c blue 1. turmeric coloring	2738
15458	condensed skim milk	2739
15459	fd&c blue 2 lake	2430
15460	fd&c red 40 lake	677
15461	fd&c yellow 6	403
15462	and fd&c yellow 6 lake	2740
15463	and bht added as preserva	721
15464	artificial colors including fd&c yellow 5	795
15465	and blue 1	2404
15466	palm and soybean	957
15467	vitamin e d-alpha tocopheryl acetate	169
15468	Buckwheat honey.	36
15469	Fava beans	2741
15470	Enriched wheat flour contains gluten niacin	131
15471	thiamine vitamin b1	1085
15472	ferrous fumarate	251
15473	palm oil shortening	201
15474	humectant glucose	315
15475	pasteurized. liquid	2742
15476	artificial colors: fd&c yellow #5	403
15477	fd&c red # 40	677
15478	fd&c yellow # 6	403
15479	fd&c blue # 1.	2738
15480	niacin ferrous fumarate	466
15481	palm oil shortening non hydrogenated	201
15482	soy flour emulsifier water	547
15483	artificial colors fd&c yellow 5	403
15484	fd&c yellow 6. provides an insignificant amount of trans fat.	403
15485	palm oi shortening non hydrogenated	201
15486	artificial colors fd& c red #3	849
15487	fd&c red #40.  provides an insignificant amount of trans fat.	677
15488	leavening agent sodium bicarbonate. provides an insignificant amount of trans fat.	24
15489	rivoflavin vitamin b2	818
15490	palm oil shortening non-hydrogenated	201
15491	leavening agent sodium bicarbonate.	24
15492	artificial colors: fd&c red #40	677
15493	artificial colors: fd&c red # 40	677
15494	fd&c yellow # 5	403
15495	milk cream	473
15496	Dried date	2743
15497	sulfite added as preservative.	426
15498	Banana sauce	1489
15499	cottonseed oil sugar	1
15500	raspberry and apricot filling	2744
15501	apple jam	213
15502	Diced tomatoes with natural juice	240
15503	garlic-fresh & dehydrated	4
15504	Peru dark chocolate cocoa	118
15505	natural flavor cane sugar	873
15506	cocoa processed with alkali.	118
15507	Dominican republic white chocolate sugar	1
15508	Venezuela milk chocolate sugar	1
15509	All natural panko unbleached wheat	143
15510	buffalo style panko seasoning sea salt	98
15511	distilled vinegar powder	480
15512	hot sauce powder	195
15513	All natural panko unbleached wheat flour	131
15514	thai coconut curry panko seasoning sea salt	98
15515	natural flavor torula yeast	209
15516	dehydrated red pepper	195
15517	ses	153
15518	pecan panko seasoning sea salt	148
15519	macadamia coconut panko seasoning sea salt	98
15520	almond lemon panko seasoning sea salt	160
15521	italian panko seasoning sea salt	98
15522	pistachio garlic panko seasoning dehydrated garlic	4
15523	rosemary garlic panko seasoning spices including paprika	4
15524	organic dehydrated lemon peel. organic spice	909
15525	organic lemon oil	910
15526	organic spice extractive.	199
15527	Organic spices including paprika	834
15528	organic dehydrated garlic and onion.	1110
15529	Organic spices including paprika and turmeric for color	834
15530	organic garlic and onion powder	1309
15531	organic powdered sugar.	170
15532	Organic spices including paprika and mustard	834
15533	organic dehydrated vegetables garlic and onion	1110
15534	organic dehydrated celery and organic spice extractive.	27
15535	organic white vinegar powder organic white distilled vinegar	480
15536	organic dehydrated red bell pepper	84
15537	organic onion and garlic powder	1408
15538	organic beet powder	174
15539	malic	345
15540	Organic dehydrated vegetables organic garlic	4
15541	and organic red bell pepper	84
15542	organic dehydrated lemon peel	909
15543	organic sesame seed	1967
15544	organic toasted sesame seed oil	112
15545	organic sumac type flavor powder organic maltodextrin from corn	197
15549	and pink.	2745
15550	organic molasses powder organic molasses	156
15551	organic spices including turmeric	383
15552	organic bitter orange powder	2746
15553	organic spices including annatto	834
15554	organic dehydrated orange peel	366
15555	organic orange oil	649
15556	Organic spices including mustard	95
15557	organic lime flavor organic soybean oil	243
15558	organic lime flavor with other natural flavors	85
15559	organic molasses powder organic molasse	156
15560	Organic spices sea salt	98
15561	organic dehydrated garlic and onion	1110
15562	organic arrowroot	1749
15563	Organic spices including organic turmeric	383
15564	and paprika.	55
15565	Organic spice including paprika	55
15566	organic dehydrated garlic.	4
15567	Organic dehydrated vegetables garlic	4
15568	organic sesame seed white and black	1967
15569	organic mushroom	1621
15570	organic orange peel	366
15571	and organic chives.	99
15572	organic dehydrated vegetables onion and garlic	670
15573	and organic mushroom.	1621
15574	organic coffee powder	550
15575	and organic cocoa powder.	118
15576	Sea salt and organic coffee.	148
15577	organic black sesame seeds	266
15578	organic kelp	2747
15579	organic green tea powder	501
15580	organic red and organic green bell pepper	536
15581	organic carrot powder	119
15582	organic chives	99
15583	organic sesame seeds organic white	266
15584	organic black	12
15585	organic spices including organi	834
15586	Cultured pasteurized grade a skim milk	7
15587	potassium sorbate for freshness	338
15588	Greek yogurt cultured pasteurized grade a nonfat milk	887
15589	cream cheese pasteurized	30
15590	stabilizers	2748
15591	pure vanilla.	20
15592	light cream cheese pasteurized	30
15593	Greek yogurt cultured pasteurized grade a nonfat milk light cream cheese pasteurized cultured milk and cream	7
15594	stabilizers eggs	185
15595	premium coca	585
15596	artificial flavor and coloring added.	2749
15597	shortening soybean and palm oils with mono and diglycerides malt	243
15598	cracked wheat & whole wheat	802
15599	shortening soybean & cottonseed	944
15600	Dextrose fruit pectin	750
15601	citric acid assists gel.	200
15602	citric acid assists gel	200
15603	citric acid and lactic acid assists gel	2750
15604	green bell pepper granules	195
15605	anise white pepper	2751
15606	silicon dioxide anticaking.	309
15607	Milk and dark chocolate: sugar	1
15608	Milk chocolate: sugar	1
15609	vanillin an artificial flavor sugar	186
15610	chocolate processed w/alkali	118
15611	coconut: coconut	68
15612	nuts: pecans	732
15613	peanut butter: peanuts	173
15614	hydrogenated vegetable oil rapeseed & cottonseed oils	26
15615	cherries: cherries	189
15616	invertase an enzyme	2396
15617	Dark chocolate: sugar	1
15618	potato chips potatoes	34
15619	vegetable oils peanut	741
15620	salt cherries: cherries	189
15621	peanut butter: peanut	137
15622	coconut with sodium metabisulfite for color retention	2752
15623	calcium caseinate milk	640
15624	chocolate liquor processed w/alkali	118
15625	lemon juice solids and oils	200
15626	Milk and dark chocolate sugar	1
15627	cocoa butter pecans	171
15628	Fordhook lima beans.	228
15629	Yellow and white corn.	134
15630	Pearl onions.	2753
15631	natural flavor hydrolyzed corn gluten	267
15632	Cooked winter squash	2754
15633	pasteurized process cheese sauce concentrate cheddar and other natural cheese pasteurized milk	32
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ingredients (id, name, category, health_label, health_score, created_at) FROM stdin;
1	sugar	sweetener	caution	2.5	2026-05-07 22:00:36.564118
2	butter	fat	caution	4.2	2026-05-07 22:00:36.908478
3	eggs	protein	healthy	8.5	2026-05-07 22:00:37.09035
4	garlic	spice	healthy	9	2026-05-07 22:00:37.266484
5	water	mineral	healthy	10	2026-05-07 22:00:37.464229
6	olive oil	fat	healthy	8.5	2026-05-07 22:00:37.64704
7	milk	protein	healthy	8.5	2026-05-07 22:00:37.850138
8	flour	fiber	healthy	8	2026-05-07 22:00:38.029426
9	onion	vegetable	healthy	8.5	2026-05-07 22:00:38.268362
10	pepper	spice	healthy	9	2026-05-07 22:00:38.537728
11	onions	vegetable	healthy	8.5	2026-05-07 22:00:38.889402
12	black pepper	spice	healthy	9	2026-05-07 22:00:39.334354
13	brown sugar	sweetener	neutral	4	2026-05-07 22:00:39.645413
14	egg	protein	healthy	8.5	2026-05-07 22:00:39.813975
15	cinnamon	spice	healthy	9	2026-05-07 22:00:40.070487
16	all-purpose flour	fiber	neutral	6.5	2026-05-07 22:00:40.345639
17	baking powder	leavening agent	neutral	8	2026-05-07 22:00:40.508841
18	lemon juice	natural flavor	healthy	9	2026-05-07 22:00:40.711672
19	tomatoes	fruit	healthy	9.5	2026-05-07 22:00:40.87003
20	vanilla	natural flavor	healthy	9	2026-05-07 22:00:41.21103
21	vanilla extract	natural flavor	healthy	9	2026-05-07 22:00:41.369568
22	parsley	herb	healthy	9.5	2026-05-07 22:00:41.521501
23	unsalted butter	fat	caution	4.2	2026-05-07 22:00:41.83562
24	baking soda	leavening agent	neutral	8	2026-05-07 22:00:42.050064
25	sour cream	dairy	neutral	6.5	2026-05-07 22:00:42.366753
26	vegetable oil	fat	neutral	5.5	2026-05-07 22:00:42.703493
27	celery	fiber	healthy	9	2026-05-07 22:00:43.127763
28	ginger	spice	healthy	9	2026-05-07 22:00:43.476302
29	lemon	natural flavor	healthy	9.5	2026-05-07 22:00:43.635164
30	cream cheese	dairy	caution	4.2	2026-05-07 22:00:43.800269
31	carrots	fiber	healthy	9.5	2026-05-07 22:00:46.23168
32	cheddar cheese	dairy	neutral	6.5	2026-05-07 22:00:48.676098
33	beef	protein	neutral	6.5	2026-05-07 22:00:51.142953
34	potatoes	starch	healthy	8.5	2026-05-07 22:00:53.75579
35	oil	fat	neutral	5	2026-05-07 22:00:56.20079
36	honey	sweetener	healthy	8.5	2026-05-07 22:00:56.206266
37	nutmeg	spice	healthy	8.5	2026-05-07 22:00:58.758244
38	cheese	protein	neutral	6.5	2026-05-07 22:01:01.210331
39	soy sauce	condiment	neutral	6.5	2026-05-07 22:01:03.723747
40	mayonnaise	condiment	caution	4.2	2026-05-07 22:01:06.265794
41	chicken broth	natural flavor	neutral	6.5	2026-05-07 22:01:08.792447
42	oregano	spice	healthy	9	2026-05-07 22:01:11.385986
43	cumin	spice	healthy	9	2026-05-07 22:01:13.977133
44	thyme	spice	healthy	9.5	2026-05-07 22:01:16.60286
45	garlic powder	spice	healthy	9	2026-05-07 22:01:19.227802
46	mushrooms	fiber	healthy	8.5	2026-05-07 22:01:24.050704
47	cilantro	spice	healthy	9	2026-05-07 22:01:24.016088
48	basil	spice	healthy	9.5	2026-05-07 22:01:26.632438
49	pecans	nut	healthy	8.5	2026-05-07 22:01:29.335053
50	bacon	protein	caution	4.2	2026-05-07 22:01:31.738197
52	heavy cream	fat	caution	4.2	2026-05-07 22:25:25.989385
53	chicken breasts	protein	healthy	8.5	2026-05-07 22:25:26.156199
54	worcestershire sauce	condiment	neutral	6.5	2026-05-07 22:25:26.384285
55	paprika	spice	healthy	8.5	2026-05-07 22:25:26.547764
56	chocolate	fat	caution	6.5	2026-05-07 22:25:26.724202
57	chicken	protein	healthy	8.5	2026-05-07 22:25:26.890096
58	walnuts	nut	healthy	8.5	2026-05-07 22:25:27.105834
59	chili powder	spice	healthy	8.5	2026-05-07 22:25:27.270355
60	almonds	protein	healthy	8.5	2026-05-07 22:25:27.452624
61	lime juice	natural flavor	healthy	9	2026-05-07 22:25:27.740007
62	parmesan cheese	protein	healthy	8.5	2026-05-07 22:25:28.100765
63	pineapple	fruit	healthy	8.5	2026-05-07 22:25:28.276078
64	rice	fiber	healthy	8.5	2026-05-07 22:25:28.462181
65	orange juice	natural flavor	healthy	8.5	2026-05-07 22:25:28.89694
66	green pepper	vegetable	healthy	8.5	2026-05-07 22:25:29.159808
67	raisins	natural sweetener	healthy	8.5	2026-05-07 22:25:29.500649
68	coconut	fat	healthy	8	2026-05-07 22:25:29.740827
69	cayenne pepper	spice	healthy	8.5	2026-05-07 22:25:29.918427
70	dijon mustard	condiment	healthy	8.5	2026-05-07 22:25:30.112687
71	mzarella cheese	protein	neutral	6.5	2026-05-07 22:25:30.38678
72	buttermilk	dairy	healthy	8.5	2026-05-07 22:25:30.558845
73	vinegar	preservative	healthy	8	2026-05-07 22:25:30.781988
74	apples	fruit	healthy	9	2026-05-07 22:25:31.017977
75	red pepper	spice	healthy	8.5	2026-05-07 22:25:31.196704
76	tomato sauce	natural flavor	healthy	8.5	2026-05-07 22:25:31.361761
77	bread crumbs	thickener	neutral	6.5	2026-05-07 22:25:31.688113
78	oats	fiber	healthy	9	2026-05-07 22:25:31.872814
79	spinach	fiber	healthy	9.5	2026-05-07 22:25:32.223926
80	shortening	fat	caution	4	2026-05-07 22:25:32.475824
81	red pepper flakes	spice	healthy	8.5	2026-05-07 22:25:34.934693
82	shallots	spice	healthy	8.5	2026-05-07 22:25:37.523296
83	tomato paste	natural flavor	healthy	8.5	2026-05-07 22:25:37.533873
84	red bell pepper	vegetable	healthy	9.5	2026-05-07 22:25:39.967838
85	lime	fruit	healthy	9.5	2026-05-07 22:25:42.55186
86	shrimp	protein	healthy	8.5	2026-05-07 22:25:44.988934
87	zucchini	vegetable	healthy	9.5	2026-05-07 22:25:47.46301
88	strawberries	fruit	healthy	9.5	2026-05-07 22:25:50.081404
89	rosemary	spice	healthy	9.5	2026-05-07 22:25:52.576658
90	canola oil	fat	neutral	6.5	2026-05-07 22:25:55.112037
91	green onions	spice	healthy	9	2026-05-07 22:25:57.586869
92	bananas	fruit	healthy	9	2026-05-07 22:26:00.102679
93	scallions	spice	healthy	9	2026-05-07 22:26:02.61154
94	cloves	spice	healthy	8.5	2026-05-07 22:26:05.15518
95	mustard	spice	healthy	8.5	2026-05-07 22:26:04.994907
96	cocoa powder	natural flavor	healthy	8.5	2026-05-07 22:26:07.426881
97	chicken stock	natural flavor	neutral	8	2026-05-07 22:26:10.010664
98	sea salt	mineral	neutral	8	2026-05-07 22:26:12.418901
99	chives	spice	healthy	9	2026-05-07 22:26:15.023371
100	whipping cream	fat	caution	4.2	2026-05-07 22:26:17.446753
101	bread	carbohydrate	neutral	6.5	2026-05-07 22:26:20.045203
102	maple syrup	sweetener	neutral	6.5	2026-05-07 22:26:22.579945
103	orange	fruit	healthy	9.5	2026-05-07 22:26:25.111203
104	balsamic vinegar	condiment	healthy	8.5	2026-05-07 22:26:27.655735
105	dry white wine	natural flavor	caution	4.2	2026-05-07 22:26:30.104713
106	coriander	spice	healthy	8.5	2026-05-07 22:26:32.551809
107	bay leaf	spice	healthy	9	2026-05-07 22:26:32.443456
108	ketchup	condiment	neutral	6.5	2026-05-07 22:26:34.966075
109	yogurt	protein	healthy	8.5	2026-05-07 22:26:37.549968
110	red wine vinegar	acidifier	neutral	8	2026-05-07 22:26:40.019443
111	avocado	fruit	healthy	9	2026-05-07 22:26:42.434438
112	sesame oil	fat	healthy	8.5	2026-05-07 22:26:45.011555
113	cabbage	fiber	healthy	9.5	2026-05-07 22:26:47.555211
114	bay leaves	spice	healthy	9	2026-05-07 22:26:50.055719
115	chocolate chips	sweetener	caution	4.2	2026-05-07 22:26:52.669573
116	broccoli	fiber	healthy	9.5	2026-05-07 22:26:55.190134
117	chicken breast	protein	healthy	9	2026-05-07 22:26:59.292083
118	cocoa	natural flavor	healthy	8.5	2026-05-07 22:27:00.075238
119	carrot	fiber	healthy	9.5	2026-05-07 22:27:02.535369
120	basil leaves	spice	healthy	9.5	2026-05-07 22:27:05.052463
121	onion powder	spice	healthy	8.5	2026-05-07 22:27:07.526912
122	cucumber	vegetable	healthy	9.5	2026-05-07 22:27:09.98717
123	peanut butter	protein	healthy	8.2	2026-05-07 22:27:12.591877
124	allspice	spice	healthy	8.5	2026-05-07 22:27:15.194033
125	dry mustard	spice	neutral	8	2026-05-07 22:27:17.71012
126	cranberries	fruit	healthy	8.5	2026-05-07 22:27:20.21151
127	mint	natural flavor	healthy	9.5	2026-05-07 22:27:22.681317
128	ham	protein	caution	4.2	2026-05-07 22:27:25.275162
129	green bell pepper	vegetable	healthy	9.5	2026-05-07 22:27:25.065297
130	blueberries	fruit	healthy	9.5	2026-05-07 22:27:27.50239
131	wheat flour	fiber	healthy	8.5	2026-05-07 22:27:32.348603
132	peas	fiber	healthy	9.5	2026-05-07 22:27:34.902108
133	curry powder	spice	healthy	8.5	2026-05-07 22:27:37.496084
134	corn	fiber	healthy	8.5	2026-05-07 22:27:40.136598
152	walnuts and oat bran	\N	\N	\N	2026-05-10 01:20:24.425704
225	none	\N	\N	\N	2026-05-10 01:29:10.929743
137	peanut	protein	healthy	8.5	2026-05-10 01:20:20.548488
138	rice flour	thickener	neutral	6.5	2026-05-10 01:20:20.754128
140	sodium chloride	mineral	caution	4	2026-05-10 01:20:21.218923
142	soy	protein	healthy	8.5	2026-05-10 01:20:22.039973
143	wheat	fiber	healthy	8.5	2026-05-10 01:20:22.183098
144	hazelnuts	nut	healthy	8.5	2026-05-10 01:20:22.584714
146	tree nuts	protein	healthy	8.5	2026-05-10 01:20:23.109495
147	sunflower oil	fat	neutral	6.5	2026-05-10 01:20:23.308395
149	cornmeal	fiber	healthy	8.5	2026-05-10 01:20:23.581139
151	sunflower seed	protein	healthy	8.5	2026-05-10 01:20:24.249643
153	sesame	fiber	healthy	8.5	2026-05-10 01:20:24.632309
155	rolled oats	fiber	healthy	9	2026-05-10 01:20:25.660204
156	molasses	sweetener	neutral	6.5	2026-05-10 01:20:32.922896
158	cannabis sativa seed	protein	healthy	8	2026-05-10 01:20:40.202201
160	almond	nut	healthy	8.5	2026-05-10 01:20:47.025519
161	pumpkin seed	seed	healthy	8.5	2026-05-10 01:20:56.031933
162	maize	fiber	healthy	8.5	2026-05-10 01:20:58.40275
165	corn flour	thickener	neutral	6.5	2026-05-10 01:21:05.294081
166	buckwheat flour	fiber	healthy	8.5	2026-05-10 01:21:09.859608
168	amaranth	protein	healthy	8.5	2026-05-10 01:21:14.300436
169	vitamin e	vitamin	healthy	9.5	2026-05-10 01:21:16.488087
171	cocoa butter	fat	neutral	6.5	2026-05-10 01:21:23.420434
172	adzuki beans	protein	healthy	8.5	2026-05-10 01:24:22.220492
174	beetroot	fiber	healthy	9	2026-05-10 01:24:23.308847
175	curcumin	spice	healthy	9.5	2026-05-10 01:24:23.484889
177	pumpkin seeds	protein	healthy	8.5	2026-05-10 01:24:24.77914
180	wheat germ	fiber	healthy	9	2026-05-10 01:24:25.497882
181	safflower oil	fat	neutral	6.5	2026-05-10 01:24:25.605006
183	chocolate coated raisins	sweetener	caution	4.2	2026-05-10 01:24:35.677359
184	carica papaya	fruit	healthy	8.5	2026-05-10 01:24:37.92149
185	lecithin	emulsifier	neutral	8	2026-05-10 01:24:48.943942
187	rapeseed oil	fat	neutral	6.5	2026-05-10 01:24:55.526931
188	cranberry	fruit	healthy	8.5	2026-05-10 01:25:02.211684
190	mango	fruit	healthy	9	2026-05-10 01:25:19.922314
191	oat bran	fiber	healthy	9	2026-05-10 01:25:22.147796
193	whey	protein	healthy	8.5	2026-05-10 01:25:35.405424
194	phosphate	mineral	caution	4.5	2026-05-10 01:25:37.584648
196	flavorings	natural flavor	neutral	5	2026-05-10 01:25:44.222798
198	spice	spice	healthy	8	2026-05-10 01:25:48.545216
199	spice extract	spice	healthy	8	2026-05-10 01:25:50.777077
200	citric acid	preservative	neutral	8	2026-05-10 01:25:52.972693
202	rice bran	fiber	healthy	8.5	2026-05-10 01:26:03.849362
204	malt	sweetener	neutral	6.5	2026-05-10 01:26:08.238144
205	carob gum	thickener	neutral	8	2026-05-10 01:26:10.508501
207	linseed	fiber	healthy	8.5	2026-05-10 01:26:23.687484
208	raspberry	fruit	healthy	9.5	2026-05-10 01:26:25.945544
210	natural flavor	natural flavor	neutral	8	2026-05-10 01:26:41.297646
211	seasoning	spice	neutral	8	2026-05-10 01:26:48.154661
213	apple	fruit	healthy	9.5	2026-05-10 01:27:27.813492
214	beans	protein	healthy	8.5	2026-05-10 01:27:50.016271
217	rye	grain	healthy	8.5	2026-05-10 01:28:10.168328
219	diacetyltartaric acid esters of mono- and diglycerides	emulsifier	neutral	6.5	2026-05-10 01:29:09.73749
220	glucose syrup	sweetener	caution	4.2	2026-05-10 01:29:10.202018
222	chickpeas	protein	healthy	8.5	2026-05-10 01:29:10.407448
223	dietary fiber	fiber	healthy	9.5	2026-05-10 01:29:10.623924
226	navy beans	protein	healthy	9	2026-05-10 01:29:11.023172
227	mung bean	protein	healthy	8.5	2026-05-10 01:29:11.429235
229	kidney bean	protein	healthy	8.5	2026-05-10 01:29:11.690393
230	cardamom	spice	healthy	8.5	2026-05-10 01:29:12.185905
232	fenugreek	spice	healthy	8.5	2026-05-10 01:29:12.484789
234	glycerol	humectant	neutral	8	2026-05-10 01:29:28.125565
235	rye flour	fiber	healthy	8.5	2026-05-10 01:29:30.384512
237	anthocyanin	antioxidant	healthy	9.5	2026-05-10 01:29:43.520917
239	durum wheat flour	fiber	healthy	8.5	2026-05-10 01:29:50.200687
240	tomato	fruit	healthy	9.5	2026-05-10 01:29:54.574146
164	quinoa amaranth corn meal	grain	healthy	8.5	2026-05-10 01:21:02.937821
178	water and salt	mineral	healthy	10	2026-05-10 01:24:25.080745
241	tomato and spinach	vegetable	healthy	9.5	2026-05-10 01:30:01.142997
288	malted barley, peanuts, raisins, chocolate, corn	\N	\N	\N	2026-05-10 01:33:37.588961
308	nu	\N	\N	\N	2026-05-10 01:39:53.070663
362	milk, pork, vegetables, salt, sugar	\N	\N	\N	2026-05-10 01:45:07.999772
243	soybean oil	fat	neutral	6.5	2026-05-10 01:30:05.598291
245	piper nigrum and myristica fragrans	spice	healthy	8.5	2026-05-10 01:30:12.260456
246	pasta	carbohydrate	neutral	6.5	2026-05-10 01:30:14.585098
248	vitamin b2	vitamin	healthy	9.5	2026-05-10 01:30:19.103649
250	vitamin b3	vitamin	healthy	9.5	2026-05-10 01:30:27.82802
251	iron	mineral	healthy	9	2026-05-10 01:30:30.020113
253	triticale	grain	healthy	8.5	2026-05-10 01:30:36.578686
254	oat	fiber	healthy	9	2026-05-10 01:30:38.749225
256	soybean	protein	healthy	8.5	2026-05-10 01:30:43.101955
258	sodium bicarbonate	leavening agent	neutral	8	2026-05-10 01:30:52.078256
259	monocalcium phosphate	mineral	neutral	5	2026-05-10 01:30:56.412688
260	vitamin b	vitamin	healthy	9	2026-05-10 01:31:07.451353
262	spelt flour	fiber	healthy	8.5	2026-05-10 01:31:11.875729
264	acai	fruit	healthy	8.5	2026-05-10 01:31:18.658508
265	xanthan gum	thickener	neutral	8	2026-05-10 01:31:29.747235
267	hydrolyzed vegetable protein	protein	caution	4.5	2026-05-10 01:31:40.606385
268	smoke flavor	natural flavor	neutral	6.5	2026-05-10 01:31:42.776852
270	milk sugar	sweetener	neutral	6.5	2026-05-10 01:31:53.713374
271	sunflower seeds	protein	healthy	8.5	2026-05-10 01:31:55.990105
273	monounsaturated oil	fat	healthy	8.5	2026-05-10 01:32:02.594376
274	oat flour	fiber	healthy	8.5	2026-05-10 01:32:26.716027
276	soy protein	protein	healthy	8.5	2026-05-10 01:32:40.174326
277	soybeans	protein	healthy	8.5	2026-05-10 01:32:44.570795
279	potato	starch	healthy	8.5	2026-05-10 01:32:53.402474
281	allium sativum	spice	healthy	9	2026-05-10 01:33:04.350018
282	figs	fruit	healthy	8.5	2026-05-10 01:33:10.927306
284	pear juice	natural flavor	healthy	8.5	2026-05-10 01:33:15.374441
285	lactate	preservative	neutral	6.5	2026-05-10 01:33:21.980298
287	malted barley	grain	healthy	8.5	2026-05-10 01:33:33.152729
289	shellac	coating	caution	4	2026-05-10 01:33:39.904956
291	milk protein	protein	healthy	8.5	2026-05-10 01:33:48.725429
293	brine	preservative	neutral	5	2026-05-10 01:38:10.647634
295	lactic acid	preservative	neutral	8	2026-05-10 01:38:12.076471
296	kamut	grain	healthy	8.5	2026-05-10 01:38:12.490488
298	millet	fiber	healthy	8.5	2026-05-10 01:38:13.918922
300	hazelnut	nut	healthy	8.5	2026-05-10 01:38:18.774304
301	wheat bran	fiber	healthy	8.5	2026-05-10 01:38:36.146017
302	spelt	grain	healthy	8.5	2026-05-10 01:38:49.356862
304	cowpeas	protein	healthy	8.5	2026-05-10 01:39:06.865754
305	brown rice	fiber	healthy	8.5	2026-05-10 01:39:17.791464
307	corn oil	fat	neutral	6.5	2026-05-10 01:39:44.35453
309	silica	mineral	neutral	8	2026-05-10 01:40:10.984635
311	butter oil	fat	caution	4.2	2026-05-10 01:40:39.537672
313	sodium polyphosphate	preservative	caution	4.2	2026-05-10 01:41:03.783464
314	ammonium carbonate	leavening agent	caution	4	2026-05-10 01:41:05.961314
316	flavor	natural flavor	neutral	5	2026-05-10 01:41:14.832831
318	carotene	vitamin	healthy	9	2026-05-10 01:41:21.445829
319	citrate	preservative	neutral	8	2026-05-10 01:41:30.104989
321	prunes	fruit	healthy	8.5	2026-05-10 01:41:39.026313
323	currants	fruit	healthy	8.5	2026-05-10 01:41:45.614682
324	lettuce	fiber	healthy	9.5	2026-05-10 01:42:10.044301
326	gluten	protein	caution	4.5	2026-05-10 01:42:32.896539
328	calcium carbonate	mineral	neutral	8	2026-05-10 01:42:39.479474
329	vitamin c	vitamin	healthy	9.5	2026-05-10 01:42:41.751031
330	enzyme	enzyme	neutral	8	2026-05-10 01:42:44.012047
331	modified potato starch	thickener	neutral	6.5	2026-05-10 01:42:55.059109
333	egg powder	protein	healthy	8.5	2026-05-10 01:43:01.642917
334	sodium arginate	preservative	caution	4.5	2026-05-10 01:43:08.423092
336	sugar alcohol	sweetener	caution	4	2026-05-10 01:43:12.935298
337	pectin	thickener	healthy	8	2026-05-10 01:43:17.315726
339	locust bean gum	thickener	neutral	8	2026-05-10 01:43:21.827713
340	calcium chloride	mineral	neutral	8	2026-05-10 01:43:24.083398
342	agar	thickener	healthy	8.5	2026-05-10 01:43:30.767578
343	food coloring	artificial color	caution	2.5	2026-05-10 01:43:32.92038
344	fructose	sweetener	caution	4.2	2026-05-10 01:43:35.105784
346	safflower	oil	healthy	8.5	2026-05-10 01:43:41.615444
347	cucurbita	fiber	healthy	8.5	2026-05-10 01:43:43.801181
349	black currant	fruit	healthy	8.5	2026-05-10 01:43:48.246883
351	spirulina	protein	healthy	9.5	2026-05-10 01:43:54.745282
352	palm and canola oil	fat	caution	4.5	2026-05-10 01:43:59.335592
353	cysteine	amino acid	healthy	8.5	2026-05-10 01:44:01.533408
355	green lentils	protein	healthy	9	2026-05-10 01:44:23.62233
357	caramel color	artificial color	caution	2.5	2026-05-10 01:44:30.330166
358	dimethylpolysiloxane	emulsifier	caution	4.2	2026-05-10 01:44:37.113282
361	hazelnut paste	natural flavor	healthy	8.5	2026-05-10 01:44:56.975778
364	black tea with violet and blueberry flavor	natural flavor	healthy	8.5	2026-05-10 01:45:24.310635
365	black tea	beverage	healthy	8.5	2026-05-10 01:45:26.513914
367	sodium nitrite	preservative	caution	2	2026-05-10 01:45:30.875916
368	syrup	sweetener	caution	4	2026-05-10 01:45:44.113037
370	sweet potato	fiber	healthy	8.5	2026-05-10 01:46:06.29604
371	cherry	fruit	healthy	9	2026-05-10 01:46:08.489811
373	apple juice concentrate	sweetener	neutral	6.5	2026-05-10 01:46:21.954071
374	blackcurrant	fruit	healthy	8.5	2026-05-10 01:46:28.549805
376	egg white	protein	healthy	9	2026-05-10 02:15:18.610627
377	almond flour	fiber	healthy	8.5	2026-05-10 02:15:19.005019
378	lemon pulp	fiber	healthy	8.5	2026-05-10 02:15:19.69977
380	alginic acid	thickener	neutral	8	2026-05-10 02:15:20.085967
382	lemon flavor	natural flavor	neutral	8	2026-05-10 02:15:20.472173
383	turmeric	spice	healthy	9.5	2026-05-10 02:15:20.596969
292	emulsifier	emulsifier	neutral	5	2026-05-10 01:34:02.291214
360	rapeseed and sunflower	oil	healthy	8.5	2026-05-10 01:44:43.725756
431	unknown	\N	\N	\N	2026-05-11 06:39:45.462817
463	thiamine - butter - sugar - cornstarch - baking powder: e450	\N	\N	\N	2026-05-11 06:43:18.854747
467	baking soda, milk powder, salt	\N	\N	\N	2026-05-11 06:43:40.545083
481	apples and water	\N	\N	\N	2026-05-11 06:45:26.829081
504	sodium bicarbonate - sucrose - salt	\N	\N	\N	2026-05-11 06:47:27.891262
506	honey, cornstarch, vanilla powder, baking soda	\N	\N	\N	2026-05-11 06:47:35.991868
513	soy and milk may contain eggs and tree nuts	\N	\N	\N	2026-05-11 06:48:15.653834
387	whey protein	protein	healthy	8.5	2026-05-11 06:34:18.970169
389	pear brandy	alcohol	caution	4	2026-05-11 06:34:19.798626
390	gum arabic	thickener	neutral	8	2026-05-11 06:34:20.266949
391	malt extract	natural sweetener	neutral	6.5	2026-05-11 06:34:20.482994
393	butterfat	fat	caution	4.2	2026-05-11 06:34:22.147518
394	soy lecithin	emulsifier	neutral	8	2026-05-11 06:34:45.081378
396	artemisia dracunculus	spice	neutral	8	2026-05-11 06:35:12.230897
397	sulfites	preservative	caution	2.5	2026-05-11 06:35:16.496016
400	blueberry juice	natural flavor	healthy	8.5	2026-05-11 06:35:27.073742
404	brassica	vegetable	healthy	9	2026-05-11 06:35:51.717232
405	lactose	sugar	neutral	5	2026-05-11 06:36:12.032759
407	flavoring	natural flavor	neutral	5	2026-05-11 06:36:45.405123
409	beet juice	natural color	healthy	8.5	2026-05-11 06:37:06.478969
410	wax	thickener	caution	2	2026-05-11 06:37:08.656988
412	pomegranate	fruit	healthy	9.5	2026-05-11 06:37:12.921925
413	gelatine	thickener	neutral	6.5	2026-05-11 06:37:18.790959
415	carnauba wax	thickener	caution	4	2026-05-11 06:37:27.275493
416	allura red	artificial color	caution	2.5	2026-05-11 06:37:29.277918
418	fructan	fiber	healthy	8.5	2026-05-11 06:37:40.182841
420	tartaric acid	acidifier	neutral	8	2026-05-11 06:37:48.270465
421	fumaric acid	preservative	caution	4.2	2026-05-11 06:37:50.468891
423	fragaria	fruit	healthy	9.5	2026-05-11 06:38:34.301668
425	mango juice	natural flavor	healthy	8.5	2026-05-11 06:38:57.390538
427	peanut flavor	natural flavor	neutral	8	2026-05-11 06:39:22.174418
429	juice concentrate	natural flavor	neutral	6.5	2026-05-11 06:39:34.857468
430	retinol	vitamin	healthy	9	2026-05-11 06:39:43.322159
433	raspberries	fruit	healthy	9.5	2026-05-11 06:40:02.10339
434	hibiscus	natural flavor	healthy	8.5	2026-05-11 06:40:04.212556
438	coconut water	natural beverage	healthy	8.5	2026-05-11 06:40:39.283727
439	caper	spice	healthy	8.5	2026-05-11 06:40:47.589353
440	acetic acid and sodium chloride	preservative	caution	6.5	2026-05-11 06:40:49.687037
441	sheep milk	dairy	healthy	8.5	2026-05-11 06:41:14.632924
443	chymosin	enzyme	neutral	8	2026-05-11 06:41:18.836935
444	peach	fruit	healthy	8.5	2026-05-11 06:41:23.077136
446	monoglycerides and diglycerides	emulsifier	caution	4.5	2026-05-11 06:41:43.862476
448	strawberry	fruit	healthy	9.5	2026-05-11 06:41:56.564792
449	fruit puree	natural flavor	healthy	8.5	2026-05-11 06:42:04.601517
450	tomato juice	natural flavor	healthy	8.5	2026-05-11 06:42:08.930484
451	semolina	fiber	healthy	8.2	2026-05-11 06:42:21.917854
453	tamarind	fruit	healthy	8.5	2026-05-11 06:42:34.316073
454	benzoic acid	preservative	caution	4.2	2026-05-11 06:42:36.460559
456	gypsum	mineral	caution	2	2026-05-11 06:42:40.701181
457	magnesium	mineral	healthy	9.5	2026-05-11 06:42:42.73322
459	gelatin	protein	neutral	6.5	2026-05-11 06:42:49.1474
461	milk chocolate	fat	caution	4.2	2026-05-11 06:42:53.35925
462	ammonium chloride	mineral	caution	4.2	2026-05-11 06:43:12.651615
466	niacin	vitamin	healthy	9.5	2026-05-11 06:43:29.218488
470	soya lecithin	emulsifier	neutral	8	2026-05-11 06:44:03.803882
472	skim milk	protein	healthy	8.5	2026-05-11 06:44:24.757533
473	cream	fat	neutral	6.5	2026-05-11 06:44:26.817707
475	guar gum	thickener	neutral	8	2026-05-11 06:44:31.094523
476	mono- and di-glycerides of fatty acids	emulsifier	caution	4.5	2026-05-11 06:44:35.210407
478	beta carotene	vitamin	healthy	9.5	2026-05-11 06:44:53.815164
480	acetic acid	preservative	neutral	8	2026-05-11 06:45:20.79248
483	clam broth	natural flavor	neutral	6.5	2026-05-11 06:45:30.890341
484	clam extract	natural flavor	neutral	6.5	2026-05-11 06:45:32.963794
486	olive	fat	healthy	8.5	2026-05-11 06:45:41.259283
487	tomato puree	natural flavor	healthy	8.5	2026-05-11 06:45:53.726708
489	blackberry juice	natural flavor	healthy	8.5	2026-05-11 06:46:01.935739
491	camellia sinensis	natural flavor	healthy	9	2026-05-11 06:46:06.013091
492	biotin	vitamin	healthy	9.5	2026-05-11 06:46:10.142131
494	vitamin	vitamin	healthy	9	2026-05-11 06:46:18.346928
496	vitamin b5	vitamin	healthy	9	2026-05-11 06:46:28.939986
497	pineapple juice	natural flavor	healthy	8.5	2026-05-11 06:46:30.977872
498	glutamic acid	amino acid	neutral	8	2026-05-11 06:46:37.153428
500	cherry juice	natural flavor	healthy	8.5	2026-05-11 06:46:51.985117
501	green tea	antioxidant	healthy	9	2026-05-11 06:46:56.111249
503	iceberg lettuce	fiber	healthy	9.5	2026-05-11 06:47:17.223149
507	potassium bitartrate	preservative	caution	4.2	2026-05-11 06:47:38.11643
508	apricot flavor	natural flavor	neutral	8	2026-05-11 06:47:40.196686
510	blood sausage	protein	caution	4.2	2026-05-11 06:47:50.70493
511	whole milk powder	protein	neutral	6.5	2026-05-11 06:48:01.182926
514	wheat protein	protein	healthy	8.5	2026-05-11 06:48:19.893003
516	gluconic acid	acidifier	neutral	8	2026-05-11 06:48:40.40453
517	lactone	flavor compound	neutral	8	2026-05-11 06:48:42.419073
518	sodium pyrophosphate	preservative	caution	4.2	2026-05-11 06:48:44.454322
520	piper nigrum	spice	healthy	8.5	2026-05-11 06:49:15.206641
521	caraway	spice	healthy	8.5	2026-05-11 06:49:19.355751
424	vitus vinifera	fruit	healthy	8.5	2026-05-11 06:38:38.360299
398	sugar substitute	sweetener	caution	2	2026-05-11 06:35:18.553286
401	preservative	preservative	caution	2.5	2026-05-11 06:35:29.214258
437	salt and flavor	salt	neutral	5	2026-05-11 06:40:37.168566
465	oat flakes with wheat flour and milk	grain	healthy	8.5	2026-05-11 06:43:23.020635
479	weedy rice	grain	neutral	6	2026-05-11 06:45:03.922324
469	milk powder and salt	{protein,salt}	neutral	8.5	2026-05-11 06:43:53.099269
1971	emulsifier mono- and diglycerides	emulsifier	neutral	5	2026-05-13 06:34:41.338495
2066	sodium metabisulfite	preservative	caution	4.2	2026-05-13 07:04:08.898336
544	gluten free crackers with dates	\N	\N	\N	2026-05-11 06:52:28.258076
526	vitamin b12	vitamin	healthy	9.5	2026-05-11 06:50:29.164662
527	zinc	mineral	healthy	9	2026-05-11 06:50:35.424125
529	carbon dioxide	preservative	neutral	8	2026-05-11 06:50:52.17322
530	hops	spice	healthy	8.5	2026-05-11 06:50:54.302817
531	mozzarella cheese	dairy	neutral	6.5	2026-05-11 06:51:02.719931
533	pork sausage	protein	caution	4.2	2026-05-11 06:51:09.010816
534	pork	protein	neutral	6.5	2026-05-11 06:51:11.095948
536	bell pepper	vegetable	healthy	9	2026-05-11 06:51:23.620091
537	parmesan	protein	healthy	8.5	2026-05-11 06:51:29.800203
539	palm kernel oil and coconut oil	fat	caution	4.2	2026-05-11 06:51:42.458498
540	lupin flour	protein	healthy	8.5	2026-05-11 06:51:50.71731
541	msg	flavor enhancer	caution	2.5	2026-05-11 06:52:01.098364
543	tbhq and citric acid	preservative	caution	2.5	2026-05-11 06:52:15.811322
547	soy flour	protein	healthy	8.5	2026-05-11 06:53:09.52584
548	sucrase	enzyme	neutral	8	2026-05-11 06:53:17.856313
550	coffee	beverage	healthy	8.5	2026-05-11 06:53:30.387909
551	butyrospermum parkii	fat	neutral	6.5	2026-05-11 06:53:38.705077
552	cocos nucifera	fat	neutral	6.5	2026-05-11 06:53:47.227284
554	high fructose corn syrup	sweetener	caution	2.5	2026-05-11 06:54:20.725316
555	dried apricot	fruit	healthy	8.5	2026-05-11 06:54:22.792192
557	potassium carbonate; butterfat	mineral	neutral	8	2026-05-11 06:54:29.154546
558	leek	vegetable	healthy	8.5	2026-05-11 06:54:47.817095
559	pumpkin	fiber	healthy	8.5	2026-05-11 06:54:51.998272
561	modified cornstarch	thickener	neutral	5.5	2026-05-11 06:55:00.386167
563	fiber	fiber	healthy	9.5	2026-05-11 18:41:07.894161
564	pea protein	protein	healthy	8.5	2026-05-11 18:41:08.297587
568	marshmallow flavor	natural flavor	neutral	6	2026-05-11 18:41:14.137701
570	phosphates	mineral	caution	4	2026-05-11 18:41:16.834101
571	dutch cocoa	flavor	neutral	8	2026-05-11 18:41:21.946786
573	bran	fiber	healthy	9	2026-05-11 18:41:53.259194
574	whole grains	fiber	healthy	9	2026-05-11 18:41:58.00499
575	spice blend	spice	healthy	8	2026-05-11 18:42:07.382588
578	gum	thickener	neutral	5	2026-05-11 18:42:50.437542
579	apiol	spice	caution	6.5	2026-05-11 18:42:52.728402
581	vitamin d	vitamin	healthy	9.5	2026-05-11 18:43:28.242083
582	allergenic residue	contaminant	avoid	0	2026-05-11 18:43:40.044289
583	cottonseed oil	fat	caution	4.2	2026-05-11 18:43:54.350491
585	caffeine	stimulant	caution	6.5	2026-05-11 18:44:10.896834
587	polysorbate 60	emulsifier	caution	4.2	2026-05-11 18:44:44.161879
589	zea mays	fiber	healthy	8.5	2026-05-11 18:45:32.750893
590	beta-carotene	vitamin	healthy	9.5	2026-05-11 18:45:37.479157
591	sorbitan monostearate	emulsifier	caution	4.2	2026-05-11 18:46:06.93182
592	monoglyceride	emulsifier	caution	4.2	2026-05-11 18:46:18.695098
594	sodium	mineral	caution	4	2026-05-11 18:46:31.136032
596	corn syrup	sweetener	caution	2.5	2026-05-11 18:47:34.26354
598	lac resin	thickener	neutral	5	2026-05-11 18:47:57.871615
600	cellulose gum	thickener	neutral	8	2026-05-11 18:48:15.05393
601	oat fiber	fiber	healthy	9	2026-05-11 18:48:22.26659
602	sodium acetate	preservative	caution	4.2	2026-05-11 18:48:29.651553
604	inosinate	flavor enhancer	caution	4.2	2026-05-11 18:48:41.886279
605	kidney beans	protein	healthy	8.5	2026-05-11 18:48:46.980157
607	thymus vulgaris and laurus nobilis	spice	healthy	8.5	2026-05-11 18:49:09.01703
608	fruit preserves	sweetener	caution	4.2	2026-05-11 18:49:54.582373
610	vegetable fat	fat	neutral	5	2026-05-11 18:50:33.327522
612	aluminum sulfate	preservative	caution	2.5	2026-05-11 18:51:16.517646
614	maltol	flavor enhancer	neutral	6.5	2026-05-11 18:51:33.73774
616	propylene glycol	humectant	caution	4.2	2026-05-11 18:51:41.389387
617	apium	vegetable	healthy	8.5	2026-05-11 18:51:50.992764
619	salt substitute	seasoning	caution	4	2026-05-11 19:22:32.465841
620	citric acid and calcium chloride	preservative	neutral	8	2026-05-11 19:31:17.69267
621	eugenol	natural flavor	caution	6.5	2026-05-11 19:45:28.486528
623	shallot	spice	healthy	8.5	2026-05-11 21:09:17.985945
624	calcium bicarbonate	mineral	healthy	9.5	2026-05-11 21:09:19.986549
626	mechanically recovered meat	protein	caution	4.2	2026-05-11 21:09:24.878258
627	pork belly	protein	caution	4.2	2026-05-11 21:09:25.266247
629	allura red and brilliant blue	artificial color	caution	2	2026-05-11 21:09:27.415017
631	silicon dioxide	anti-caking agent	neutral	8	2026-05-11 21:09:27.448811
634	ammonium bicarbonate	leavening agent	caution	4.2	2026-05-11 21:25:49.2997
636	raspberry flavor	natural flavor	neutral	8	2026-05-11 21:25:54.390896
638	phosphatidylcholine	emulsifier	neutral	8	2026-05-11 21:25:56.864582
639	milk fat	fat	neutral	6.5	2026-05-11 21:25:57.937283
641	coconut flavour	natural flavor	neutral	8	2026-05-11 21:26:00.117481
642	tapioca syrup	sweetener	caution	4.2	2026-05-11 21:26:08.8298
644	pineapple fiber	fiber	healthy	9	2026-05-11 21:26:26.152765
645	sodium alginate	thickener	neutral	8	2026-05-11 21:26:28.789406
647	trisodium citrate	preservative	neutral	6.5	2026-05-11 21:26:34.10426
649	orange oil	natural flavor	healthy	8.5	2026-05-11 21:26:45.259289
650	ascorbic acid	vitamin	healthy	9.5	2026-05-11 21:26:47.787249
652	ammonium	preservative	caution	2.5	2026-05-11 21:27:06.145501
654	orange flavouring	natural flavor	neutral	8	2026-05-11 21:27:25.544497
655	potassium bicarbonate	mineral	neutral	8	2026-05-11 21:28:42.383157
656	bicarbonate	mineral	neutral	8	2026-05-11 21:28:42.949289
524	oats and corn	grain	healthy	8.5	2026-05-11 06:49:57.391687
545	walnuts and sunflower seeds	nut	healthy	8	2026-05-11 06:52:30.382003
567	sodium chloride and flavor	salt	neutral	2	2026-05-11 18:41:13.616995
577	corn starch and citric acid	{thickener,preservative}	neutral	5.5	2026-05-11 18:42:42.814406
611	wheat flour and salt	{grain,mineral}	healthy	7.5	2026-05-11 18:50:52.682514
632	spice and coloring	spice	neutral	5	2026-05-11 21:09:29.238864
1973	emulsifiers mono- and diglycerides with preservatives mixed tocopherols	emulsifier	neutral	5	2026-05-13 06:34:57.40762
680	nature	\N	\N	\N	2026-05-11 21:33:24.965894
689	n	\N	\N	\N	2026-05-11 21:37:48.428649
755	p	\N	\N	\N	2026-05-11 21:56:19.419116
764	pasteurisation	\N	\N	\N	2026-05-11 21:59:15.983865
793	potassium sorbate, potassium benzoate, yellow 5	\N	\N	\N	2026-05-11 22:03:11.07245
658	blackberry	fruit	healthy	9.5	2026-05-11 21:30:06.48234
659	citrus fiber	fiber	healthy	8.5	2026-05-11 21:30:08.194196
660	alpha amino acid	amino acid	healthy	8.5	2026-05-11 21:30:37.261956
661	artificial flavours	natural flavor	caution	4	2026-05-11 21:30:44.049131
663	artificial and natural flavors	natural flavor	neutral	5	2026-05-11 21:31:17.410052
664	potato flour	thickener	neutral	6.5	2026-05-11 21:31:23.158351
666	rose water	natural flavor	healthy	8.5	2026-05-11 21:31:51.689996
668	triglycerides	fat	neutral	5	2026-05-11 21:32:00.913417
669	black bean	protein	healthy	8.5	2026-05-11 21:32:19.843624
671	nitrogen	gas	neutral	8	2026-05-11 21:32:28.358535
673	cochineal	artificial color	caution	4	2026-05-11 21:32:38.624978
674	butteroil	fat	caution	4.2	2026-05-11 21:32:44.100066
676	shellac and carnauba wax	coating	caution	4	2026-05-11 21:32:55.4663
678	dextrin	thickener	neutral	6	2026-05-11 21:33:03.005839
679	green apple	fruit	healthy	8.5	2026-05-11 21:33:18.401797
682	passionfruit	fruit	healthy	8.5	2026-05-11 21:34:18.138948
683	gunar	sweetener	caution	4.2	2026-05-11 21:34:18.511739
670	onion and garlic	vegetable	healthy	8.5	2026-05-11 21:32:22.344202
686	low fat powder	thickener	neutral	6	2026-05-11 21:37:40.296838
690	semisweet chocolate	fat	caution	4.2	2026-05-11 21:37:48.829739
691	vegetable oils	fat	neutral	5	2026-05-11 21:37:49.293105
692	whey powder	protein	healthy	8.5	2026-05-11 21:38:09.762498
696	tara gum	thickener	neutral	8	2026-05-11 21:38:41.08541
697	reduced minerals whey	mineral	neutral	6	2026-05-11 21:38:48.805934
699	dehydrated onion	vegetable	healthy	8.5	2026-05-11 21:48:42.524919
700	sun-dried tomatoes	vegetable	healthy	8.5	2026-05-11 21:48:43.098977
702	fungus	protein	healthy	8	2026-05-11 21:48:46.36066
703	chablis wine	alcohol	caution	4.2	2026-05-11 21:48:47.410818
705	chervil	spice	healthy	9.5	2026-05-11 21:48:48.330369
707	fig	fruit	healthy	8.5	2026-05-11 21:48:51.401246
708	glutamate	amino acid	caution	6.5	2026-05-11 21:49:01.563241
710	chili pepper	spice	healthy	8.5	2026-05-11 21:49:20.747681
712	rice wine	natural flavor	caution	6.5	2026-05-11 21:50:08.01317
714	trisodium phosphate	preservative	caution	2.5	2026-05-11 21:50:23.323381
716	calcium propionate and powdered cellulose	preservative	caution	4	2026-05-11 21:50:28.334098
717	tomato concentrate	natural flavor	healthy	8.5	2026-05-11 21:50:29.29428
719	pork fat	fat	caution	4.2	2026-05-11 21:51:10.775666
721	butylated hydroxytoluene	antioxidant	caution	2.5	2026-05-11 21:51:15.755468
722	annatto	natural color	neutral	8	2026-05-11 21:51:20.988384
723	beef plasma	protein	caution	6.5	2026-05-11 21:51:30.379384
725	capsaicin	spice	healthy	8.5	2026-05-11 21:51:35.528804
726	niacin iron	mineral	healthy	9	2026-05-11 21:51:43.402437
728	brazil nut	mineral	healthy	9	2026-05-11 21:51:50.893165
730	corn meal	fiber	healthy	8.5	2026-05-11 21:52:16.826321
731	amygdalin	natural compound	caution	2.5	2026-05-11 21:52:32.994045
732	pecan	nut	healthy	8.5	2026-05-11 21:52:42.913305
734	rice extract	thickener	neutral	8	2026-05-11 21:53:01.367415
736	yogurt culture	microorganism	healthy	8.5	2026-05-11 21:53:20.050748
737	dried cranberries	fruit	healthy	8.5	2026-05-11 21:53:25.182717
739	mannitol	sweetener	caution	6.5	2026-05-11 21:53:37.37247
740	cellulose	thickener	neutral	5	2026-05-11 21:53:40.069405
742	acesulfame	sweetener	caution	4.2	2026-05-11 21:54:14.511033
744	khorasan wheat	grain	healthy	8.5	2026-05-11 21:54:33.285242
745	poppy seed	spice	healthy	8.5	2026-05-11 21:54:35.871319
747	bht	preservative	caution	2.5	2026-05-11 21:55:00.347954
749	hickory smoke flavor	natural flavor	neutral	8	2026-05-11 21:55:28.277389
750	dextrose	sweetener	neutral	5	2026-05-11 21:55:42.032246
751	tricalcium phosphate	mineral	neutral	8	2026-05-11 21:55:52.320852
756	saccharin	sweetener	caution	4.2	2026-05-11 21:56:27.363077
757	tapioca starch	thickener	neutral	6.5	2026-05-11 21:56:35.552797
759	capsicum extract	spice	healthy	8.5	2026-05-11 21:57:40.778447
762	polyglycerol esters of fatty acids	emulsifier	neutral	6.5	2026-05-11 21:58:18.248983
763	dark chocolate	fat	neutral	6.5	2026-05-11 21:58:57.238185
765	sultanas	fruit	healthy	8.5	2026-05-11 21:59:21.036969
767	hibiscus extract	natural flavor	healthy	8.5	2026-05-11 21:59:28.736415
768	beetroot juice	natural color	healthy	8.5	2026-05-11 21:59:29.689941
770	phosphoric acid	acidifier	caution	4.2	2026-05-11 21:59:37.164317
772	dried egg	protein	healthy	8.5	2026-05-11 22:00:16.175822
774	strawberry filling	fruit	caution	6.5	2026-05-11 22:00:23.976976
775	erythorbic acid	antioxidant	neutral	8	2026-05-11 22:00:26.610455
777	milk solids	protein	healthy	8	2026-05-11 22:00:37.7289
778	modified starch	thickener	neutral	6	2026-05-11 22:00:40.236848
780	sodium acid pyrophosphate	preservative	caution	4.2	2026-05-11 22:00:56.625155
782	carbon	mineral	neutral	5	2026-05-11 22:01:43.710337
784	enriched wheat flour	fiber	neutral	6.5	2026-05-11 22:01:57.955566
785	cellulase	enzyme	neutral	8	2026-05-11 22:02:00.558558
787	potassium sorbate and potassium benzoate	preservative	caution	4	2026-05-11 22:02:23.614902
789	guar gum & xanthan gum	thickener	neutral	8	2026-05-11 22:02:39.115233
791	calcium alginate	thickener	neutral	8	2026-05-11 22:03:00.728495
792	hydroxypropylmethylcellulose	thickener	neutral	8	2026-05-11 22:03:08.511676
695	natu	natural flavor	healthy	8.5	2026-05-11 21:38:32.673209
688	shea butter and sunflower oil	fat	healthy	9	2026-05-11 21:37:47.955556
711	porc	protein	healthy	8	2026-05-11 21:49:27.902812
752	sliced	spice	neutral	8	2026-05-11 21:56:05.49169
754	blanched	natural flavor	neutral	8	2026-05-11 21:56:10.448539
771	dehydrated ingredient	preservation method	neutral	5	2026-05-11 22:00:00.734082
926	sodium benzoate and potassium sorbate	preservative	caution	2	2026-05-11 23:34:33.880889
798	passion fruit puree	natural flavor	healthy	8.5	2026-05-11 22:03:40.699087
800	carob	natural flavor	healthy	8.5	2026-05-11 22:03:59.816436
801	nonfat dry milk	protein	healthy	8.5	2026-05-11 22:04:04.799823
804	yellow 5 and blue 1	artificial color	caution	2	2026-05-11 22:04:46.226003
805	sour cream culture	dairy product	healthy	8	2026-05-11 22:04:48.833693
806	rib meat	protein	neutral	6.5	2026-05-11 22:04:59.062141
808	salmon	protein	healthy	8.5	2026-05-11 22:05:06.911216
809	fish protein	protein	healthy	8	2026-05-11 22:05:10.336436
811	greens	vegetable	healthy	8.5	2026-05-11 22:05:23.366035
812	flounder	protein	healthy	8	2026-05-11 22:05:25.905765
814	tilapia	protein	neutral	8	2026-05-11 22:05:36.180719
815	crab meat	protein	healthy	8.5	2026-05-11 22:05:38.785841
817	nicotinic acid	vitamin	healthy	9	2026-05-11 22:05:45.42031
818	riboflavin	vitamin	healthy	9.5	2026-05-11 22:05:53.284743
819	folate	vitamin	healthy	9.5	2026-05-11 22:05:56.252469
821	crab protein	protein	healthy	8.5	2026-05-11 22:06:12.476034
822	purple corn	grain	healthy	8.5	2026-05-11 22:06:25.64328
824	spearmint	herb	healthy	8.5	2026-05-11 22:06:33.344272
826	licorice extract	natural flavor	caution	4	2026-05-11 22:06:36.860081
827	marshmallow	sweetener	neutral	2.5	2026-05-11 22:06:39.418835
829	hyssop	herb	healthy	8.5	2026-05-11 22:06:44.840748
830	pippali	spice	neutral	7.5	2026-05-11 22:06:47.47338
832	disodium	salt	neutral	2	2026-05-11 22:07:12.005982
833	linoleic acid	fatty acid	healthy	8	2026-05-11 22:07:22.584932
835	flavonoids	vitamin	healthy	8	2026-05-11 22:07:27.653487
837	blue cheese	dairy product	caution	2	2026-05-11 22:07:59.73795
838	blue corn	grain	neutral	8.5	2026-05-11 22:08:03.119293
840	dill	herb	healthy	8.5	2026-05-11 22:08:10.997764
841	kale	vegetable	healthy	9.5	2026-05-11 22:08:13.533341
842	red corn	grain	healthy	8.5	2026-05-11 22:08:16.054443
844	citrus	natural flavor	healthy	8.5	2026-05-11 22:08:43.103728
846	citric acid and tartaric acid	acid	neutral	7	2026-05-11 22:08:48.202783
847	sodium caseinate	emulsifier	neutral	5	2026-05-11 22:09:09.931057
848	potassium phosphate	mineral	neutral	5	2026-05-11 22:09:12.407014
850	solids	nutrient	healthy	9.5	2026-05-11 22:09:22.465788
851	tea	natural flavor	healthy	8.5	2026-05-11 22:09:25.169999
853	beetroot powder	vegetable	healthy	8.5	2026-05-11 22:09:37.079056
855	acesulfame potassium	sweetener	caution	2	2026-05-11 22:10:06.690232
856	aloe vera	natural flavor	healthy	8.5	2026-05-11 22:10:19.733857
858	gellan	thickener	neutral	7.5	2026-05-11 22:10:25.771585
859	stevia	sweetener	healthy	8.5	2026-05-11 22:10:28.486286
861	grape flavour	natural flavor	neutral	6	2026-05-11 22:10:36.025469
863	yellow 5 lake	artificial color	caution	2	2026-05-11 22:11:17.121739
865	dried cherries	fruit	healthy	8.5	2026-05-11 22:12:10.935603
866	corn starch	thickener	neutral	2	2026-05-11 22:12:32.344535
867	lactic acid bacteria	microorganism	caution	4	2026-05-11 22:12:35.071332
869	shiitake mushroom	vegetable	healthy	8.5	2026-05-11 22:12:59.870687
870	green onion	vegetable	healthy	8.5	2026-05-11 22:13:02.477355
872	soybean oil and/or canola oil	oil	neutral	7.5	2026-05-11 22:13:07.572407
873	cane sugar	sweetener	caution	2	2026-05-11 22:13:18.564323
875	sodium stearoyl lactylate	emulsifier	neutral	6.2	2026-05-11 23:29:38.87783
877	artificial color & flavor	natural flavor	caution	6	2026-05-11 23:29:41.719437
878	bourbon	spirit	caution	2.5	2026-05-11 23:29:42.353688
879	tetrasodium pyrophosphate	preservative	caution	2	2026-05-11 23:29:43.857491
880	smoke flavoring	natural flavor	neutral	5	2026-05-11 23:29:44.342558
881	partially hydrogenated vegetable oil	fat	caution	2	2026-05-11 23:29:45.246246
882	carboxymethylcellulose	thickener	neutral	6	2026-05-11 23:29:45.477496
884	calcium stearoyl lactylate	emulsifier	neutral	4	2026-05-11 23:29:46.120879
885	blue 1 lake	artificial color	caution	2	2026-05-11 23:29:49.178355
887	nonfat milk	dairy	healthy	8	2026-05-11 23:30:04.615314
888	chlorophyll	natural color	neutral	6	2026-05-11 23:30:14.642297
890	coca	sweetener	caution	2	2026-05-11 23:30:25.675339
891	whole milk	dairy	healthy	8	2026-05-11 23:30:44.087194
893	blue agave nectar	sweetener	healthy	8	2026-05-11 23:31:02.14572
894	sardine	fish	healthy	8.5	2026-05-11 23:31:07.105018
896	pollock	protein	healthy	8	2026-05-11 23:31:19.194837
897	snow crab	seafood	healthy	8.5	2026-05-11 23:31:20.056979
899	fish oil	fat	healthy	8	2026-05-11 23:31:24.850483
900	tomatillo	fruit	healthy	8.5	2026-05-11 23:31:34.698557
902	serrano pepper	spice	healthy	8.5	2026-05-11 23:31:39.564092
903	jasmine rice	grain	healthy	8.5	2026-05-11 23:31:42.023093
905	distilled spirit	alcohol	caution	2	2026-05-11 23:31:57.446503
906	mascarpone cheese	dairy	healthy	8.5	2026-05-11 23:31:59.844211
908	dried egg whites	protein	healthy	8.5	2026-05-11 23:32:07.32247
909	lemon peel	natural flavor	healthy	8.5	2026-05-11 23:32:30.603793
911	calcium propionate	preservative	caution	2.5	2026-05-11 23:32:40.45913
913	potassium iodide	mineral	healthy	8.5	2026-05-11 23:32:49.001518
914	bulgur	grain	healthy	8	2026-05-11 23:33:04.368843
916	linseed meal	protein	neutral	6.5	2026-05-11 23:33:22.51358
917	sodium stearate	emulsifier	neutral	5	2026-05-11 23:33:27.412417
919	vital wheat gluten	protein	neutral	8	2026-05-11 23:33:37.55406
920	proteolytic enzymes	preservative	neutral	6	2026-05-11 23:33:48.345363
922	polydextrose	fiber	healthy	8.5	2026-05-11 23:34:05.960285
923	steviol glycoside	sweetener	healthy	9	2026-05-11 23:34:10.811785
925	date	fruit	healthy	8.5	2026-05-11 23:34:19.043268
927	calcium stearate	emulsifier	neutral	5	2026-05-11 23:34:42.210443
929	acacia gum	thickener	healthy	8.5	2026-05-11 23:34:49.880386
930	yellow lake	artificial color	caution	2	2026-05-11 23:34:54.809414
931	celery seed	spice	healthy	8.5	2026-05-11 23:34:59.562944
1977	soybean oil with emulsifier propylene glycol monoesters	oil	neutral	6.5	2026-05-13 06:36:04.370121
944	soybean oil and cottonseed oil	\N	\N	\N	2026-05-11 23:37:10.595768
957	palm oil and soybean oil	\N	\N	\N	2026-05-11 23:40:09.542408
968	sodium chloride and coconut oil	\N	\N	\N	2026-05-11 23:42:43.102952
970	onion and basil	\N	\N	\N	2026-05-11 23:43:45.166468
998	xanthan gum and guar gum	\N	\N	\N	2026-05-11 23:51:41.570604
934	paprika extract	spice	healthy	8.5	2026-05-11 23:35:15.185438
935	papain	enzyme	caution	3.5	2026-05-11 23:35:27.3957
937	propylene glycol monostearate	emulsifier	caution	6	2026-05-11 23:35:41.309153
938	acetylated monoglycerides	emulsifier	neutral	5	2026-05-11 23:35:46.255103
940	flavors	natural flavor	neutral	5	2026-05-11 23:35:55.942401
941	polyglycol esters	emulsifier	neutral	5	2026-05-11 23:36:41.818885
943	sodium chloride and palm kernel oil	{salt,fat}	neutral	5	2026-05-11 23:37:03.267685
945	white wine	alcoholic beverage	caution	2.5	2026-05-11 23:37:13.197994
947	sherry	alcoholic beverage	caution	2	2026-05-11 23:37:25.739867
949	turkey breast	protein	healthy	9.5	2026-05-11 23:37:43.972859
950	maple sugar	sweetener	healthy	9.2	2026-05-11 23:38:01.969558
952	sodium nitrate	preservative	caution	2	2026-05-11 23:38:39.258869
954	sodium benzoate and potassium sorbate and edta	preservative	caution	2.5	2026-05-11 23:39:11.158686
955	wheat gluten	protein	caution	6.5	2026-05-11 23:39:13.575275
958	sourdough	fermentation agent	healthy	8.5	2026-05-11 23:40:19.37257
960	white pepper	spice	neutral	8	2026-05-11 23:40:37.226949
961	raspberry juice	fruit juice	healthy	8.5	2026-05-11 23:41:02.743699
962	dried onion	vegetable	healthy	8.5	2026-05-11 23:41:05.103851
963	betanidin	natural color	neutral	8	2026-05-11 23:41:07.48067
965	basil extract	natural flavor	healthy	8.5	2026-05-11 23:41:27.85551
967	partially hydrogenated coconut oil	fat	caution	2.5	2026-05-11 23:42:30.702069
969	romano cheese	dairy product	healthy	8	2026-05-11 23:43:18.679917
971	ricotta cheese	dairy	healthy	8.5	2026-05-11 23:44:07.164452
972	asiago cheese	dairy	healthy	8.5	2026-05-11 23:44:10.508224
974	hydrolyzed corn gluten	protein	caution	2	2026-05-11 23:44:28.058565
975	grill flavor	natural flavor	neutral	5	2026-05-11 23:44:33.219198
976	yellow 5	artificial color	caution	2	2026-05-11 23:45:19.463901
978	canola and/or soybean oil	oil	neutral	6	2026-05-11 23:45:34.931007
979	neotame	sweetener	caution	2.5	2026-05-11 23:46:20.184281
981	disodium edta	preservative	caution	2	2026-05-11 23:46:27.429714
983	erythritol	sweetener	neutral	8	2026-05-11 23:46:30.891567
984	magnesium lactate	mineral	healthy	8.5	2026-05-11 23:46:35.621163
986	calcium pantothenate	vitamin	healthy	8	2026-05-11 23:46:47.873557
987	microorganisms	preservative	caution	2.5	2026-05-11 23:47:33.684028
989	blue 2	preservative	caution	2.5	2026-05-11 23:48:03.786737
990	blue lake 2	food coloring	neutral	4	2026-05-11 23:48:21.106208
992	modified soy protein	protein	neutral	6	2026-05-11 23:49:21.514747
993	barley flour	grain	healthy	8.5	2026-05-11 23:49:50.109395
994	lowfat milk	milk	healthy	8.5	2026-05-11 23:50:11.857415
996	enriched long grain rice	grain	neutral	8	2026-05-11 23:51:26.902613
997	modified butter	fat	neutral	3	2026-05-11 23:51:34.154747
1000	durum semolina	grain	neutral	6	2026-05-11 23:51:49.698852
1001	hydrogenated vegetable oil	fat	caution	2	2026-05-11 23:51:52.085738
1003	dried	other	neutral	5	2026-05-11 23:51:56.83103
1004	natural flavors	natural flavor	neutral	2	2026-05-11 23:52:29.777494
1006	guanylic acid	preservative	caution	6	2026-05-11 23:53:01.936537
1007	provolone cheese	dairy	neutral	7.5	2026-05-11 23:53:12.604795
1009	pasteurized milk	protein	healthy	8	2026-05-11 23:53:25.154218
1011	calcium citrate	mineral	healthy	8	2026-05-11 23:53:52.195211
1012	pine nuts	nut	healthy	8.5	2026-05-11 23:55:04.865229
1013	dried yogurt	dairy product	healthy	8.5	2026-05-11 23:55:05.426823
1015	sour cream powder	dairy product	neutral	6.5	2026-05-11 23:55:07.425901
1018	sucrose acetate isobutyrate	preservative	avoid	2.5	2026-05-11 23:55:09.596208
1019	medium chain triglycerides	fat	neutral	2	2026-05-11 23:55:09.891766
1020	amino acids	protein	neutral	7	2026-05-11 23:55:12.482906
1022	fruit pectin	thickener	healthy	8.5	2026-05-11 23:55:37.972353
1024	buttermilk powder	dairy product	neutral	7	2026-05-11 23:55:59.818652
1025	sweet whey	dairy byproduct	neutral	6.5	2026-05-11 23:56:03.184094
1027	dried apples	fruit	healthy	8	2026-05-11 23:56:27.433694
1029	dried tomatoes	vegetable	healthy	8	2026-05-11 23:56:37.983952
1030	bleached wheat flour	flour	neutral	6.2	2026-05-11 23:56:40.532386
1031	each	sweetener	caution	2	2026-05-11 23:57:21.446718
1033	margarine	spread	neutral	6.5	2026-05-11 23:57:29.875785
1034	seaweed	vegetable	healthy	8	2026-05-11 23:57:37.342061
1036	sherry wine	alcoholic beverage	avoid	0	2026-05-11 23:57:54.594318
1037	cultured cream	dairy	neutral	6	2026-05-11 23:58:23.659285
1039	umami	flavor enhancer	neutral	6.2	2026-05-11 23:58:48.860967
1041	cauliflower	vegetable	healthy	8.5	2026-05-11 23:58:57.198766
1042	snow peas	vegetable	healthy	8.5	2026-05-11 23:59:09.067503
1043	sugar snap pea	vegetable	healthy	9.5	2026-05-11 23:59:11.445788
1045	snap peas	vegetable	healthy	8.5	2026-05-11 23:59:22.212599
1047	kamut wheat	grain	neutral	6.5	2026-05-12 00:00:23.701393
1048	enrichment	mineral	healthy	8	2026-05-12 00:00:26.155665
1049	soy fiber	fiber	healthy	8	2026-05-12 00:00:41.108158
1051	acetic acid and lactic acid	acid	neutral	5	2026-05-12 00:01:15.548731
1053	cream and milk	dairy product	healthy	8	2026-05-12 00:01:41.22129
1054	soy extract	natural flavor	neutral	6	2026-05-12 00:02:01.823141
1056	carrot juice	juice	healthy	8.5	2026-05-12 00:03:17.955264
1057	long grain rice	grain	healthy	8.5	2026-05-12 00:03:40.366526
1059	onion extract	natural flavor	neutral	5	2026-05-12 00:04:05.728088
1060	black pepper oil	natural flavor	healthy	9.5	2026-05-12 00:04:10.472504
1062	sodium diacetate	preservative	caution	2	2026-05-12 00:04:25.097827
1064	butternut squash	vegetable	healthy	8.5	2026-05-12 00:04:57.394999
1065	stearoyl lactylate	emulsifier	neutral	5.5	2026-05-12 00:05:25.046459
1979	palm oil and/or soybean oil with emulsifier propylene glycol mono and diester	emulsifier	caution	2	2026-05-13 06:36:11.735656
1986	pickle relish	condiment	neutral	2.5	2026-05-13 06:39:08.321724
1990	montamore cheese	dairy product	neutral	7.5	2026-05-13 06:39:48.054064
1091	turmeric and annatto	\N	\N	\N	2026-05-12 00:10:48.854928
1111	olive oil and sunflower oil	\N	\N	\N	2026-05-12 00:13:54.43039
1134	annatto and turmeric	\N	\N	\N	2026-05-12 00:18:34.713562
1153	chicken meat, carrots	\N	\N	\N	2026-05-12 00:21:02.489696
1172	palm kernel oil and cottonseed oil	\N	\N	\N	2026-05-12 00:24:21.605085
1068	potassium lactate	preservative	neutral	6.4	2026-05-12 00:05:54.791446
1069	celery powder	spice	healthy	9.5	2026-05-12 00:06:02.761692
1071	egg yolk flavor	natural flavor	neutral	5	2026-05-12 00:06:17.178175
1072	cultured dairy product	dairy	neutral	7.5	2026-05-12 00:06:27.978003
1074	evaporated apple juice	juice	healthy	8.5	2026-05-12 00:07:15.743563
1075	sodium sulfite	preservative	caution	2	2026-05-12 00:07:18.145861
1077	cracked wheat flour	grain	neutral	6.2	2026-05-12 00:08:08.740544
1078	malted corn flour	grain	neutral	7	2026-05-12 00:08:13.666698
1080	turmeric and paprika color	natural flavor	healthy	8.5	2026-05-12 00:08:21.738229
1082	tbhq	preservative	caution	2	2026-05-12 00:09:01.919156
1083	blue cheese cultures	natural flavor	caution	2	2026-05-12 00:09:27.559051
1084	pork skin	protein	caution	4	2026-05-12 00:09:34.899925
1086	parmesan and romano cheese blend	dairy product	neutral	7.5	2026-05-12 00:10:08.734256
1088	romano and blue cheese blend cultured milk	dairy	neutral	7.5	2026-05-12 00:10:19.517932
1089	anchovy extract	seasoning	caution	2.5	2026-05-12 00:10:24.711023
1092	propionic acid	preservative	caution	2	2026-05-12 00:10:51.337918
1093	fermented wheat flour	grain	neutral	2.5	2026-05-12 00:10:56.038156
1094	barley extract	natural flavor	neutral	6.5	2026-05-12 00:11:11.278454
1096	grain	grain	neutral	6.5	2026-05-12 00:11:18.469182
1097	sodium lactate	preservative	neutral	6	2026-05-12 00:11:30.457905
1099	sorbitol	sweetener	caution	2.5	2026-05-12 00:11:37.825743
1100	flatbread	grain	neutral	7.2	2026-05-12 00:11:52.963263
1101	monosodium phosphate	preservative	caution	5	2026-05-12 00:11:57.663176
1102	red onion	vegetable	healthy	8.5	2026-05-12 00:12:32.32067
1103	water and eggs	liquid	healthy	9.5	2026-05-12 00:12:37.965025
1104	turkey breast meat	protein	healthy	9.5	2026-05-12 00:12:40.437185
1105	turkey broth	broth	neutral	3.5	2026-05-12 00:12:42.815354
1107	ph (hydrogen ion concentration)	preservative	caution	3	2026-05-12 00:13:04.717965
1109	eggs with citric acid	protein	healthy	8.5	2026-05-12 00:13:32.138611
1110	garlic and onion	spice	healthy	8.5	2026-05-12 00:13:42.407946
1112	brussels sprouts	vegetable	healthy	9.5	2026-05-12 00:14:07.371819
1113	tuna	protein	healthy	8.5	2026-05-12 00:14:49.906092
1114	beta-apo-8'-carotenal	artificial color	caution	2.5	2026-05-12 00:14:54.766494
1115	yeast extract garlic powder	flavoring	neutral	3	2026-05-12 00:15:05.245132
1116	black beans	legume	healthy	8.5	2026-05-12 00:15:32.531521
1118	d-limonene	vitamin	healthy	9.5	2026-05-12 00:15:57.702961
1119	lime puree	natural flavor	healthy	8.5	2026-05-12 00:16:00.15517
1121	white balsamic vinegar	vinegar	neutral	6.5	2026-05-12 00:16:09.884721
1122	orange puree	fruit	healthy	8.5	2026-05-12 00:16:12.34991
1123	wine	alcohol	caution	2	2026-05-12 00:16:19.519768
1125	red wheat	grain	healthy	8	2026-05-12 00:16:39.635073
1126	dark rye flour	grain	healthy	8.5	2026-05-12 00:16:52.523661
1128	propylene glycol monoester	emulsifier	caution	2	2026-05-12 00:17:06.871034
1130	monocasein	protein	healthy	8	2026-05-12 00:17:16.715639
1131	refined sugar	sweetener	caution	2	2026-05-12 00:17:36.849004
1132	karaya gum	thickener	neutral	6	2026-05-12 00:18:04.549369
1135	cheddar and romano cheese pasteurized milk	dairy	healthy	8	2026-05-12 00:18:39.473957
1136	surimi	protein	neutral	5	2026-05-12 00:18:45.483458
1138	mustard seed	spice	healthy	8.5	2026-05-12 00:19:07.064932
1139	water chestnut	vegetable	healthy	8.5	2026-05-12 00:19:09.525231
1140	bread crumb	grain	neutral	7	2026-05-12 00:19:12.015712
1142	partially hydrogenated oil	fat	caution	2	2026-05-12 00:19:25.168716
1143	partially hydrogenated palm oil	fat	caution	1.5	2026-05-12 00:19:47.938904
1145	vegetables	food group	healthy	8.5	2026-05-12 00:20:02.495103
1146	navy bean	legume	healthy	9.5	2026-05-12 00:20:09.642529
1148	chicken fat	fat	caution	2	2026-05-12 00:20:15.182055
1149	poblano	vegetable	healthy	8.5	2026-05-12 00:20:19.943605
1151	sesame paste	nut paste	healthy	7.5	2026-05-12 00:20:24.855372
1152	crushed red pepper	spice	caution	4.5	2026-05-12 00:20:36.939
1155	nisin	preservative	caution	4	2026-05-12 00:21:15.936026
1157	iberico pork	meat	healthy	8.5	2026-05-12 00:22:27.149372
1159	potassium nitrate	preservative	caution	2	2026-05-12 00:22:27.864913
1160	jalapeno pepper	vegetable	healthy	8.5	2026-05-12 00:22:29.464988
1162	cheese cultures	microorganism	healthy	8.5	2026-05-12 00:22:30.133178
1164	lysozyme	preservative	caution	2.5	2026-05-12 00:22:30.561299
1166	fatty acid esters	emulsifier	neutral	6	2026-05-12 00:22:44.080687
1167	grape juice concentrate	sweetener	neutral	6.5	2026-05-12 00:22:51.578225
1168	propylene glycol monoesters	emulsifier	caution	2.5	2026-05-12 00:22:58.88817
1169	maltitol	sweetener	caution	2	2026-05-12 00:23:12.868155
1171	vitamin a palmitate	vitamin	caution	6	2026-05-12 00:23:48.787338
1173	algin	thickener	healthy	8.5	2026-05-12 00:24:26.756964
1175	iron sulfate	mineral	healthy	8.5	2026-05-12 00:24:48.705003
1177	tragacanth gum	thickener	neutral	6.5	2026-05-12 00:25:21.85355
1179	pineapple juice concentrate	fruit juice	healthy	8.5	2026-05-12 00:25:44.179427
1180	butter milk powder	dairy	neutral	6	2026-05-12 00:25:56.099715
1181	whey permeate	protein	neutral	5	2026-05-12 00:26:01.233166
1182	nonfat milk powder	protein	healthy	8.5	2026-05-12 00:26:14.18253
1183	enzymes c	enzyme	neutral	5	2026-05-12 00:26:30.444739
1184	cholecalciferol	vitamin	healthy	9.5	2026-05-12 00:27:14.902501
1185	ultrafiltered milk	dairy product	healthy	8	2026-05-12 00:27:18.308769
1186	lactase	enzyme	healthy	8.5	2026-05-12 00:27:20.859863
1158	casein and soy protein isolate	{protein}	neutral	6.5	2026-05-12 00:22:27.588618
1994	potassium sorbate and carbon dioxide	{preservative,gas}	neutral	6	2026-05-13 06:41:03.144586
1193	lactic acid bacteria, milk, modified cornstarch	\N	\N	\N	2026-05-12 00:29:22.181336
1227	coconut oil and soybean oil	\N	\N	\N	2026-05-12 00:40:21.241228
1237	pasteurized milk, quesco, asadero cheeses	\N	\N	\N	2026-05-12 00:43:03.974068
1264	cooked food	\N	\N	\N	2026-05-12 00:49:50.77037
1286	rich	\N	\N	\N	2026-05-12 00:53:27.48058
1306	sodium ascorbate: vitamin c, sodium nitrate: nitrate	\N	\N	\N	2026-05-12 00:59:42.078316
1188	reduced fat milk	dairy product	healthy	8.5	2026-05-12 00:27:28.612211
1189	vitamin d3	vitamin	healthy	9	2026-05-12 00:27:33.836473
1190	ergocalciferol	vitamin	healthy	9.5	2026-05-12 00:27:55.160396
1191	cobalamin	vitamin	healthy	9.5	2026-05-12 00:27:57.615355
1194	black cherry	fruit	healthy	8.5	2026-05-12 00:29:40.570006
1196	bicarbonate of soda	leavening agent	neutral	4	2026-05-12 00:30:27.938661
1198	cultured cream and skim milk	dairy	healthy	8.5	2026-05-12 00:31:41.047871
1200	orange and pineapple juice	fruit juice	healthy	8.5	2026-05-12 00:32:26.468264
1201	quinine	preservative	caution	2.5	2026-05-12 00:32:43.399771
1203	pasteurized low-fat milk	dairy	healthy	8.5	2026-05-12 00:32:57.077164
1204	monterey jack cheese	dairy	neutral	6.8	2026-05-12 00:33:01.029312
1205	part-skim milk	dairy	healthy	7.5	2026-05-12 00:33:03.627836
1207	pasteurized milk colby cheese	dairy product	healthy	8.5	2026-05-12 00:33:28.131439
1209	pasteurized cheese	dairy	healthy	7.5	2026-05-12 00:33:38.425776
1211	pasteurized milk monterey jack cheese	dairy	healthy	8.5	2026-05-12 00:34:04.722696
1212	orange pulp	fruit	healthy	9.5	2026-05-12 00:35:19.176217
1214	boysenberry	fruit	healthy	9	2026-05-12 00:35:44.015811
1215	bifidobacterium bifidum	probiotic	healthy	8.5	2026-05-12 00:35:50.094508
1217	plum puree	fruit	healthy	8.5	2026-05-12 00:36:02.992196
1218	lactitol	sweetener	neutral	2	2026-05-12 00:36:43.697702
1220	inulin	fiber	healthy	8.5	2026-05-12 00:37:00.293478
1221	red food coloring	artificial color	caution	2	2026-05-12 00:37:08.022834
1223	black walnut	nut	neutral	7.5	2026-05-12 00:37:48.839549
1224	mono- and diglycerides, locust bean gum	emulsifier	neutral	2.5	2026-05-12 00:38:02.047179
1225	methyl cellulose	thickener	neutral	7	2026-05-12 00:38:43.386259
1228	salt monoglyceride	emulsifier	neutral	3	2026-05-12 00:40:26.29786
1230	polyunsaturated fat	fat	healthy	8	2026-05-12 00:41:05.763105
1231	bitter chocolate	sweetener	healthy	8	2026-05-12 00:41:26.865866
1233	strawberry juice	juice	healthy	8.5	2026-05-12 00:41:38.62773
1234	beet juice concentrate and turmeric for color	natural color	healthy	8.5	2026-05-12 00:41:41.138801
1236	penicillium roqueforti	microorganism	caution	2.5	2026-05-12 00:42:28.105002
1238	part skim milk	dairy	healthy	8.5	2026-05-12 00:43:27.218759
1239	colby cheese	dairy product	neutral	7.5	2026-05-12 00:43:35.699837
1242	smoked turkey	protein	neutral	6.5	2026-05-12 00:44:32.379071
1243	bison round	meat	healthy	8.5	2026-05-12 00:44:50.231222
1245	bison chuck	protein	healthy	8	2026-05-12 00:44:53.753589
1246	bison ribeye	protein	healthy	8.5	2026-05-12 00:44:56.24323
1248	hydrogenated coconut oil	fat	caution	2	2026-05-12 00:45:14.528899
1249	carotenal	artificial color	caution	2	2026-05-12 00:45:50.115195
1251	aspartame	sweetener	caution	4	2026-05-12 00:46:21.641612
1253	disodium phosphate	preservative	neutral	4.2	2026-05-12 00:46:37.501644
1254	mustard extract	natural flavor	neutral	5	2026-05-12 00:47:06.59597
1256	turkey stock	broth	neutral	6	2026-05-12 00:48:04.671373
1257	oxygen	mineral	neutral	5	2026-05-12 00:48:10.922627
1258	partly skimmed milk	dairy	healthy	7.5	2026-05-12 00:48:18.75226
1260	alpha-amylase	enzyme	neutral	5	2026-05-12 00:48:49.640582
1262	calcium hydroxide treated corn	preservative	caution	2	2026-05-12 00:49:42.299399
1263	roasted green pepper	vegetable	healthy	8	2026-05-12 00:49:48.188136
1265	clam stock	broth	neutral	5	2026-05-12 00:49:53.410195
1267	soy protein isolate sodium phosphate	protein	healthy	8.5	2026-05-12 00:50:21.931533
1268	pinto bean	legume	healthy	8.5	2026-05-12 00:50:29.853126
1270	anchovy	protein	caution	2	2026-05-12 00:50:53.369891
1271	lobster	protein	neutral	6.3	2026-05-12 00:51:02.01073
1273	olive pomace	oil	neutral	6.5	2026-05-12 00:51:12.178434
1274	starter culture	microorganism	neutral	5	2026-05-12 00:51:17.286465
1276	flavor salt	seasoning	neutral	7.5	2026-05-12 00:51:36.437639
1277	olive flour	grain	healthy	8.5	2026-05-12 00:51:55.443232
1279	chicory root	sweetener	neutral	6	2026-05-12 00:52:03.374776
1280	durum wheat semolina	grain	neutral	7.5	2026-05-12 00:52:05.826712
1281	lipase	enzyme	neutral	6	2026-05-12 00:52:15.907607
1283	microbial protease	enzyme	neutral	5	2026-05-12 00:52:46.790493
1284	cheddar cheese milk	dairy	healthy	8	2026-05-12 00:52:58.295391
1287	wild rice	grain	healthy	8	2026-05-12 00:53:29.941528
1288	red lentil	protein	healthy	8.5	2026-05-12 00:53:35.114207
1290	alginate	thickener	caution	6	2026-05-12 00:53:53.875888
1291	soy protein isolate	protein	healthy	7.5	2026-05-12 00:54:06.712586
1293	dried green pepper	spice	healthy	8.5	2026-05-12 00:54:54.335566
1294	savory	spice	neutral	6	2026-05-12 00:55:09.930008
1297	disodium inosinate and disodium guanylate	flavor enhancer	caution	2.5	2026-05-12 00:55:42.842675
1298	sodium chloride with garlic	salt	neutral	2	2026-05-12 00:56:19.193706
1299	grapes	fruit	healthy	8.5	2026-05-12 00:57:30.245264
1300	cucumber extract	natural flavor	healthy	8	2026-05-12 00:57:36.163557
1302	natural flavour	natural flavor	neutral	5	2026-05-12 00:58:06.92629
1303	lowfat buttermilk	milk	neutral	7.5	2026-05-12 00:58:53.594464
1305	sage	spice	healthy	9.5	2026-05-12 00:59:34.301383
1307	beef extract	meat extract	neutral	2.5	2026-05-12 00:59:44.717271
1309	garlic and onion powder	spice	healthy	8.5	2026-05-12 00:59:55.066917
1310	poppy seeds	seed	healthy	8.5	2026-05-12 01:00:04.390963
1313	natural flavors with paprika extract	natural flavor	neutral	5	2026-05-12 01:00:44.976742
1314	smoke	preservative	caution	4.2	2026-05-12 01:00:55.384524
1315	lime oil	natural flavor	healthy	8.5	2026-05-12 01:01:04.346641
1210	aged	preservative	neutral	5	2026-05-12 00:33:57.046899
1312	sodium benzoate and sorbic acid	preservative	caution	2	2026-05-12 01:00:23.118381
1374	or	spice	neutral	7.5	2026-05-12 05:41:15.368552
1343	water, garlic	\N	\N	\N	2026-05-12 05:32:41.247249
1406	sodium metabisulfite: sulfite, disodium edta: edta	\N	\N	\N	2026-05-12 05:49:09.782044
1430	baking soda, monocalcium phosphate	\N	\N	\N	2026-05-12 06:28:32.209301
1441	baking soda, sodium acid pyrophosphate	\N	\N	\N	2026-05-12 07:01:26.823573
1319	beef tallow	fat	caution	2.5	2026-05-12 01:01:49.322359
1320	sage extract	natural flavor	healthy	8.5	2026-05-12 01:02:11.841161
1324	concord grapes	fruit	healthy	9.5	2026-05-12 01:04:11.388553
1325	cassava starch	starch	neutral	6.5	2026-05-12 01:04:15.134652
1326	pinto beans	legume	healthy	8.5	2026-05-12 01:04:32.073178
1327	mustard powder	spice	neutral	4.5	2026-05-12 01:04:39.976506
1328	copper gluconate	mineral	neutral	5	2026-05-12 01:07:06.930578
1329	manganese	mineral	neutral	8.5	2026-05-12 01:07:33.197073
1331	tannic acid & citric acid	acid	neutral	5	2026-05-12 01:14:19.49692
1332	dried coriander	spice	neutral	7	2026-05-12 01:17:44.84582
1334	papaya	fruit	healthy	8.5	2026-05-12 05:31:09.984641
1335	lowfat buttermilk enriched lowfat and skim milk	dairy product	healthy	8.5	2026-05-12 05:31:11.235027
1337	garlic acid	preservative	caution	4.5	2026-05-12 05:31:17.724235
1338	beef broth	broth	neutral	3.5	2026-05-12 05:31:20.624218
1340	potassium	mineral	healthy	8	2026-05-12 05:31:33.939922
1341	carbohydrate gum	thickener	neutral	2	2026-05-12 05:31:53.324443
1342	artichoke	vegetable	healthy	8.5	2026-05-12 05:32:25.128072
1345	juice	fruit	healthy	8.5	2026-05-12 05:33:00.485555
1347	poblano pepper	vegetable	healthy	8.5	2026-05-12 05:33:17.885095
1348	jalapeno	spice	neutral	6.5	2026-05-12 05:33:22.947757
1349	macadamia nuts	nut	healthy	8.5	2026-05-12 05:33:44.640335
1351	palm kernel oil and/or coconut oil	fat	neutral	7.5	2026-05-12 05:34:45.472517
1352	and/or soybean	vegetable	healthy	8.5	2026-05-12 05:35:05.13589
1353	dried cilantro	herb	healthy	8.5	2026-05-12 05:35:22.11456
1355	freeze-dried blueberry	fruit	healthy	8	2026-05-12 05:36:10.15224
1356	baobab	fruit	healthy	8.5	2026-05-12 05:36:36.338686
1358	butter milk	dairy	healthy	8	2026-05-12 05:37:22.029656
1359	wheat fiber	fiber	healthy	8.5	2026-05-12 05:38:03.184657
1361	basil oil	natural flavor	healthy	8.5	2026-05-12 05:38:14.96327
1363	chipotle pepper	spice	healthy	8.5	2026-05-12 05:38:43.770614
1364	almond milk	dairy alternative	healthy	8.5	2026-05-12 05:38:53.313266
1366	whole eggs	protein	healthy	8	2026-05-12 05:39:38.046976
1367	bha	preservative	caution	2	2026-05-12 05:39:45.06072
1369	mackerel	protein	healthy	9.5	2026-05-12 05:40:34.257607
1371	asparagus	vegetable	healthy	9.5	2026-05-12 05:40:41.749102
1372	tahini	nut butter	neutral	7.5	2026-05-12 05:40:51.161695
1375	sunflower and/or safflower oil	oil	healthy	8.5	2026-05-12 05:41:32.187251
1376	meat	protein	healthy	8	2026-05-12 05:41:51.771284
1378	rebaudioside a	sweetener	healthy	8.5	2026-05-12 05:42:06.446158
1379	phospholipase	enzyme	caution	2.5	2026-05-12 05:42:21.36976
1381	concentrated white grape juice	fruit juice	healthy	8	2026-05-12 05:44:24.373179
1382	sunflower oil and/or canola oil	fat	healthy	8	2026-05-12 05:44:31.60752
1384	large brown eggs	protein	healthy	8	2026-05-12 05:44:48.229999
1385	mechanically recovered poultry meat	meat	caution	5	2026-05-12 05:45:12.818416
1386	lemon powder	natural flavor	healthy	8.5	2026-05-12 05:45:35.328139
1388	cheddar	dairy	healthy	8	2026-05-12 05:46:06.723696
1389	s. thermophilus	probiotic	healthy	8.5	2026-05-12 05:46:25.550351
1391	lactic acidophilus	probiotic	healthy	8.5	2026-05-12 05:46:30.014938
1392	turnip greens	vegetable	healthy	8.5	2026-05-12 05:46:37.069624
1394	mustard greens	vegetable	healthy	8.5	2026-05-12 05:46:46.784784
1396	broad beans	vegetable	healthy	8.5	2026-05-12 05:46:51.677523
1397	green bean	vegetable	healthy	8.5	2026-05-12 05:46:54.142326
1399	pepperoncini	preserved vegetable	neutral	6.2	2026-05-12 05:47:13.351169
1401	mineral oil	mineral	caution	2.5	2026-05-12 05:47:44.87577
1402	mineral salt	mineral	neutral	8	2026-05-12 05:48:11.113424
1403	artificial	artificial color	caution	2	2026-05-12 05:48:13.78457
1405	vitamin e acetate	vitamin	healthy	9.5	2026-05-12 05:48:38.451411
1407	cannellini bean	legume	healthy	9.2	2026-05-12 05:49:29.049245
1409	safflower and/or canola oil	oil	healthy	8.5	2026-05-12 05:50:26.909972
1410	nixtamalized corn	grain	healthy	8	2026-05-12 05:50:29.059346
1412	egg yolks	protein	healthy	8.5	2026-05-12 05:50:48.39258
1413	nitrous oxide	preservative	caution	2	2026-05-12 05:51:08.252342
1414	elderberry	fruit	healthy	8.5	2026-05-12 05:51:13.10417
1416	chicken extract	natural flavor	neutral	5	2026-05-12 05:53:59.830572
1417	mandarin	fruit	healthy	8.5	2026-05-12 05:54:51.979302
1419	skimmed milk cheese	dairy product	healthy	8	2026-05-12 06:00:36.679105
1421	safflower oil and/or sunflower oil	fat	healthy	8	2026-05-12 06:12:08.474123
1422	lima bean	vegetable	healthy	8.5	2026-05-12 06:13:07.21447
1424	reconstituted vegetable juice blend	juice	neutral	5	2026-05-12 06:19:20.111691
1425	watercress	vegetable	healthy	9.5	2026-05-12 06:19:51.45267
1427	gurana extract	natural flavor	healthy	7.5	2026-05-12 06:22:44.819951
1428	taurine	amino acid	neutral	5	2026-05-12 06:23:13.150681
1431	magnesium oxide	mineral	healthy	8.5	2026-05-12 06:30:07.869767
1433	great northern bean	legume	healthy	8.5	2026-05-12 06:31:59.181421
1434	paprika extract and annatto	natural color	neutral	5	2026-05-12 06:48:12.063633
1436	barley malt extract	sweetener	neutral	6.5	2026-05-12 06:48:14.32936
1437	dried peppers	spice	healthy	8	2026-05-12 06:48:15.340223
1439	cannellini beans	legume	healthy	8.5	2026-05-12 07:01:25.812133
1440	cocoa syrup	sweetener	healthy	8	2026-05-12 07:01:26.20708
1443	ellagic acid	antioxidant	healthy	8.5	2026-05-12 07:01:27.959786
1445	spinach extract	natural flavor	healthy	8.5	2026-05-12 07:01:29.149256
1446	wheat semolina	grain	neutral	6.5	2026-05-12 07:09:24.379169
1447	lemon balm	herb	healthy	8	2026-05-12 07:12:17.487243
1449	jasmine and lemon flavors	natural flavor	neutral	8	2026-05-12 07:13:14.171137
1579	red chili	spice	caution	6.5	2026-05-12 18:54:23.101811
1996	bifidobacterium bifidum and lactobacillus casei	probiotic	healthy	8.5	2026-05-13 06:41:34.355141
1451	corn oil, soybean oil, wheat, beef flavor	\N	\N	\N	2026-05-12 07:17:39.589338
1474	sodium chloride, sucrose	\N	\N	\N	2026-05-12 18:29:37.92716
1491	soy protein and wheat protein	\N	\N	\N	2026-05-12 18:31:33.546211
1528	flock of eggs	\N	\N	\N	2026-05-12 18:41:11.7715
1533	thiamine mononitrate, riboflavin, folic acid	\N	\N	\N	2026-05-12 18:42:14.862129
1547	paprika and turmeric	\N	\N	\N	2026-05-12 18:45:35.663897
1553	monofat milk	\N	\N	\N	2026-05-12 18:47:24.851266
1560	de	\N	\N	\N	2026-05-12 18:48:44.116287
1452	green pea	vegetable	healthy	9.5	2026-05-12 07:19:08.482499
1455	mechanically deboned chicken	protein	neutral	7.5	2026-05-12 18:25:51.100153
1456	peel	spice	neutral	6	2026-05-12 18:25:51.74164
1457	textured soy protein	protein	neutral	6	2026-05-12 18:25:52.118902
1458	olives	vegetable	healthy	8.5	2026-05-12 18:26:13.012621
1459	ripe olives	vegetable	healthy	8.5	2026-05-12 18:26:17.676018
1461	sodium ascorbate	preservative	caution	2	2026-05-12 18:27:01.134236
1462	heat-treated flour	grain	neutral	4.5	2026-05-12 18:27:08.188116
1464	lemon gelatin	gelatin	neutral	2.5	2026-05-12 18:27:22.405732
1465	oat extract	flavor	healthy	8.5	2026-05-12 18:27:39.683171
1467	tallow	fat	caution	2.5	2026-05-12 18:28:31.321703
1469	miso	fermented food	healthy	8.5	2026-05-12 18:28:43.822487
1470	aspergillus oryzae	microorganism	neutral	5	2026-05-12 18:28:46.545281
1471	black soybean paste	protein	neutral	7.5	2026-05-12 18:28:51.326251
1472	carrot fiber	fiber	healthy	8	2026-05-12 18:29:18.29183
1473	capers	vegetable	neutral	6.5	2026-05-12 18:29:33.296169
1475	kalamata olive	fruit	healthy	8.5	2026-05-12 18:29:40.290418
1477	black olive	vegetable	healthy	8.5	2026-05-12 18:29:49.9817
1478	pimento	spice	healthy	6.5	2026-05-12 18:29:54.694405
1481	potassium sorbate and calcium disodium edta	{preservative,preservative}	caution	2	2026-05-12 18:30:21.40118
1482	polyglycerol polyricinoleate	emulsifier	neutral	5	2026-05-12 18:30:26.30515
1483	bamboo shoots	vegetable	healthy	8.5	2026-05-12 18:30:31.113328
1485	yellow 5 and yellow 6	artificial color	caution	2	2026-05-12 18:30:47.789602
1486	di (pears)	sweetener	healthy	8	2026-05-12 18:30:52.684268
1488	yellow 5 lake and yellow 6 lake	artificial color	caution	2	2026-05-12 18:30:59.849358
1490	beef fat	fat	caution	2	2026-05-12 18:31:28.622778
1492	niacinamide	vitamin	healthy	8.5	2026-05-12 18:31:50.301674
1495	semisoft cheese milk	dairy	neutral	7	2026-05-12 18:33:30.176493
1496	plum	fruit	healthy	8.5	2026-05-12 18:33:58.774099
1498	allium cepa	vegetable	healthy	8.5	2026-05-12 18:34:44.546616
1499	parboiled brown rice	grain	healthy	8.5	2026-05-12 18:34:46.983023
1500	collard greens	vegetable	healthy	8.5	2026-05-12 18:34:56.656568
1501	safflower oil and/or canola oil	oil	healthy	9.5	2026-05-12 18:35:06.771778
1502	mandarin orange	fruit	healthy	9.5	2026-05-12 18:35:16.533156
1503	dried plum juice	fruit juice	healthy	8.5	2026-05-12 18:35:18.966408
1505	siberian ginseng root	herb	caution	6.5	2026-05-12 18:35:23.604558
1506	lemon verbena	natural flavor	neutral	6.5	2026-05-12 18:35:25.905892
1508	orange blossom water	natural flavor	neutral	5.5	2026-05-12 18:35:35.549744
1509	panax ginseng	herb	neutral	6	2026-05-12 18:35:40.384863
1510	pink salmon	protein	healthy	9.5	2026-05-12 18:36:11.811552
1512	dried pineapple	fruit	healthy	8.5	2026-05-12 18:36:33.609839
1513	white grape juice concentrate	fruit juice	healthy	8.5	2026-05-12 18:37:00.177168
1514	tart cherry juice	juice	healthy	8	2026-05-12 18:37:27.589583
1516	dough	ingredient	neutral	5	2026-05-12 18:38:02.191505
1518	disodium 5'-guanylate	preservative	caution	2.5	2026-05-12 18:38:34.750181
1519	sirloin beef	protein	healthy	8.5	2026-05-12 18:39:11.603078
1520	fermented wheat gluten	gluten	caution	2	2026-05-12 18:39:26.115368
1522	chamomile	herb	healthy	8.5	2026-05-12 18:39:38.230218
1523	lemon myrtle	herb	healthy	8.5	2026-05-12 18:39:47.631832
1525	paprika and turmeric extract	spice	healthy	8	2026-05-12 18:40:21.603398
1526	grape puree	fruit puree	healthy	8.5	2026-05-12 18:40:35.157536
1527	spice extracts	spice	neutral	8.5	2026-05-12 18:40:54.648961
1530	morello cherry	fruit	healthy	8.5	2026-05-12 18:41:47.82252
1531	red currant	fruit	healthy	8.5	2026-05-12 18:41:50.226525
1534	barley flavor	natural flavor	neutral	5	2026-05-12 18:42:17.162867
1536	brominated vegetable oil	emulsifier	caution	1	2026-05-12 18:43:10.376483
1537	thiamin mononitrate and folic acid	vitamin	healthy	9.5	2026-05-12 18:43:15.488733
1538	egg noodles	grain	neutral	4	2026-05-12 18:43:30.561219
1540	peptide	protein	healthy	8.5	2026-05-12 18:44:44.279021
1542	guarana	stimulant	caution	2.5	2026-05-12 18:45:10.866781
1543	inositol	vitamin	healthy	8	2026-05-12 18:45:13.361322
1545	malic and lactic acids	preservative	neutral	6	2026-05-12 18:45:21.123929
1548	sodium aluminium phosphate	preservative	caution	2	2026-05-12 18:45:38.137145
1550	tannic acid	preservative	caution	3	2026-05-12 18:46:07.335436
1551	mirin	sweetener	neutral	5	2026-05-12 18:46:58.2632
1554	corn bran	fiber	healthy	7.5	2026-05-12 18:47:32.157359
1555	rooibos	herb	healthy	8	2026-05-12 18:47:42.13423
1557	torula yeast	yeast	neutral	6	2026-05-12 18:48:06.92332
1558	smoked flavor	natural flavor	neutral	6	2026-05-12 18:48:16.955134
1561	reduced iron	mineral	caution	4	2026-05-12 18:48:57.757236
1562	potassium chloride	preservative	caution	4	2026-05-12 18:49:16.507095
1564	guava	fruit	healthy	8.5	2026-05-12 18:49:44.358327
1565	blueberry flavor	natural flavor	healthy	8.5	2026-05-12 18:49:56.318499
1567	limonene	natural flavor	caution	6.5	2026-05-12 18:50:01.163487
1569	enriched precooked long grain rice	grain	healthy	8.5	2026-05-12 18:50:06.047622
1571	oleoresin	natural flavor	neutral	5	2026-05-12 18:51:31.463679
1572	chicken flavor	natural flavor	neutral	6	2026-05-12 18:51:41.547663
1573	corn masa	grain	healthy	7.5	2026-05-12 18:51:53.848277
1575	dairy product solids	protein	healthy	8	2026-05-12 18:53:02.40956
1576	barley syrup	sweetener	neutral	6	2026-05-12 18:53:22.690354
1577	vodka	alcohol	avoid	0	2026-05-12 18:53:34.624825
1494	sodium bisulfite and citric acid	{preservative,acid}	caution	4	2026-05-12 18:33:15.297758
2068	citric acid and natural flavors	{acid,preservative,"natural flavor"}	neutral	6	2026-05-13 07:04:27.359151
1584	x	\N	\N	\N	2026-05-12 18:56:02.819295
1587	yellow food 5 and yellow food 6	\N	\N	\N	2026-05-12 18:57:09.388154
1592	organic	\N	\N	\N	2026-05-12 18:59:26.344914
1700	sorbic acid and citric acid	\N	\N	\N	2026-05-12 20:55:58.958146
1582	grapefruit flavour	natural flavor	neutral	5	2026-05-12 18:55:31.367328
1585	zinc oxide	mineral	caution	2	2026-05-12 18:56:25.611904
1586	barley malt syrup	sweetener	neutral	7.5	2026-05-12 18:56:30.462256
1588	trans fat	fat	avoid	0	2026-05-12 18:57:34.515957
1589	corn germ	oil	neutral	6.5	2026-05-12 18:58:33.469232
1591	mustard bran	grain	neutral	6.5	2026-05-12 18:58:58.719199
1593	yellow wax beans	vegetable	healthy	8.5	2026-05-12 18:59:33.898022
1595	silicone	preservative	caution	2	2026-05-12 18:59:38.728332
1598	coconut extract	natural flavor	neutral	8	2026-05-12 19:00:37.071218
1600	white chablis wine	alcoholic beverage	caution	2	2026-05-12 19:01:00.332925
1601	sodium propionate	preservative	caution	2	2026-05-12 19:01:20.18229
1603	black turtle bean	legume	healthy	8.5	2026-05-12 19:02:01.350437
1604	green peas	vegetable	healthy	8.5	2026-05-12 19:02:03.801308
1606	azuki bean	legume	healthy	8.5	2026-05-12 19:02:36.314111
1608	borlotti beans	legume	healthy	8.5	2026-05-12 19:03:15.95577
1609	pink beans	legume	healthy	8.5	2026-05-12 19:03:18.335202
1610	mayocoba bean	legume	healthy	8	2026-05-12 19:03:23.188817
1611	sorghum flour	grain	healthy	8.5	2026-05-12 19:04:18.617945
1613	gorgonzola cheese	cheese	neutral	6.5	2026-05-12 19:04:34.044749
1596	amylase	enzyme	neutral	6	2026-05-12 19:00:14.079318
1599	garam masala	spice	neutral	7	2026-05-12 19:00:42.338075
1614	ricotta cheese whey	byproduct	neutral	6.5	2026-05-12 19:04:36.537946
1615	grana padano	cheese	neutral	6.5	2026-05-12 19:04:38.857558
1617	chipotle peppers	spice	neutral	8	2026-05-12 19:04:53.447274
1618	passion fruit juice	fruit juice	healthy	8.5	2026-05-12 19:05:22.975449
1620	tomato fiber	fiber	healthy	8	2026-05-12 19:05:28.310327
1621	mushroom	vegetable	healthy	8.3	2026-05-12 19:05:33.209141
1623	porcini mushroom	vegetable	healthy	8.5	2026-05-12 19:05:38.273195
1624	gruyère and fontina cheeses, milk	protein	healthy	8.5	2026-05-12 19:05:48.157106
1626	tapioca flour	starch	neutral	5	2026-05-12 19:06:02.944466
1627	evaporated cane juice	sweetener	caution	2.5	2026-05-12 19:06:20.058301
1629	oat syrup	sweetener	healthy	8.5	2026-05-12 19:06:44.580139
1630	yumberry juice	fruit juice	healthy	8.5	2026-05-12 19:06:46.924965
1631	chia seeds	grain	healthy	8.5	2026-05-12 19:06:59.060702
1633	chia seed	grain	healthy	9.2	2026-05-12 19:07:23.098185
1635	blueberry and lemon flavours	natural flavor	healthy	8.5	2026-05-12 19:08:36.212187
1636	citrus pulp	fruit byproduct	neutral	6	2026-05-12 19:08:38.535977
1638	cultured milk and cream	dairy	healthy	8.5	2026-05-12 19:08:45.785075
1640	strawberry flavor	natural flavor	neutral	8	2026-05-12 19:09:03.30037
1641	aluminium sulfate	preservative	caution	2.5	2026-05-12 19:09:27.270998
1643	aged cayenne pepper	spice	caution	6.5	2026-05-12 20:42:03.120985
1644	cream powder	dairy product	neutral	3.5	2026-05-12 20:42:10.938509
1645	feta cheese	dairy	healthy	8.5	2026-05-12 20:42:11.862633
1647	cured pork	meat	caution	2.5	2026-05-12 20:42:28.313963
1649	annatto extract	natural color	neutral	6.5	2026-05-12 20:43:05.67997
1651	dried chicken meat	protein	healthy	8.5	2026-05-12 20:43:13.16685
1652	pig fat	fat	caution	2	2026-05-12 20:43:20.363806
1654	piquillo pepper	vegetable	healthy	8.5	2026-05-12 20:43:40.684495
1655	clove	spice	healthy	8	2026-05-12 20:43:50.740524
1656	pork broth	broth	neutral	4	2026-05-12 20:44:10.205314
1657	mesquite	spice	neutral	8.5	2026-05-12 20:44:15.209205
1659	lemon grass	herb	healthy	9.5	2026-05-12 20:45:28.818533
1660	rice koji	microorganism	neutral	6.5	2026-05-12 20:45:38.984487
1662	mustard oil	oil	caution	6.5	2026-05-12 20:46:10.426532
1664	color added	artificial color	caution	2	2026-05-12 20:46:37.281665
1666	green tea extract	natural flavor	healthy	8.5	2026-05-12 20:47:56.789368
1667	turkey meat	protein	healthy	8	2026-05-12 20:47:59.232952
1669	annatto and turmeric extracts color	artificial color	caution	2	2026-05-12 20:48:33.650009
1670	aji amarillo	spice	neutral	7.5	2026-05-12 20:49:07.876796
1672	capsicum and garlic	spice	healthy	9.5	2026-05-12 20:49:30.455278
1673	peanut paste	nut paste	healthy	8.5	2026-05-12 20:49:40.306233
1675	palm and palm kernel oil	fat	caution	2.5	2026-05-12 20:50:04.716662
1676	tomato powder	spice	healthy	8.5	2026-05-12 20:50:12.147455
1678	potassium sorbate & sodium benzoate	preservative	caution	4	2026-05-12 20:50:26.791506
1679	oyster sauce	seasoning	caution	4.2	2026-05-12 20:50:29.38173
1681	caramel sugar	sweetener	neutral	6.5	2026-05-12 20:51:31.269134
1682	amaranth flour	grain	healthy	8	2026-05-12 20:51:46.192706
1684	color apo carotenal	artificial color	caution	4	2026-05-12 20:51:53.333961
1686	dried whole egg	protein	healthy	8	2026-05-12 20:52:10.581183
1687	amaranth seed	grain	healthy	8.5	2026-05-12 20:52:12.968627
1688	teff	grain	healthy	8.5	2026-05-12 20:52:19.866674
1690	apple puree	fruit puree	healthy	8.5	2026-05-12 20:53:13.33804
1692	blue 1	artificial color	avoid	0	2026-05-12 20:53:36.458726
1694	cracked wheat	grain	healthy	8	2026-05-12 20:54:10.149672
1696	organic grain and seed blend	grain	neutral	6.5	2026-05-12 20:54:17.553079
1697	inverted sugar	sweetener	neutral	3.5	2026-05-12 20:55:02.463399
1698	mineral water	mineral	healthy	8	2026-05-12 20:55:47.124297
1701	potassium sorbate and lactic acid	{preservative,acid}	neutral	6.5	2026-05-12 20:56:25.608947
1702	date puree	fruit puree	healthy	8.5	2026-05-12 20:57:19.556886
1704	dried fruit	fruit	healthy	8	2026-05-12 20:57:51.18192
1706	pasta water	liquid	healthy	8	2026-05-12 20:58:09.756771
1707	cooked rice	grain	healthy	7.5	2026-05-12 20:58:24.827204
1708	coconut flour	grain	neutral	6.5	2026-05-12 20:58:59.328483
1710	wheat syrup	sweetener	neutral	6.5	2026-05-12 20:59:42.318386
1712	polysaccharide	thickener	neutral	5	2026-05-12 21:00:47.19427
1714	bht and mixed tocopherols	preservative	caution	2	2026-05-12 21:01:05.000509
1837	potassium sorbate and natural hardwood smoke	{preservative,flavor}	neutral	6.5	2026-05-13 01:04:52.390003
1716	guar gum and locust bean gum	\N	\N	\N	2026-05-12 21:02:18.206561
1838	onion powder and garlic powder	spice	healthy	8.5	2026-05-13 01:05:45.170913
1739	water, cranberry juice concentrate	\N	\N	\N	2026-05-12 23:28:46.676736
1756	organic crimson red	\N	\N	\N	2026-05-12 23:32:25.976786
1775	potassium sorbate and tert-butylhydroquinone	\N	\N	\N	2026-05-12 23:38:27.680454
1811	tango	\N	\N	\N	2026-05-13 00:58:19.367411
1825	green oak	\N	\N	\N	2026-05-13 01:01:02.033191
1833	potassium sorbate & sodium benzoate preservative -> potassium sorbate & sodium benzoate -> potassium sorbate, sodium benzoate. xanthan gum -> xanthan gum	\N	\N	\N	2026-05-13 01:04:16.065367
1841	sodium lactate: lactate, sodium phosphate: phosphate	\N	\N	\N	2026-05-13 01:06:19.687775
1717	albacore tuna	protein	healthy	8.5	2026-05-12 21:02:33.233699
1718	basmati rice	grain	healthy	8.5	2026-05-12 21:03:00.534357
1719	light cream	dairy	neutral	6.5	2026-05-12 21:03:32.385874
1720	saturated fat	fat	caution	2	2026-05-12 21:03:45.039481
1721	aronia juice	juice	healthy	8.5	2026-05-12 21:09:23.792423
1723	thiamin mononitrate	vitamin	healthy	9.5	2026-05-12 21:10:20.675698
1724	pyrophosphate	preservative	caution	2	2026-05-12 21:12:18.719411
1726	cottonseed	oil	caution	4.5	2026-05-12 23:26:41.812885
1728	goat cheese	dairy product	neutral	7	2026-05-12 23:26:44.406954
1729	emmentaler cheese	dairy product	healthy	8.5	2026-05-12 23:26:44.825351
1731	natural flavorings	natural flavor	neutral	5	2026-05-12 23:27:03.826002
1732	organic juice	juice	healthy	8	2026-05-12 23:27:24.730104
1734	and/or corolla oil	fat	neutral	2	2026-05-12 23:28:11.554603
1735	juice powder	sweetener	healthy	8.5	2026-05-12 23:28:16.156903
1736	glyc	sugar	caution	4.5	2026-05-12 23:28:32.713622
1738	strawberry flavour	natural flavor	neutral	6.5	2026-05-12 23:28:41.978054
1741	dark sweet cherries	fruit	healthy	8	2026-05-12 23:29:07.409843
1742	dried yeast	yeast	neutral	6.5	2026-05-12 23:29:12.108075
1743	durum flour	grain	healthy	9	2026-05-12 23:30:30.638275
1745	radish seed	vegetable	healthy	8.5	2026-05-12 23:30:40.018988
1747	dried mushrooms	vegetable	healthy	8.5	2026-05-12 23:30:46.860985
1748	truffle	spice	healthy	8	2026-05-12 23:30:51.468842
1751	potassium hydroxide	preservative	caution	2	2026-05-12 23:31:26.184492
1752	degerminated corn	grain	neutral	6	2026-05-12 23:31:39.759791
1753	dough conditioners mono- and di-glycerides	emulsifier	neutral	2	2026-05-12 23:31:47.163567
1754	dl-alpha tocopherol	vitamin	healthy	9	2026-05-12 23:32:12.448394
1757	flavor water	natural flavor	neutral	5	2026-05-12 23:32:51.490727
1758	citral	natural flavor	caution	2	2026-05-12 23:33:19.856532
1760	orange emulsion	emulsifier	neutral	6.5	2026-05-12 23:34:27.251043
1762	cornflower	herb	healthy	8.5	2026-05-12 23:35:14.433094
1763	lavender	natural flavor	neutral	6.5	2026-05-12 23:35:16.696706
1765	blackberry leaves	herb	healthy	8.5	2026-05-12 23:35:21.348604
1766	apple pomace	fruit	healthy	8	2026-05-12 23:35:28.164537
1767	rose hips	fruit	healthy	9.5	2026-05-12 23:35:30.7
1769	pea fiber	fiber	healthy	8.5	2026-05-12 23:36:17.435648
1771	sweet cream butter	fat	neutral	4.2	2026-05-12 23:37:48.506756
1772	vegetable broth	liquid	neutral	6.5	2026-05-12 23:38:09.167781
1774	sorbic acid and citric acid preservatives	preservative	caution	4	2026-05-12 23:38:20.705755
1776	saccharomyces cerevisiae	yeast	neutral	5	2026-05-12 23:40:19.457296
1777	baby corn	vegetable	healthy	8	2026-05-12 23:40:40.47602
1779	enriched corn flour	grain	neutral	6.5	2026-05-12 23:40:52.27255
1781	garlic onion	spice	healthy	8.5	2026-05-12 23:41:36.962081
1782	ancho pepper	spice	healthy	9.5	2026-05-12 23:41:46.189744
1783	magnesium carbonate	mineral	healthy	8	2026-05-12 23:42:13.614018
1785	sardines	protein	healthy	9.5	2026-05-12 23:42:59.57832
1786	oyster oil	fat	neutral	5	2026-05-12 23:43:01.822843
1788	monoglycerides with vitamin c and citric acid	emulsifier	neutral	4.5	2026-05-12 23:43:23.151206
1790	cyanocobalamin	vitamin	healthy	9.5	2026-05-13 00:56:34.480968
1792	riboflavin and cyanocobalamin	vitamin	healthy	8.5	2026-05-13 00:56:38.848439
1793	sunflower oil and/or corn oil	oil	healthy	8	2026-05-13 00:56:40.081254
1794	white tea	herb	healthy	8.5	2026-05-13 00:56:45.853555
1796	radicchio	vegetable	healthy	8.2	2026-05-13 00:57:06.495629
1797	green leaf	spice	neutral	5	2026-05-13 00:57:18.462935
1799	oak	spice	neutral	5	2026-05-13 00:57:27.619061
1801	rocket	spice	neutral	8	2026-05-13 00:57:32.046676
1802	tatsoi	vegetable	healthy	8.5	2026-05-13 00:57:36.665275
1804	red chard	vegetable	healthy	8	2026-05-13 00:57:41.926757
1805	red leaf lettuce	vegetable	healthy	8.5	2026-05-13 00:57:44.237638
1807	red romaine lettuce	vegetable	healthy	9.5	2026-05-13 00:57:48.645702
1808	red mustard	spice	neutral	8	2026-05-13 00:57:50.88058
1810	beet greens	vegetable	healthy	8.5	2026-05-13 00:57:55.576738
1813	frisee	vegetable	healthy	8.5	2026-05-13 00:58:30.759756
1814	red oak	spice	neutral	5	2026-05-13 00:58:52.673433
1816	linseed oil	oil	healthy	8.5	2026-05-13 00:59:33.321026
1817	unsweetened cocoa	sweetener	healthy	9.5	2026-05-13 00:59:35.626004
1819	pine nut	nut	healthy	8.5	2026-05-13 00:59:47.819467
1820	taro	root vegetable	healthy	8.5	2026-05-13 01:00:02.042966
1822	marjoram	herb	healthy	8.5	2026-05-13 01:00:38.580377
1824	dried plum	fruit	healthy	9.5	2026-05-13 01:00:54.981158
1827	green romaine lettuce	vegetable	healthy	9.5	2026-05-13 01:01:52.831999
1828	organic chard	vegetable	healthy	8.5	2026-05-13 01:02:23.897209
1829	chive	herb	healthy	8.5	2026-05-13 01:02:35.703836
1831	sunflower seed oil	fat	healthy	8.5	2026-05-13 01:03:06.801613
1832	protein isolate	protein	healthy	8.5	2026-05-13 01:04:10.740063
1835	pacific cod	protein	healthy	8.5	2026-05-13 01:04:35.59602
1836	sockeye salmon	protein	healthy	8.5	2026-05-13 01:04:37.966812
1840	stearic acid	emulsifier	neutral	5	2026-05-13 01:05:59.825239
1843	beef collagen	protein	healthy	8	2026-05-13 01:06:49.70161
1844	beef heart	protein	healthy	8	2026-05-13 01:06:58.954789
1845	gallic acid	preservative	caution	6.5	2026-05-13 01:07:03.893059
1847	heart	protein	neutral	7	2026-05-13 01:07:13.877351
1972	mixed tocopherols and mono- and diglycerides	preservative	neutral	6	2026-05-13 06:34:46.075361
1909	sodium chloride and enzymes	{salt,preservative,enzyme}	neutral	7	2026-05-13 06:13:28.3221
1877	lactic acid, natural vanilla, natural flavors	\N	\N	\N	2026-05-13 01:17:50.965853
1890	ascorbic acid and citric acid	\N	\N	\N	2026-05-13 06:05:41.392533
1927	silica and paprika	\N	\N	\N	2026-05-13 06:18:05.955993
1935	potassium sorbate, salt	\N	\N	\N	2026-05-13 06:20:22.45452
1849	alaska pollock	protein	healthy	8	2026-05-13 01:08:05.389468
1851	anchovy oil	oil	caution	6.5	2026-05-13 01:08:14.611513
1852	canthaxanthin	color	caution	2	2026-05-13 01:08:19.418124
1853	collagen	protein	healthy	8	2026-05-13 01:08:40.930806
1855	beef chuck	protein	healthy	8	2026-05-13 01:09:57.741637
1857	butylated hydroxyanisole and butylated hydroxytoluene	preservative	caution	2	2026-05-13 01:10:23.950736
1858	neufchâtel	dairy product	neutral	6.5	2026-05-13 01:10:33.789156
1860	plant sterols	nutrient	healthy	8	2026-05-13 01:12:18.252487
1861	enriched farina	grain	neutral	2	2026-05-13 01:13:04.836574
1863	seasoning blend spices	spice	neutral	8	2026-05-13 01:13:15.209643
1865	romano cheese powder	cheese	neutral	7.2	2026-05-13 01:14:14.164982
1866	natural cheese flavor	natural flavor	neutral	8	2026-05-13 01:14:18.853054
1867	blue cheese flavor	natural flavor	neutral	2	2026-05-13 01:14:21.313408
1869	sucrose esters	emulsifier	caution	4.5	2026-05-13 01:15:13.937
1870	black cherry juice	juice	healthy	8	2026-05-13 01:15:28.157925
1872	carob flour	natural sweetener	healthy	8.5	2026-05-13 01:15:42.952513
1873	seed	protein	neutral	6	2026-05-13 01:16:41.72045
1874	pistachio paste	nut	healthy	8.5	2026-05-13 01:16:43.972906
1876	lemon flavor with other natural flavors	natural flavor	neutral	5	2026-05-13 01:17:15.202923
1878	white tuna	protein	neutral	8	2026-05-13 01:17:55.675142
1880	spring water	water	healthy	9.5	2026-05-13 01:18:17.744261
1882	sweet potato juice	fruit/vegetable	healthy	8.5	2026-05-13 01:18:34.975579
1883	purple carrot	vegetable	healthy	8.5	2026-05-13 01:18:39.64903
1884	potassium bisulfite	preservative	caution	2	2026-05-13 01:18:54.052759
1885	prune juice	fruit juice	healthy	8.5	2026-05-13 01:18:56.596227
1887	fd&c blue no. 1	artificial color	caution	2	2026-05-13 06:05:28.363457
1889	red kidney beans	legume	healthy	8.5	2026-05-13 06:05:32.412823
1891	lentil	protein	healthy	8.5	2026-05-13 06:06:10.428984
1894	yellow split pea	legume	healthy	9.5	2026-05-13 06:06:33.960541
1895	soy milk	milk	healthy	8.5	2026-05-13 06:06:36.227497
1896	turmeric and paprika extracts color	artificial color	caution	4	2026-05-13 06:07:46.452083
1897	parmesan and romano cheeses pasteurized milk	cheese	neutral	7.5	2026-05-13 06:07:55.504468
1898	pickles	preserved food	caution	3.5	2026-05-13 06:08:02.32767
1899	palm oil and soybean oil with mono- and diglycerides	fat	caution	2.5	2026-05-13 06:09:01.173759
1900	fermented cabbage	vegetable	healthy	8.5	2026-05-13 06:09:27.838252
1901	manzanillo olives	fruit	healthy	8.5	2026-05-13 06:09:59.866396
1902	ripe black olives	vegetable	healthy	8.5	2026-05-13 06:10:04.515245
1903	diacetyl	preservative	caution	2.5	2026-05-13 06:10:23.686579
1904	tart cherry	fruit	healthy	8.5	2026-05-13 06:10:47.967382
1906	distilled vinegar	acid	caution	4.2	2026-05-13 06:11:40.193316
1907	vidalia onion	vegetable	healthy	8.5	2026-05-13 06:11:55.139153
1908	cheese flavor	natural flavor	neutral	5	2026-05-13 06:13:26.151713
1911	modified milk solids	dairy product	neutral	4.5	2026-05-13 06:14:08.88639
1913	polysorbate 20	emulsifier	caution	4.5	2026-05-13 06:14:23.265585
1914	ethoxyquin	preservative	caution	2	2026-05-13 06:14:27.979376
1916	spices and herbs	spice	neutral	8	2026-05-13 06:15:05.205415
1917	aged red pepper	spice	neutral	7	2026-05-13 06:15:10.136486
1919	grape must	sweetener	neutral	8	2026-05-13 06:15:49.792679
1920	mushroom powder	spice	neutral	8.5	2026-05-13 06:15:58.696211
1922	potassium gluconate	preservative	neutral	6	2026-05-13 06:16:52.258004
1923	magnesium sulphate	mineral	neutral	8	2026-05-13 06:16:59.817938
1925	gliadin	protein	caution	2	2026-05-13 06:17:45.019488
1928	iron and zinc oxide	mineral	neutral	5	2026-05-13 06:18:10.547244
1929	degermed corn meal	grain	neutral	6.2	2026-05-13 06:18:36.955355
1930	beef stock	broth	neutral	4.5	2026-05-13 06:19:15.163709
1932	sesame seeds and/or poppy seeds	seed	healthy	8	2026-05-13 06:19:41.458416
1933	potassium bromate	preservative	caution	2	2026-05-13 06:19:48.74974
1936	modified wheat starch	starch	neutral	5	2026-05-13 06:22:18.952981
1937	blue pigment	artificial color	caution	4	2026-05-13 06:22:26.126244
1939	glycerol monostearate	emulsifier	neutral	8	2026-05-13 06:22:39.882764
1940	beef and pork	meat	neutral	7	2026-05-13 06:22:44.437553
1942	citric acid and potassium sorbate	{acid,preservative}	caution	4	2026-05-13 06:23:06.164983
1943	graham flour	grain	healthy	8.5	2026-05-13 06:23:40.38432
1945	apigenin	vitamin	healthy	8.5	2026-05-13 06:24:06.73715
1947	flavorings and benzoic acid	natural flavor	neutral	5	2026-05-13 06:24:39.867113
1948	tartrazine and brominated vegetable oil	{"artificial color",emulsifier}	caution	2	2026-05-13 06:24:46.825285
1950	kiwi juice	fruit juice	healthy	9.5	2026-05-13 06:25:33.022812
1951	magnesium sulfate	mineral	caution	2	2026-05-13 06:25:39.960424
1952	watermelon juice	fruit juice	healthy	8.5	2026-05-13 06:26:05.543612
1954	popcorn	grain	neutral	6.5	2026-05-13 06:26:26.49671
1956	potato, dehydrated, with emulsifier and preservative	potato	healthy	8.5	2026-05-13 06:27:44.733568
1957	yellow lake 5	artificial color	caution	2	2026-05-13 06:27:54.33269
1958	milk powder	dairy	healthy	8	2026-05-13 06:28:12.733463
1960	culture starter	microorganism	neutral	6	2026-05-13 06:28:35.559549
1962	cherry tomatoes	vegetable	healthy	8.5	2026-05-13 06:29:05.813726
1963	mustard starch	thickener	neutral	8.5	2026-05-13 06:30:06.57125
1965	hickory smoke	natural flavor	neutral	6.5	2026-05-13 06:31:16.724355
1966	toasted corn germ oil	oil	neutral	7.5	2026-05-13 06:31:28.00745
1967	sesame seed	seed	healthy	8.5	2026-05-13 06:32:24.2846
1969	brown flaxseed	seed	healthy	8.5	2026-05-13 06:34:32.185508
1970	hemp seed	protein	healthy	8.5	2026-05-13 06:34:36.800595
1997	and l casel	\N	\N	\N	2026-05-13 06:41:45.847159
2017	unknown ingredient	\N	\N	\N	2026-05-13 06:46:01.638692
2036	turmeric and paprika	\N	\N	\N	2026-05-13 06:52:55.704804
2048	nonfat dry milk; whey protein	\N	\N	\N	2026-05-13 06:55:42.453389
2070	sodium chloride and celery seed	\N	\N	\N	2026-05-13 07:04:47.689714
1974	red 40 lake	artificial color	caution	2	2026-05-13 06:34:59.679754
1975	agave	sweetener	healthy	7.5	2026-05-13 06:35:26.651893
1976	air	\N	caution	2	2026-05-13 06:35:45.761953
1978	propylene glycol mono- and diesters	emulsifier	caution	2	2026-05-13 06:36:07.098996
1980	palm oil and/or soybean oil with emulsifier propylene glycol mono- and diesters	emulsifier	caution	6	2026-05-13 06:36:18.790705
1981	mono- and diglycerides and soy lecithin with preservative bht	emulsifier	caution	2	2026-05-13 06:36:21.250464
1982	sodium lauryl sulfate	foaming agent	caution	2	2026-05-13 06:36:26.721454
1983	tocopherols	vitamin	healthy	9.5	2026-05-13 06:37:55.360229
1984	pine	spice	neutral	7.5	2026-05-13 06:38:48.810845
1985	riboflavin and folic acid and water	vitamin	healthy	8.5	2026-05-13 06:38:53.512573
1987	vegetable stock	broth	neutral	6.2	2026-05-13 06:39:22.637572
1988	kombu	vegetable	healthy	8.5	2026-05-13 06:39:29.60444
1989	roast	spice	neutral	7	2026-05-13 06:39:36.605706
1992	apple cider	fruit	healthy	8.5	2026-05-13 06:40:04.446548
1993	datem	preservative	caution	2	2026-05-13 06:40:18.007022
1995	fruit and vegetable juice concentrates for color	colorant	caution	2.5	2026-05-13 06:41:29.800119
1998	lactobacillus casei	probiotic	healthy	8.5	2026-05-13 06:41:55.060274
1999	lyophilized b. subtilis	preservative	neutral	6	2026-05-13 06:42:07.588591
2001	lactococcus lactis subsp. lactis	natural culture	neutral	8	2026-05-13 06:42:31.278964
2002	peach flavour	natural flavor	neutral	6.5	2026-05-13 06:42:38.551196
2003	strawberry and banana and other natural flavors	natural flavor	neutral	5	2026-05-13 06:42:50.962826
2004	potassium sorbate and artificial color fd&c red #40	preservative	caution	3	2026-05-13 06:42:53.316911
2005	pasteurized	preservation method	neutral	5	2026-05-13 06:43:31.103218
2006	lemon lime flavor	natural flavor	neutral	5	2026-05-13 06:43:52.040976
2008	milk fructose	sweetener	caution	2.5	2026-05-13 06:44:24.318449
2009	sunflower lectin	protein	caution	2	2026-05-13 06:44:31.450989
2011	dried chives	herb	healthy	9.5	2026-05-13 06:44:52.1801
2012	orange juice solids	fruit	healthy	8.5	2026-05-13 06:44:56.823932
2014	potassium sorbate and natamycin	{preservative,preservative}	neutral	6	2026-05-13 06:45:26.901822
2015	mushroom flavour	natural flavor	neutral	8	2026-05-13 06:45:42.909071
2018	chicken thigh	protein	healthy	8	2026-05-13 06:46:04.022347
2019	natural casing	meat product	neutral	8.5	2026-05-13 06:46:10.844185
2020	aged provolone cheese	dairy	healthy	8	2026-05-13 06:46:17.745405
2022	sunset yellow	artificial color	caution	2	2026-05-13 06:47:16.442463
2023	benzyl alcohol	preservative	caution	2	2026-05-13 06:48:05.419152
2025	wild blueberry	fruit	healthy	9.5	2026-05-13 06:48:53.59489
2026	fungi	fungi	neutral	5	2026-05-13 06:49:00.839679
2028	eggplant	vegetable	healthy	7.5	2026-05-13 06:49:12.603111
2029	freekeh water	grain	healthy	8.5	2026-05-13 06:49:21.521666
2031	dried corn syrup	sweetener	caution	4.5	2026-05-13 06:50:01.856663
2032	diammonium phosphate	preservative	caution	2.5	2026-05-13 06:50:11.905991
2033	palm stearin	fat	neutral	2	2026-05-13 06:50:18.664818
2035	low-fat milk	dairy	healthy	8.5	2026-05-13 06:51:18.670338
2037	spice and vegetable extract	spice	neutral	6.5	2026-05-13 06:53:24.7205
2038	oleic acid	fatty acid	neutral	5	2026-05-13 06:53:43.785915
2040	swai	protein	neutral	6.5	2026-05-13 06:54:47.250156
2042	mahi-mahi	protein	healthy	8	2026-05-13 06:54:53.969123
2043	halibut	protein	healthy	8.5	2026-05-13 06:54:56.212376
2045	lake whitefish	fish	healthy	8	2026-05-13 06:55:00.716112
2046	bluegill	protein	neutral	4.5	2026-05-13 06:55:02.970924
2049	mentha extract	natural flavor	neutral	8	2026-05-13 06:55:51.881069
2050	evaporated milk	milk	healthy	8	2026-05-13 06:55:58.850452
2052	butter flavor	natural flavor	neutral	6	2026-05-13 06:56:27.812901
2054	pumpkin pie spice	spice	neutral	4.5	2026-05-13 06:56:56.708923
2055	sodium chloride dioxide	preservative	caution	2	2026-05-13 06:57:01.455891
2056	artificial flavors	natural flavor	neutral	8	2026-05-13 06:58:23.249725
2057	maple and spice extractives	natural flavor	neutral	8	2026-05-13 06:59:07.777556
2058	polyphosphate	preservative	caution	3	2026-05-13 06:59:30.995186
2059	broth	liquid	neutral	4.2	2026-05-13 06:59:42.354422
2060	scallops	protein	healthy	8.5	2026-05-13 06:59:47.085394
2061	soybean oil and/or corn oil	oil	neutral	8	2026-05-13 06:59:53.900245
2062	confectioners glaze	preservative	caution	2.5	2026-05-13 07:00:12.890619
2063	sorbic acid sodium benzoate	preservative	caution	2.5	2026-05-13 07:01:51.790413
2065	black bean powder	protein	healthy	8.5	2026-05-13 07:03:25.469227
2067	dehydrated vegetables	vegetable	healthy	8.5	2026-05-13 07:04:20.475126
2069	allium	spice	neutral	8	2026-05-13 07:04:45.458341
2071	cumin & cayenne pepper	spice	healthy	8.5	2026-05-13 07:04:56.913724
2072	thyme and pepper	spice	healthy	9.5	2026-05-13 07:04:59.165552
2073	l-citrulline	amino acid	healthy	8.5	2026-05-13 07:05:19.658372
2075	organic cane juice	sweetener	healthy	8.5	2026-05-13 07:06:10.547186
2076	myristica	spice	neutral	6	2026-05-13 07:06:52.700863
2078	sulfur	mineral	caution	2	2026-05-13 07:07:45.505427
2079	goji berries	fruit	healthy	8.5	2026-05-13 07:07:57.052485
2081	coriander leaves	herb	healthy	8.5	2026-05-13 07:09:12.988832
2083	banana extract	natural flavor	healthy	8	2026-05-13 07:09:26.689673
2084	peru balsam	natural flavor	avoid	2	2026-05-13 07:09:40.475471
2085	watermelon	fruit	healthy	8.5	2026-05-13 07:11:36.375535
2086	whole grain	grain	healthy	8.5	2026-05-13 07:11:47.84139
2088	tapioca	starch	neutral	7.2	2026-05-13 07:13:32.848461
2090	pretzel	grain	neutral	6	2026-05-13 07:13:58.755256
2091	wasabi	spice	caution	4.2	2026-05-13 07:14:44.679487
2093	pyridoxine	vitamin	healthy	9.5	2026-05-13 07:15:19.860711
1991	montamore	preservative	caution	2	2026-05-13 06:39:50.316678
2107	bamboo shoots, citric acid	\N	\N	\N	2026-05-13 07:17:54.199607
2125	egg yolks -> egg yolk, distilled white vinegar -> white vinegar	\N	\N	\N	2026-05-13 07:20:34.348191
2128	tangles	\N	\N	\N	2026-05-13 07:20:48.197211
2150	glutinous rice flour -> sticky rice flour, peanut -> peanut, soy sauce -> soy sauce, water -> water, soynean -> soybean, wheat -> wheat, salt -> salt, seaweed -> seaweed, sugar -> sugar	\N	\N	\N	2026-05-13 07:23:29.363127
2153	egg white powder -> egg albumen, mineral salt -> salt	\N	\N	\N	2026-05-13 07:23:48.257982
2174	salt, water, riboflavin, folic acid	\N	\N	\N	2026-05-13 07:28:38.005782
2186	cholesterol and gluten free food	\N	\N	\N	2026-05-13 07:33:03.37777
2197	contains two percent or less	\N	\N	\N	2026-05-13 07:36:23.518364
2200	red food 3	\N	\N	\N	2026-05-13 07:37:58.421524
2204	potassium sorbate and carbon dioxide preservatives. phosphoric acid	\N	\N	\N	2026-05-13 07:40:27.809092
2096	bacterial cultures	natural flavor	healthy	8.5	2026-05-13 07:15:52.168552
2097	burdock root	vegetable	healthy	9.5	2026-05-13 07:16:39.99801
2099	wakame	vegetable	healthy	8.5	2026-05-13 07:16:56.018044
2100	whole egg powder	protein	neutral	7	2026-05-13 07:17:03.035745
2102	sodium metaphosphate	preservative	caution	4.5	2026-05-13 07:17:14.931835
2103	rice bran oil	oil	healthy	8.5	2026-05-13 07:17:24.319966
2105	horse mackerel	protein	healthy	8.5	2026-05-13 07:17:33.515383
2106	dried seaweed	vegetable	healthy	8.5	2026-05-13 07:17:51.880942
2109	orange juice concentrate	fruit juice	healthy	8.5	2026-05-13 07:18:05.698363
2110	oolong tea	natural flavor	healthy	8.5	2026-05-13 07:18:10.281812
2112	sorghum	grain	healthy	8	2026-05-13 07:18:19.418364
2114	sweet rice	grain	neutral	7.5	2026-05-13 07:18:53.712767
2115	star anise	spice	neutral	8	2026-05-13 07:18:58.261857
2117	daikon	vegetable	healthy	8.5	2026-05-13 07:19:08.716219
2118	mung bean starch	starch	healthy	8	2026-05-13 07:19:20.014935
2119	black sesame	seed	healthy	8	2026-05-13 07:19:38.460705
2120	berkshire pig	protein	healthy	8.5	2026-05-13 07:19:45.117651
2122	perilla extract	natural flavor	neutral	5	2026-05-13 07:20:10.709751
2123	perilla oil	oil	healthy	8.5	2026-05-13 07:20:15.543462
2126	black soybean	legume	healthy	8.5	2026-05-13 07:20:43.626098
2129	coconut milk	dairy	neutral	6.5	2026-05-13 07:21:04.242832
2130	sodium bisulphite	preservative	caution	2	2026-05-13 07:21:11.290818
2132	rice vinegar	natural flavor	neutral	6	2026-05-13 07:21:24.874188
2133	napa cabbage	vegetable	healthy	8.5	2026-05-13 07:21:36.167508
2135	glutinous rice flour	grain	neutral	6.5	2026-05-13 07:21:40.652494
2136	oyster	protein	healthy	8	2026-05-13 07:21:49.681256
2138	fd & c blue no. 1	artificial color	caution	2	2026-05-13 07:22:06.316077
2140	kelp extract	natural flavor	healthy	8	2026-05-13 07:22:15.315391
2141	butter substitute	milk product	neutral	4.5	2026-05-13 07:22:24.646011
2142	horse radish	spice	neutral	6.2	2026-05-13 07:22:33.900816
2143	brown mustard	spice	neutral	7.5	2026-05-13 07:22:36.210724
2145	methionine	amino acid	healthy	8	2026-05-13 07:22:49.796605
2147	dried bonito flakes	flavor	neutral	6.2	2026-05-13 07:22:56.669345
2148	hydrolyzed yeast protein	protein	neutral	6	2026-05-13 07:22:59.046335
2151	alaska pollack	protein	healthy	8.5	2026-05-13 07:23:31.736951
2152	straw mushrooms	vegetable	healthy	8.5	2026-05-13 07:23:47.852204
2155	fd&c blue no.1	artificial color	avoid	0	2026-05-13 07:24:18.56005
2156	chlorophyllin	natural color	caution	6	2026-05-13 07:24:41.958012
2158	trehalose	sweetener	neutral	4.5	2026-05-13 07:25:14.520826
2159	coconut powder	nut	healthy	8.5	2026-05-13 07:25:52.165367
2161	ethyl maltol	natural flavor	neutral	5	2026-05-13 07:26:34.45173
2162	2-methylpyrazine	flavor	caution	2	2026-05-13 07:26:36.741611
2164	methanethiol	preservative	caution	2	2026-05-13 07:26:45.835318
2165	propanal	preservative	caution	2	2026-05-13 07:26:48.122758
2168	dried leeks	vegetable	healthy	8	2026-05-13 07:27:37.489073
2169	sodium inosinate	preservative	caution	3.5	2026-05-13 07:27:39.639792
2170	beef protein	protein	healthy	8	2026-05-13 07:27:51.24365
2171	non-dairy creamer	sweetener	neutral	4.5	2026-05-13 07:27:53.587159
2172	potato powder	starch	healthy	8	2026-05-13 07:28:00.615722
2173	glycerol esters of fatty acids	emulsifier	neutral	5	2026-05-13 07:28:07.501958
2176	waxy corn starch	thickener	neutral	6	2026-05-13 07:30:01.082812
2177	aloe vera gel	natural flavor	healthy	8.5	2026-05-13 07:30:21.591792
2179	polyglycerol esters	emulsifier	neutral	6	2026-05-13 07:30:40.492188
2181	bonito extract	natural flavor	neutral	5	2026-05-13 07:31:19.989793
2182	threadfin bream	fish	healthy	8.5	2026-05-13 07:31:31.434176
2183	ferulic acid	antioxidant	healthy	8.5	2026-05-13 07:31:51.806371
2187	ethoxylated monoalkyl polyglycoside	surfactant	caution	2.5	2026-05-13 07:34:27.08143
2188	pineapple flavour	natural flavor	neutral	4.5	2026-05-13 07:34:57.081482
2189	grapefruit essence	natural flavor	neutral	4.5	2026-05-13 07:34:59.400112
2191	maple flavor	natural flavor	neutral	5	2026-05-13 07:35:17.439367
2192	yucca extract	natural flavor	neutral	6.5	2026-05-13 07:35:19.688738
2194	soybean oil and/or palm oil	fat	caution	5	2026-05-13 07:35:44.136066
2196	palm oil and/or soybean oil with emulsifier propylene glycol mono ester	emulsifier	caution	2.5	2026-05-13 07:36:09.907801
2198	apo carotenal	color	caution	2.5	2026-05-13 07:37:09.882848
2199	tea extract	natural flavor	neutral	7.5	2026-05-13 07:37:30.758511
2201	aluminium sulphate	preservative	caution	2	2026-05-13 07:39:29.523404
2202	folic acid fructose	vitamin	healthy	9.5	2026-05-13 07:40:04.468599
2206	sweetened condensed whole milk	dairy	caution	2.5	2026-05-13 07:41:43.777062
2208	crust	grain	neutral	2.5	2026-05-13 07:42:37.718389
2209	partially hydrogenated lard	fat	caution	2	2026-05-13 07:43:13.13118
2210	white rice	grain	healthy	8	2026-05-13 08:10:33.624776
2212	artificial additives	preservative	caution	2	2026-05-13 08:10:36.615378
2213	sorbitan	emulsifier	neutral	2	2026-05-13 08:10:37.600176
2215	flavourings	natural flavor	neutral	5	2026-05-13 08:11:38.035814
2216	hydrogenated oil	fat	caution	2	2026-05-13 08:11:40.326803
2219	haddock	protein	healthy	8.5	2026-05-13 08:12:28.886444
2203	colo	color	neutral	5	2026-05-13 07:40:08.928549
2224	soy protein isolate and corn protein isolate	\N	\N	\N	2026-05-13 08:13:56.717852
2258	natural flavor and butylated hydroxyanisole	\N	\N	\N	2026-05-13 10:29:57.262389
2288	sodium bisulfite: sulfite, citric acid: citric acid	\N	\N	\N	2026-05-13 20:07:40.729465
2295	canola oil and soybean oil	\N	\N	\N	2026-05-13 20:10:22.205317
2305	soybean oil and canola oil	\N	\N	\N	2026-05-13 20:15:24.319134
2308	sodium chloride, onion	\N	\N	\N	2026-05-13 20:17:26.526184
2313	red 40 and blue 1. peppermint discs - sugar	\N	\N	\N	2026-05-13 20:19:14.938225
2320	potassium sorbate, bht, tbhq, citric acid	\N	\N	\N	2026-05-13 20:21:51.946588
2343	sodium chloride, cheddar cheese, enzyme modified cheddar cheese, milk	\N	\N	\N	2026-05-13 20:27:45.484457
2354	peeled	\N	\N	\N	2026-05-13 20:33:59.408789
2357	parmesan cheese, romano cheese, blue cheese, pasteurized milk	\N	\N	\N	2026-05-13 20:34:55.367701
2221	fish	protein	healthy	8	2026-05-13 08:13:34.609801
2223	potassium polyphosphate	preservative	caution	2.5	2026-05-13 08:13:47.087922
2225	anise oil	natural flavor	neutral	7	2026-05-13 08:14:51.943573
2227	broccoli and cauliflower	vegetable	healthy	9.5	2026-05-13 08:15:25.066694
2229	chili	spice	healthy	8.5	2026-05-13 08:16:35.624416
2230	ume plum	fruit	healthy	9.5	2026-05-13 08:16:37.876703
2231	oats and rye	grain	healthy	8.5	2026-05-13 08:16:47.998459
2233	sweet pepper	vegetable	healthy	8.5	2026-05-13 08:17:25.484147
2235	tabasco pepper	spice	neutral	8.5	2026-05-13 08:17:56.300447
2236	aged red wine	natural flavor	neutral	2.5	2026-05-13 08:17:58.540068
2237	pear juice concentrate	fruit juice	healthy	8.5	2026-05-13 08:18:00.726583
2239	concord grape juice	juice	healthy	8.5	2026-05-13 08:19:22.549893
2240	apricot puree	fruit puree	healthy	8.5	2026-05-13 08:19:41.677071
2242	butter and pecan flavor	natural flavor	neutral	6	2026-05-13 08:21:52.333222
2243	peppermint	natural flavor	healthy	8.5	2026-05-13 08:21:59.680984
2245	ferrous gluconate	mineral	healthy	8.5	2026-05-13 08:23:30.972079
2246	king crab	protein	healthy	9.5	2026-05-13 08:24:33.775227
2248	natural flavoring	natural flavor	neutral	8	2026-05-13 08:28:36.484063
2249	dried herbs	spice	healthy	8.5	2026-05-13 08:41:37.59978
2251	cheese sauce mix	condiment	neutral	4.5	2026-05-13 08:47:31.087176
2253	canola oil and/or corn oil	fat	neutral	8.5	2026-05-13 08:49:59.059709
2254	coloring agent	artificial color	caution	2.5	2026-05-13 08:51:52.211692
2256	ion	mineral	neutral	8	2026-05-13 10:29:53.108346
2257	chicken powder	protein	neutral	5	2026-05-13 10:29:56.335036
2259	smoked salt	salt	neutral	8	2026-05-13 10:30:00.921729
2260	blueberry flavour	natural flavor	healthy	8.5	2026-05-13 10:30:03.366273
2290	blue 1 and 2	artificial color	caution	2	2026-05-13 20:08:50.67689
2291	cocoa liquor	sweetener	healthy	9.5	2026-05-13 20:09:30.531488
2293	palm oil and/or soybean oil with emulsifier propylene glycol mono- and diester	emulsifier	caution	4.5	2026-05-13 20:09:57.291771
2296	diastatic malt	sweetener	neutral	6.2	2026-05-13 20:10:26.949743
2297	pretzels	grain	neutral	6.5	2026-05-13 20:10:38.719162
2298	green jalapeno pepper	vegetable	healthy	8.5	2026-05-13 20:10:48.178159
2299	flavorings and caffeine	natural flavor	neutral	8	2026-05-13 20:12:00.066714
2300	yellow 3	artificial color	avoid	2	2026-05-13 20:12:07.446506
2301	chicken thigh meat	protein	healthy	8.5	2026-05-13 20:13:15.42624
2304	almond meal	grain	healthy	7.8	2026-05-13 20:14:35.40094
2306	cheddar cheese solids	dairy product	healthy	8.5	2026-05-13 20:16:02.023701
2307	lutein	vitamin	healthy	8.5	2026-05-13 20:16:12.625487
2310	tartrazine and sunset yellow fcf and butylated hydroxyanisole	artificial color	caution	2	2026-05-13 20:18:16.321899
2311	sodium metabusulfite	preservative	caution	2	2026-05-13 20:18:22.806831
2312	tartrazine & brilliant blue fcf	artificial color	caution	2	2026-05-13 20:19:04.709057
2314	minerals	mineral	neutral	5	2026-05-13 20:19:20.9323
2315	tomato pure water	fruit	healthy	8.5	2026-05-13 20:19:28.070588
2317	peppermint extract	natural flavor	neutral	8.5	2026-05-13 20:20:01.343381
2319	artificial coloring	artificial color	caution	2	2026-05-13 20:20:43.845446
2321	corn extract	natural flavor	neutral	2.5	2026-05-13 20:21:57.103269
2323	no artificial flavors or colors added	natural flavor	healthy	9.5	2026-05-13 20:22:15.725695
2324	wax bean	vegetable	healthy	8.5	2026-05-13 20:22:30.970661
2326	clam meat	protein	healthy	8.5	2026-05-13 20:22:47.978556
2329	rosin	preservative	caution	4	2026-05-13 20:24:15.999329
2330	peanut flavour	natural flavor	neutral	5.5	2026-05-13 20:24:26.868289
2331	nonfat yogurt powder	dairy product	healthy	8.5	2026-05-13 20:24:32.249102
2332	peanut meal	protein	healthy	8.5	2026-05-13 20:24:37.541693
2334	phosphorus	mineral	caution	2	2026-05-13 20:25:05.788437
2336	apple and grape juice concentrates	sweetener	caution	6	2026-05-13 20:25:14.125507
2337	wood rosin	preservative	caution	3.2	2026-05-13 20:25:43.076832
2338	pasteurized cows milk	dairy	healthy	8	2026-05-13 20:26:58.46595
2340	parmesan cheese blend pasteurized milk	cheese	neutral	8	2026-05-13 20:27:23.491054
2289	citric acid and artificial color tartrazine	{acid,preservative,"artificial color"}	caution	2.5	2026-05-13 20:08:25.910716
2333	cherry puree	fruit	healthy	9.5	2026-05-13 20:24:57.222846
2339	provolone	cheese	neutral	7.5	2026-05-13 20:27:21.157189
2344	yellow 6 lake	artificial color	caution	2	2026-05-13 20:27:50.181168
2346	monosodium umami flavor enhancer	natural flavor	neutral	5	2026-05-13 20:28:37.749118
2347	cooked beans	protein	healthy	8.5	2026-05-13 20:28:59.856938
2349	acetic acid esters of mono- and diglycerides	emulsifier	caution	2.5	2026-05-13 20:29:16.655881
2350	colored maltodextrin	thickener	neutral	2.5	2026-05-13 20:30:50.875794
2351	pea	protein	healthy	9.5	2026-05-13 20:31:51.295048
2353	cashews	nut	healthy	8.5	2026-05-13 20:32:58.549399
2355	acesulfame potassium and sucralose sweeteners	sweetener	caution	2	2026-05-13 20:34:02.341898
2356	mono calcium phosphate	preservative	neutral	6	2026-05-13 20:34:23.890632
2359	disodium 5'-inosinate and sodium caseinate	preservative	caution	3	2026-05-13 20:35:04.833726
2361	emulsifier mon- and diglycerides	emulsifier	neutral	6	2026-05-13 20:35:43.08266
2362	blue cheese milk	dairy product	caution	2.5	2026-05-13 20:36:00.003808
2363	pasteurized process cheese food	dairy product	caution	2.5	2026-05-14 04:29:23.237541
2364	semisoft cheese	dairy product	neutral	6.5	2026-05-14 04:29:40.674021
2371	light	\N	\N	\N	2026-05-14 04:33:53.816635
2379	less than 2% water	\N	\N	\N	2026-05-14 04:37:03.601972
2382	modified foodstuffs	\N	\N	\N	2026-05-14 04:38:16.595469
2385	sodium caseinate, dipotassium phosphate, cellulose gum	\N	\N	\N	2026-05-14 04:41:01.641913
2398	xanthan gum, arabic gum, tartrazine	\N	\N	\N	2026-05-14 04:43:45.419562
2409	and	\N	\N	\N	2026-05-14 04:48:12.804534
2413	potassium sorbate, tbhq, citric acid	\N	\N	\N	2026-05-14 04:51:38.432253
2421	vitamin b6, vitamin d3	\N	\N	\N	2026-05-14 04:53:39.812296
2425	beeswax and tartrazine	\N	\N	\N	2026-05-14 04:54:33.488141
2429	rd 40	\N	\N	\N	2026-05-14 04:57:20.79316
2437	beeswax and fd&c blue 2	\N	\N	\N	2026-05-14 04:59:16.782936
2443	ramano	\N	\N	\N	2026-05-14 05:03:00.227019
2448	sodium chloride, barley malt	\N	\N	\N	2026-05-14 05:04:51.423061
2456	sodium phosphate, sugar	\N	\N	\N	2026-05-14 05:09:00.795322
2457	sodium hexametaphosphate: sodium hexametaphosphate, citric acid: citric acid	\N	\N	\N	2026-05-14 05:09:16.89422
2462	sodium propionate and potassium sorbate	\N	\N	\N	2026-05-14 05:11:30.925188
2464	sodium propionate and sodium benzoate	\N	\N	\N	2026-05-14 05:11:59.511153
2484	chardonnay	\N	\N	\N	2026-05-14 05:16:18.429062
2486	less than	\N	\N	\N	2026-05-14 05:17:14.641516
2366	oat flour, sugar	{grain,sweetener}	neutral	6	2026-05-14 04:30:38.067133
2368	sodium metabisulphite	preservative	caution	2	2026-05-14 04:32:53.667391
2370	zinc oxide & reduced iron	mineral	neutral	6	2026-05-14 04:33:18.475829
2372	beef liver	meat	caution	6.5	2026-05-14 04:34:11.85281
2373	potassium sorbate and citric acid and tbhq	preservative	caution	3	2026-05-14 04:35:29.788711
2375	citric acid and sodium propionate and potassium sorbate	{acidifier,preservative,preservative}	caution	5	2026-05-14 04:35:55.585743
2376	natural colors	artificial color	avoid	0	2026-05-14 04:36:17.677629
2378	squash	vegetable	healthy	8.5	2026-05-14 04:36:53.231115
2380	mono- and diglycerides with citric acid	emulsifier	caution	2	2026-05-14 04:37:11.034143
2381	microbial enzyme preparation	preservative	neutral	5	2026-05-14 04:38:03.791433
2383	less than 1% of natural flavours	natural flavor	neutral	2	2026-05-14 04:38:56.48982
2384	citric acid and natural orange flavor	{preservative,"natural flavor"}	neutral	5	2026-05-14 04:40:11.123778
2386	acesulfame potassium and sucralose sweetener	sweetener	caution	2	2026-05-14 04:41:29.800795
2387	onion oil	oil	neutral	2	2026-05-14 04:41:39.694945
2389	fd&c yellow 5	artificial color	caution	2	2026-05-14 04:42:23.84429
2391	fd&c colors	artificial color	avoid	2	2026-05-14 04:42:37.120192
2392	tragacanth	thickener	neutral	6	2026-05-14 04:42:49.325641
2394	blue 1 and red 40	artificial color	avoid	2	2026-05-14 04:42:56.789054
2396	invertase	enzyme	neutral	6.5	2026-05-14 04:43:19.799324
2397	cherry flavour	natural flavor	neutral	6.5	2026-05-14 04:43:22.126714
2399	chocolate liquor	sweetener	caution	4.5	2026-05-14 04:43:47.841046
2401	sugar and cornstarch	{sweetener,thickener}	caution	2	2026-05-14 04:44:26.559544
2403	blue 1 and blue 2	artificial color	avoid	2	2026-05-14 04:44:31.302356
2404	and blue 1	artificial color	avoid	0	2026-05-14 04:44:37.001354
2406	fd&c	artificial color	caution	2	2026-05-14 04:44:56.803244
2407	pork ribs	meat	caution	4.5	2026-05-14 04:45:39.325046
2410	red 40 and blue 1 lake	artificial color	caution	2	2026-05-14 04:48:57.548438
2411	protease	enzyme	neutral	5	2026-05-14 04:49:52.9941
2414	merluza	protein	healthy	9	2026-05-14 04:51:53.768244
2415	sole	protein	healthy	8	2026-05-14 04:51:56.280238
2417	douchi	fermented ingredient	healthy	8.5	2026-05-14 04:52:23.272764
2419	sheep's milk	dairy	neutral	6.5	2026-05-14 04:53:27.617231
2422	mechanically separated meat	meat	caution	2	2026-05-14 04:53:59.719696
2423	lemon juice and pomegranate flavor	natural flavor	healthy	9.5	2026-05-14 04:54:26.014101
2424	malvidin	anthocyanin	healthy	9.5	2026-05-14 04:54:28.882521
2426	soybean oil and palm oil	fat	neutral	5	2026-05-14 04:56:02.123977
2428	soy mono- and diglycerides	emulsifier	neutral	5	2026-05-14 04:56:50.443292
2431	sodium benzoate and citric acid	{preservative,acid}	caution	2	2026-05-14 04:57:47.043006
2432	tomato extract	natural flavor	healthy	8.5	2026-05-14 04:58:10.16305
2434	blend	spice	neutral	5	2026-05-14 04:58:35.098485
2435	iron oxide	artificial color	caution	2	2026-05-14 04:58:57.9409
2438	reduced protein whey	protein	neutral	7	2026-05-14 04:59:19.43914
2440	zinc gluconate	mineral	healthy	8.5	2026-05-14 05:01:04.243403
2442	betaine	preservative	neutral	6.5	2026-05-14 05:02:48.983297
2444	whey protein concentrate	protein	healthy	8.5	2026-05-14 05:03:02.664404
2446	butyric acid	preservative	caution	2	2026-05-14 05:03:17.466771
2447	pyridoxine hydrochloride	vitamin	healthy	8.5	2026-05-14 05:03:28.284619
2449	blue 2 lake and artificial flavor	artificial color	caution	2	2026-05-14 05:05:12.678121
2450	vegetable	vegetable	healthy	8.5	2026-05-14 05:05:25.151705
2452	rhubarb	fruit	healthy	8.5	2026-05-14 05:06:22.870906
2453	contains 2% or less of	preservative	caution	2	2026-05-14 05:06:26.013276
2455	alkali-processed corn	grain	neutral	6	2026-05-14 05:08:41.620552
2458	locust bean gum and carrageenan	thickener	neutral	8	2026-05-14 05:09:48.139041
2459	sodium stearyl lactate	emulsifier	neutral	5.5	2026-05-14 05:10:50.106374
2461	potassium sorbate and sodium propionate	preservative	caution	2	2026-05-14 05:11:02.293919
2463	rice syrup	sweetener	caution	2	2026-05-14 05:11:36.321933
2466	portabella mushroom	vegetable	healthy	8.5	2026-05-14 05:12:42.209905
2467	cajun seasoning	spice	neutral	6	2026-05-14 05:12:46.743881
2469	natural flavor and color	natural flavor	neutral	5	2026-05-14 05:13:41.426137
2470	bleu cheese	cheese	caution	6.5	2026-05-14 05:13:59.957494
2472	peppadew peppers	vegetable	healthy	8.5	2026-05-14 05:14:31.0208
2473	milk and cream	dairy product	healthy	8	2026-05-14 05:14:36.492978
2474	champagne	alcoholic beverage	caution	2.5	2026-05-14 05:15:07.551538
2476	grapefruit oil	natural flavor	healthy	8	2026-05-14 05:15:14.666439
2478	apple cider vinegar	natural flavor	healthy	8.5	2026-05-14 05:15:28.940227
2480	garlic paprika and turmeric color	spice	healthy	9.2	2026-05-14 05:15:40.973422
2481	shishito pepper	vegetable	healthy	8.5	2026-05-14 05:15:45.543993
2483	lemon extract	natural flavor	neutral	8.5	2026-05-14 05:16:13.940693
2485	merlot	natural flavor	neutral	5	2026-05-14 05:16:30.494948
2496	milk, sugar, chocolate	\N	\N	\N	2026-05-14 05:21:12.212474
2513	lactobacillus rhamnosus, lactobacillus casei	\N	\N	\N	2026-05-14 05:25:15.888232
2559	citric acid and paprika extract	\N	\N	\N	2026-05-14 05:38:14.330935
2577	fd&	\N	\N	\N	2026-05-14 18:23:33.301165
2584	indigo lake	\N	\N	\N	2026-05-14 18:25:25.171432
2588	sodium citrate, ascorbic acid, vitamin c	\N	\N	\N	2026-05-14 18:26:11.241077
2490	button mushrooms	vegetable	healthy	8.5	2026-05-14 05:19:10.698414
2491	flavor enhancer	natural flavor	neutral	5	2026-05-14 05:19:36.610636
2493	aloin	natural color	avoid	0	2026-05-14 05:20:24.211513
2494	coconut pulp	fruit	healthy	8.5	2026-05-14 05:20:53.474914
2495	matcha	herb	healthy	8.5	2026-05-14 05:21:07.022287
2498	dried montmorency cherry	fruit	healthy	8.5	2026-05-14 05:21:21.523951
2499	cacao	sweetener	healthy	8.5	2026-05-14 05:21:26.205351
2501	vegetable shortening and palm oil	fat	caution	2.5	2026-05-14 05:21:54.660912
2502	sorbitan stearate	emulsifier	neutral	5	2026-05-14 05:21:57.177739
2503	anhydrous milkfat	fat	neutral	6	2026-05-14 05:23:22.730112
2505	bifidobacterium lactis	probiotic	healthy	9.5	2026-05-14 05:23:39.628167
2507	lactocasei	probiotic	healthy	9.5	2026-05-14 05:23:56.89474
2508	lingonberry	fruit	healthy	8.5	2026-05-14 05:24:03.635634
2509	sour cherry	fruit	healthy	8.5	2026-05-14 05:24:08.22826
2511	marionberry	fruit	healthy	8.5	2026-05-14 05:24:43.489629
2512	thermophilus	probiotic	healthy	9.5	2026-05-14 05:24:52.513739
2516	lactobacillus builgaricus	probiotic	healthy	8.5	2026-05-14 05:25:46.108477
2517	fruit juice	juice	healthy	9.5	2026-05-14 05:25:55.461093
2518	lyophilized lactic acid bacteria	probiotic	healthy	8.5	2026-05-14 05:26:09.488223
2519	ghee	fat	neutral	5	2026-05-14 05:26:44.191288
2520	mango powder	natural flavor	healthy	8.5	2026-05-14 05:26:48.904179
2522	palm sugar	sweetener	neutral	6	2026-05-14 05:26:57.947312
2524	gram	protein	healthy	9	2026-05-14 05:27:14.036186
2525	matpe beans	legume	healthy	8.5	2026-05-14 05:27:20.909143
2526	green gram	legume	healthy	8.5	2026-05-14 05:27:27.817082
2528	jaggery	sweetener	healthy	8	2026-05-14 05:27:57.169865
2529	green chilli	spice	healthy	8.5	2026-05-14 05:28:06.312192
2530	guanabana	fruit	healthy	8.5	2026-05-14 05:28:10.772902
2532	condiments	condiment	neutral	6	2026-05-14 05:29:10.797687
2535	rice flour and chickpea flour blend	grain	healthy	8.5	2026-05-14 05:29:47.774466
2536	urad dal flour	grain	healthy	8.5	2026-05-14 05:29:50.030529
2537	vitamins & minerals	vitamin/mineral	healthy	9.5	2026-05-14 05:30:35.636469
2539	rose extract	natural flavor	healthy	8.5	2026-05-14 05:30:42.332043
2540	vitamins and minerals	vitamin/mineral	healthy	8.5	2026-05-14 05:30:51.909478
2541	curry leaf	herb	healthy	8.5	2026-05-14 05:31:01.07176
2542	protein-enriched flour	grain	neutral	6	2026-05-14 05:31:12.339649
2544	asafoetida	spice	neutral	6.5	2026-05-14 05:32:10.369439
2546	sago starch	starch	neutral	6	2026-05-14 05:32:45.378574
2547	trigonella	herb	healthy	8.5	2026-05-14 05:32:50.350219
2548	gram flour	grain	healthy	9	2026-05-14 05:33:18.5607
2550	purple carrot extract	natural flavor	healthy	8.5	2026-05-14 05:34:42.198137
2552	prune puree	fruit	healthy	8.5	2026-05-14 05:35:45.180866
2553	romanesco	vegetable	healthy	9.5	2026-05-14 05:36:27.610758
2555	yellow dye	artificial color	caution	2	2026-05-14 05:36:52.740232
2557	modified cornstarch and paprika extract	{thickener,"natural flavor"}	neutral	6.5	2026-05-14 05:37:32.506564
2560	extractives	natural flavor	neutral	5	2026-05-14 05:38:23.747503
2562	pasteurized cheese product american cheese pasteurized milk	dairy product	neutral	4	2026-05-14 05:38:39.694916
2563	carotenoids	vitamin	healthy	8.5	2026-05-14 05:38:46.620037
2564	white fish	protein	healthy	8.5	2026-05-14 05:43:25.715537
2565	hydrogen	mineral	neutral	5	2026-05-14 05:44:47.517436
2568	sodium citrate and natural flavor	preservative	neutral	6	2026-05-14 05:59:13.100348
2569	artificial blue 1 and artificial red 3	artificial color	caution	2	2026-05-14 06:03:22.76692
2570	reduced mineral water	water	healthy	9.5	2026-05-14 06:04:19.487281
2571	water vapor	\N	neutral	5	2026-05-14 06:14:55.21087
2572	whole grain corn	grain	healthy	7.5	2026-05-14 06:24:08.255543
2573	strawberry juice concentrate	fruit juice	healthy	8.5	2026-05-14 06:32:29.820853
2574	pistachio flavor	natural flavor	neutral	8	2026-05-14 06:34:45.663596
2575	coconut puree	fruit puree	healthy	8.5	2026-05-14 18:23:30.96754
2576	lemon puree	natural flavor	healthy	8.5	2026-05-14 18:23:32.883203
2578	organic cranberry concentrate	fruit juice concentrate	healthy	8.5	2026-05-14 18:23:39.682681
2579	cranberry flavor	natural flavor	neutral	7.5	2026-05-14 18:23:40.251792
2580	fruit and vegetable juice	juice	healthy	8	2026-05-14 18:23:47.243785
2581	dried blueberry	fruit	healthy	8.5	2026-05-14 18:24:32.599419
2582	dried cane syrup	sweetener	caution	6.5	2026-05-14 18:24:39.681997
2583	dried strawberry cranberries	dried fruit	healthy	8.5	2026-05-14 18:25:17.652212
2585	parabens	preservative	caution	2.5	2026-05-14 18:25:27.626035
2586	polyunsaturated fatty acids	fat	healthy	9	2026-05-14 18:25:35.051722
2589	blackcurrant extract	natural flavor	healthy	8.5	2026-05-14 18:26:38.627707
2590	purple sweet potato	vegetable	healthy	8.5	2026-05-14 18:26:51.793749
2592	graham cracker	grain	neutral	4	2026-05-14 18:28:31.837302
2593	beta-alanine	amino acid	neutral	5	2026-05-14 18:30:12.166612
2595	microbial culture	preservative	neutral	6.5	2026-05-14 18:30:33.781651
2597	asiago and romano cheese pasteurized milk	dairy	healthy	8.5	2026-05-14 18:31:30.627497
2598	bellavitano cheese	dairy product	neutral	6	2026-05-14 18:31:50.602447
2600	jalapeno peppers salt enzymes	spice	healthy	8	2026-05-14 18:32:32.989604
2601	calcium disodium	preservative	neutral	5	2026-05-14 18:33:31.023988
2603	monk fruit	sweetener	healthy	9	2026-05-14 18:34:31.51907
2605	isobutyrate	preservative	caution	4	2026-05-14 18:35:05.108607
2606	culture	natural yeast	neutral	6.5	2026-05-14 18:36:41.635205
2608	potato and edamame salad	\N	neutral	8	2026-05-14 18:39:03.916753
2609	rice hull	fiber	healthy	8	2026-05-14 18:39:13.524377
2611	strawberries and bananas	fruit	healthy	8.5	2026-05-14 18:39:53.766395
2612	tapico syrup	sweetener	caution	3.5	2026-05-14 18:40:05.674168
2622	soybean oil and olive oil	\N	\N	\N	2026-05-14 18:43:11.00028
2646	ethanol and sucrose	\N	\N	\N	2026-05-14 18:50:39.900639
2673	pasteurized milk, parmesan cheese, monterey jack cheese	\N	\N	\N	2026-05-14 19:02:52.025522
2678	sunflower oil and canola oil	\N	\N	\N	2026-05-14 19:03:51.344262
2688	hu	\N	\N	\N	2026-05-14 19:09:22.142457
2699	sodium chloride, cream cheese, pasteurized cultured milk, cream	\N	\N	\N	2026-05-14 19:12:53.98593
2701	flaxseed oil, olive oil, water	\N	\N	\N	2026-05-14 19:13:13.459844
2730	baking soda -> sodium bicarbonate, annatto extract -> annatto	\N	\N	\N	2026-05-14 19:18:27.065713
2615	natural chocolate flavor	natural flavor	neutral	7.5	2026-05-14 18:40:54.1559
2617	gum base	thickener	caution	4.5	2026-05-14 18:41:28.334686
2618	linoleic acid and chlorophyll	fat	healthy	8.5	2026-05-14 18:41:49.062952
2620	red 40 lake and soy lecithin. sour apple artificially flavored ingredients: sugar	{"artificial color",emulsifier,sweetener,"natural flavor"}	caution	4	2026-05-14 18:42:10.689207
2621	artesian water	water	healthy	9.5	2026-05-14 18:42:23.749331
2623	swiss chard	vegetable	healthy	8.5	2026-05-14 18:43:33.382328
2624	cake base	flour	neutral	6	2026-05-14 18:44:19.736263
2626	color fd&c	artificial color	caution	2	2026-05-14 18:44:48.892108
2629	whiskey	alcohol	avoid	0	2026-05-14 18:45:25.032
2630	mustard smoke flavoring	natural flavor	neutral	5	2026-05-14 18:45:27.552302
2631	mesquite smoke flavoring	natural flavor	neutral	5	2026-05-14 18:45:32.756448
2632	alcohol	alcohol	caution	2	2026-05-14 18:45:50.597098
2633	vitamin a palmitate & vitamin d3	vitamin	neutral	8	2026-05-14 18:46:24.401653
2634	reduced fat milk with vitamin a palmitate and vitamin d3 added	dairy	neutral	7	2026-05-14 18:46:26.857043
2635	palmitate	emulsifier	caution	2	2026-05-14 18:46:29.375245
2636	sprouted whole wheat flour	grain	healthy	9.5	2026-05-14 18:47:11.895463
2637	copper	mineral	caution	2	2026-05-14 18:47:16.754358
2638	sour dough culture	natural starter	neutral	8	2026-05-14 18:47:52.753782
2639	propylene glycol esters of fatty acids	emulsifier	caution	2	2026-05-14 18:48:01.152763
2640	curcuminoids and bixin	natural color	healthy	9.5	2026-05-14 18:48:09.770951
2641	monounsaturated	fat	healthy	8	2026-05-14 18:48:12.125373
2642	turmeric and annatto extracts	natural color	healthy	8.5	2026-05-14 18:48:34.444216
2643	psyllium husk	fiber	healthy	8.5	2026-05-14 18:49:28.182065
2644	dried egg white	protein	healthy	8.5	2026-05-14 18:49:35.4396
2647	red 40 and artificial flavors	artificial color	caution	2	2026-05-14 18:50:59.427977
2649	food colourings	artificial color	caution	2	2026-05-14 18:51:14.465909
2650	artificial flavourings and red 40	natural flavor	neutral	5	2026-05-14 18:52:03.235087
2651	red 40 / blue 1 / yellow 5	artificial color	caution	2	2026-05-14 18:52:13.853744
2653	neufchâtel cheese	dairy product	healthy	8	2026-05-14 18:52:58.878595
2655	corn grits	grain	neutral	6.5	2026-05-14 18:53:10.453394
2656	acesulfame k	sweetener	caution	2	2026-05-14 18:53:26.695368
2658	bourbon vanilla extract	natural flavor	neutral	6.5	2026-05-14 18:54:37.411019
2659	artificial butter flavor	natural flavor	neutral	5	2026-05-14 18:55:02.43819
2661	organic brown rice	grain	healthy	8.5	2026-05-14 18:56:01.818199
2662	bleached flour	flour	neutral	6.5	2026-05-14 18:56:16.594098
2663	pork stomachs	meat	caution	6.5	2026-05-14 18:56:26.552891
2665	smoke powder	preservative	caution	4	2026-05-14 18:56:57.816106
2666	ranch seasoning	seasoning	neutral	7.3	2026-05-14 18:57:09.322353
2668	organic cheddar cheese	dairy product	healthy	8.5	2026-05-14 19:00:51.062938
2670	black carrot juice	juice	healthy	8.5	2026-05-14 19:01:12.937033
2671	pepperoni	cured meat	caution	4	2026-05-14 19:01:25.158497
2674	black carrot	vegetable	healthy	8	2026-05-14 19:03:10.940626
2675	rice fiber	fiber	healthy	8	2026-05-14 19:03:25.309683
2677	live cultures	probiotic	healthy	9.5	2026-05-14 19:03:46.607831
2679	cherry juice concentrate	natural flavor	healthy	8.5	2026-05-14 19:04:19.754738
2681	organic expeller oil	oil	healthy	8.5	2026-05-14 19:05:35.556692
2682	bread flour	grain	healthy	8	2026-05-14 19:06:01.749016
2684	agave nectar	sweetener	healthy	8	2026-05-14 19:07:19.809573
2685	black sesame seeds	seed	healthy	8.5	2026-05-14 19:07:50.017888
2686	millet flour	grain	healthy	8	2026-05-14 19:09:08.03688
2689	capsanthin	antioxidant	healthy	8	2026-05-14 19:09:38.540405
2691	boneless meat	protein	healthy	8	2026-05-14 19:10:47.253564
2692	bromine	preservative	caution	2	2026-05-14 19:10:56.73276
2693	habanero	spice	caution	7.5	2026-05-14 19:11:15.671411
2695	blood orange essential oil	natural flavor	neutral	8	2026-05-14 19:11:39.121882
2698	juniper	spice	neutral	8.5	2026-05-14 19:12:04.801037
2700	flaxseed oil	oil	healthy	8.5	2026-05-14 19:13:06.346341
2702	hop oil	natural flavor	neutral	5	2026-05-14 19:13:15.825848
2703	caramelized onion	vegetable	healthy	8	2026-05-14 19:13:18.184177
2705	port wine	sweetener	caution	2	2026-05-14 19:13:36.873458
2706	purple cabbage	vegetable	healthy	8.5	2026-05-14 19:13:43.94024
2707	dextrins	starch	neutral	6.2	2026-05-14 19:14:03.666196
2709	barley grass	vegetable	healthy	8.5	2026-05-14 19:14:10.910315
2711	wheat grass	vegetable	healthy	9.5	2026-05-14 19:14:17.791264
2712	wheat sprout	grain	healthy	8.5	2026-05-14 19:14:20.152468
2714	hydrilla	herb	caution	2	2026-05-14 19:14:24.776733
2715	dulse seaweed	vegetable	healthy	8.5	2026-05-14 19:14:27.073881
2717	resveratrol	antioxidant	healthy	8.5	2026-05-14 19:14:31.685152
2718	hemp	protein	healthy	8	2026-05-14 19:14:36.287695
2720	peptides	protein	neutral	6.2	2026-05-14 19:14:53.254988
2721	fig flavor	natural flavor	neutral	5	2026-05-14 19:15:12.523612
2723	granny smith apple	fruit	healthy	9.5	2026-05-14 19:16:02.368277
2724	pork intestine	meat	caution	2	2026-05-14 19:16:12.073421
2727	dehydrated vegetable	vegetable	healthy	8	2026-05-14 19:17:24.562481
2728	tree nut meal pecan	nut	neutral	6.2	2026-05-14 19:18:03.075341
2729	interesterified and hydrogenated vegetable oil	fat	caution	2	2026-05-14 19:18:17.312723
2731	rye meal	grain	healthy	7.5	2026-05-14 19:18:53.426886
2732	cream of tartar	preservative	neutral	6	2026-05-14 19:19:16.661886
2733	carminic acid	natural food coloring	neutral	5	2026-05-14 19:19:18.992955
135	coconut oil	fat	neutral	6.5	2026-05-10 01:20:19.145437
136	banana	fruit	healthy	9.5	2026-05-10 01:20:20.336551
139	starch	thickener	neutral	5	2026-05-10 01:20:20.977346
141	baking ammonia	leavening agent	caution	4	2026-05-10 01:20:21.408537
145	cashew	nut	healthy	8.5	2026-05-10 01:20:22.820687
148	salt	mineral	caution	4	2026-05-10 01:20:23.469946
150	grape juice	natural flavor	healthy	8.5	2026-05-10 01:20:23.899392
154	tocopherol	antioxidant	healthy	9.5	2026-05-10 01:20:24.873752
157	flaxseed	fiber	healthy	9.5	2026-05-10 01:20:35.404089
159	dates	natural sweetener	healthy	8.5	2026-05-10 01:20:44.774593
163	fruit juice concentrate	natural sweetener	neutral	6.5	2026-05-10 01:21:00.613805
167	quinoa	protein	healthy	9.5	2026-05-10 01:21:12.109152
170	sucrose	sweetener	caution	2.5	2026-05-10 01:21:21.065059
173	peanuts	protein	healthy	8.5	2026-05-10 01:24:22.718605
176	maltose	sweetener	neutral	4	2026-05-10 01:24:24.297585
179	garlic and capsicum	spice	healthy	8.5	2026-05-10 01:24:25.188525
182	yogurt coated raisins	sweetener	caution	4.2	2026-05-10 01:24:26.672355
186	vanillin	natural flavor	neutral	8	2026-05-10 01:24:51.117074
189	cherries	fruit	healthy	8.5	2026-05-10 01:25:04.383601
192	enzymes	biological additive	neutral	8	2026-05-10 01:25:31.105493
195	capsicum	spice	healthy	9	2026-05-10 01:25:39.741128
197	maltodextrin	thickener	neutral	5	2026-05-10 01:25:46.393742
201	palm oil	fat	caution	4.2	2026-05-10 01:25:59.523578
203	calcium	mineral	healthy	9	2026-05-10 01:26:06.017674
206	carrageenan	thickener	caution	4.5	2026-05-10 01:26:12.71184
209	yeast extract	flavor enhancer	neutral	6.5	2026-05-10 01:26:39.110415
212	horseradish	spice	healthy	8.5	2026-05-10 01:26:50.363633
215	emmer	grain	healthy	8.5	2026-05-10 01:27:52.354186
218	salvia hispanica	fiber	healthy	8.5	2026-05-10 01:28:18.986069
221	lentils	protein	healthy	9	2026-05-10 01:29:10.30107
224	reduced fat	fat	neutral	5	2026-05-10 01:29:10.727075
228	lima beans	fiber	healthy	8.5	2026-05-10 01:29:11.593431
231	fennel	spice	healthy	9	2026-05-10 01:29:12.29013
233	dried grapes	fruit	healthy	8.5	2026-05-10 01:29:25.875163
236	bixin	natural color	neutral	8	2026-05-10 01:29:39.116425
238	sunflower seed and sesame	protein	healthy	8.5	2026-05-10 01:29:47.852004
242	breadcrumbs	thickener	neutral	6	2026-05-10 01:30:03.31326
244	albumen	protein	healthy	9	2026-05-10 01:30:10.019208
247	vitamin b1	vitamin	healthy	9.5	2026-05-10 01:30:16.929279
249	vitamin b3 and iron	mineral and vitamin	healthy	9	2026-05-10 01:30:21.278596
252	vitamin b9	vitamin	healthy	9.5	2026-05-10 01:30:32.238178
255	barley	fiber	healthy	8.5	2026-05-10 01:30:40.942688
257	millet flour, flaxseed	fiber	healthy	8.5	2026-05-10 01:30:47.547795
261	brown rice flour	fiber	healthy	8.5	2026-05-10 01:31:09.63771
263	cornstarch	thickener	neutral	5.5	2026-05-10 01:31:16.38602
266	sesame seeds	fiber	healthy	8.5	2026-05-10 01:31:38.445637
269	extract	natural flavor	neutral	8	2026-05-10 01:31:44.941514
272	bertholletia	nut	healthy	8.5	2026-05-10 01:31:58.158678
275	apricot	fruit	healthy	8.5	2026-05-10 01:32:28.872906
278	koji	natural flavor	healthy	8.5	2026-05-10 01:32:51.155995
280	curcuma	spice	healthy	9	2026-05-10 01:33:02.164196
283	whole wheat flour	fiber	healthy	8.5	2026-05-10 01:33:13.099524
286	palm kernel oil	fat	caution	4.2	2026-05-10 01:33:28.623279
290	peanut flour	protein	healthy	8.5	2026-05-10 01:33:46.559932
294	yeast	microorganism	healthy	8.5	2026-05-10 01:38:11.542052
297	buckwheat	protein	healthy	8.5	2026-05-10 01:38:12.788192
299	sunflower and flax seeds	fiber	healthy	9	2026-05-10 01:38:14.084895
303	black rice	fiber	healthy	8.5	2026-05-10 01:38:53.702387
306	sulfur dioxide	preservative	caution	2	2026-05-10 01:39:40.003032
310	sugar syrup	sweetener	caution	2.5	2026-05-10 01:40:13.251482
312	white chocolate	fat	caution	4.2	2026-05-10 01:40:48.449908
315	glucose	sweetener	caution	4.2	2026-05-10 01:41:08.246647
317	citrus peel	natural flavor	healthy	8.5	2026-05-10 01:41:17.100112
320	pistachio	nut	healthy	8.5	2026-05-10 01:41:32.450688
322	apple juice	natural flavor	healthy	8.5	2026-05-10 01:41:43.430798
325	liquid whole eggs	protein	healthy	8.5	2026-05-10 01:42:28.449708
327	diacetyl tartaric acid esters of mono and diglycerides	emulsifier	neutral	6.5	2026-05-10 01:42:37.246112
332	modified corn starch	thickener	neutral	5	2026-05-10 01:42:57.249487
335	calcium sorbate	preservative	neutral	8	2026-05-10 01:43:10.766558
338	potassium sorbate	preservative	caution	6.5	2026-05-10 01:43:19.567635
341	mono and diglycerides	emulsifier	caution	4.5	2026-05-10 01:43:26.252398
345	malic acid	preservative	neutral	8	2026-05-10 01:43:37.265895
348	grape	natural flavor	healthy	9	2026-05-10 01:43:46.017783
350	elderberry juice	natural flavor	healthy	8.5	2026-05-10 01:43:50.414041
354	sodium benzoate	preservative	caution	4.2	2026-05-10 01:44:12.535398
356	carbonated water	beverage base	neutral	8	2026-05-10 01:44:25.855439
359	shea butter	fat	healthy	8.5	2026-05-10 01:44:41.531869
363	sodium erythorbate	preservative	caution	4.2	2026-05-10 01:45:12.353029
366	orange peel	natural flavor	healthy	8.5	2026-05-10 01:45:28.688226
369	titanium dioxide	artificial color	caution	2.5	2026-05-10 01:45:57.48667
372	radish	vegetable	healthy	8.5	2026-05-10 01:46:10.679911
375	brilliant blue fcf	artificial color	caution	2.5	2026-05-10 01:46:32.885172
379	pineapple fibre	fiber	healthy	9	2026-05-10 02:15:19.903759
2735	vanilla flavoring	natural flavor	neutral	5	2026-05-14 19:19:44.680776
2736	wagyu beef	meat	healthy	8.5	2026-05-14 19:19:49.335872
2738	fd&c blue 1	artificial color	caution	2	2026-05-14 19:20:32.385146
2740	fd&c yellow 6	artificial color	caution	2	2026-05-14 19:21:08.561032
2742	pasteurized liquid	liquid	neutral	5	2026-05-14 19:21:36.66096
2743	dried date	fruit	healthy	8.5	2026-05-14 19:22:26.236762
2745	betanin	natural color	neutral	8	2026-05-14 19:24:38.286134
2746	bitter orange	flavor	neutral	8	2026-05-14 19:24:45.239964
2748	stabiliser	stabilizer	neutral	5	2026-05-14 19:26:14.446489
2750	citric acid and lactic acid assists gel	acid	neutral	4	2026-05-14 19:26:44.750119
2751	anise	spice	neutral	5	2026-05-14 19:26:49.431017
2753	pearl onion	vegetable	healthy	8.5	2026-05-14 19:37:42.105064
2754	winter squash	vegetable	healthy	8.5	2026-05-14 19:38:48.429296
381	calcium phosphate	mineral	neutral	8	2026-05-10 02:15:20.305138
384	ethanol	preservative	caution	2	2026-05-11 06:34:18.087791
385	sodium hydroxide	preservative	caution	2	2026-05-11 06:34:18.278267
386	malt flour	thickener	neutral	6.5	2026-05-11 06:34:18.404106
388	acesulfame potassium and sucralose	sweetener	caution	4	2026-05-11 06:34:19.658692
392	vanilla flavor	natural flavor	neutral	8	2026-05-11 06:34:21.662786
395	mustard seeds	spice	healthy	8.5	2026-05-11 06:35:10.15857
399	sucralose	sweetener	caution	4.5	2026-05-11 06:35:24.929821
403	tartrazine	artificial color	caution	2.5	2026-05-11 06:35:35.576452
406	pomegranate juice	natural flavor	healthy	8.5	2026-05-11 06:36:37.56749
408	mango flavor	natural flavor	neutral	8	2026-05-11 06:37:04.248372
411	blueberry	fruit	healthy	9.5	2026-05-11 06:37:10.855191
414	paraffin oil	fat	caution	2.5	2026-05-11 06:37:25.223041
417	sunset yellow fcf	artificial color	caution	2.5	2026-05-11 06:37:33.561325
419	cinnamaldehyde	natural flavor	caution	6.5	2026-05-11 06:37:42.299797
422	dutch processed cocoa	flavor	neutral	8	2026-05-11 06:38:19.364875
426	sulfite	preservative	caution	4	2026-05-11 06:39:03.606255
428	erythrosine	artificial color	caution	2.5	2026-05-11 06:39:32.760403
432	carbonation	preservative	neutral	5	2026-05-11 06:39:55.770449
435	rubus idaeus	fruit	healthy	9.5	2026-05-11 06:40:08.523913
436	sodium chloride and citrus aurantifolia	preservative	neutral	5	2026-05-11 06:40:21.128676
442	goat milk	dairy	healthy	8.5	2026-05-11 06:41:16.74644
445	skim milk powder	protein	healthy	8.5	2026-05-11 06:41:41.787859
788	pear	fruit	healthy	9	2026-05-11 22:02:34.04441
447	mixed fruit juice with glucose-fructose syrup	sweetener	caution	4.2	2026-05-11 06:41:54.419232
452	caramel	sweetener	caution	4.2	2026-05-11 06:42:28.331381
455	edta	preservative	caution	2.5	2026-05-11 06:42:38.546575
458	peppermint oil	natural flavor	healthy	8.5	2026-05-11 06:42:46.933731
460	menthol	natural flavor	caution	6.5	2026-05-11 06:42:51.247827
468	thiamine	vitamin	healthy	9.5	2026-05-11 06:43:44.723473
471	invert sugar	sweetener	caution	4.2	2026-05-11 06:44:14.279251
474	sweet whey powder	protein	healthy	8.5	2026-05-11 06:44:28.955319
477	sodium citrate	preservative	neutral	8	2026-05-11 06:44:45.574494
482	clams	protein	healthy	8.5	2026-05-11 06:45:28.820344
485	piperine	spice	healthy	8.5	2026-05-11 06:45:35.053266
488	herbs	spice	healthy	9	2026-05-11 06:45:57.886986
490	potassium benzoate	preservative	caution	4.2	2026-05-11 06:46:03.95931
493	pantothenic acid	vitamin	healthy	9.5	2026-05-11 06:46:14.337596
495	glycerol ester of wood resin	thickener	caution	4.2	2026-05-11 06:46:22.518749
499	peach juice	natural flavor	healthy	8.5	2026-05-11 06:46:39.357644
502	beeswax	thickener	neutral	6.5	2026-05-11 06:46:58.169659
505	portobello mushrooms	fiber	healthy	9	2026-05-11 06:47:30.015618
509	pork casing	protein	neutral	6.5	2026-05-11 06:47:42.329217
512	sodium carbonate	mineral	caution	4.2	2026-05-11 06:48:09.481911
515	sodium saccharin and acesulfame potassium	sweetener	caution	4	2026-05-11 06:48:36.310797
519	potato starch	thickener	neutral	6.5	2026-05-11 06:48:50.599637
795	artificial colors	artificial color	caution	2	2026-05-11 22:03:16.089008
523	sweetened condensed milk	dairy	caution	4.2	2026-05-11 06:49:36.17729
525	vitamin b6	vitamin	healthy	9.5	2026-05-11 06:50:27.036076
528	potassium sorbate, sodium bisulfite and xanthan gum	preservative, thickener	caution	6	2026-05-11 06:50:41.75994
532	lactococcus lactis	probiotic	healthy	9	2026-05-11 06:51:06.910492
535	lactobacillus	probiotic	healthy	9	2026-05-11 06:51:19.38737
538	sodium nitrite; caramel	preservative	caution	2	2026-05-11 06:51:40.250828
542	arachis oil	fat	neutral	6.5	2026-05-11 06:52:13.724118
546	disodium diphosphate	preservative	caution	4.2	2026-05-11 06:53:07.25719
549	artificial sweetener	sweetener	caution	4	2026-05-11 06:53:21.995188
553	grapefruit juice	natural flavor	healthy	8.5	2026-05-11 06:54:14.40465
556	sodium phosphate	preservative	caution	4.2	2026-05-11 06:54:24.887475
560	garden peas	fiber	healthy	9.5	2026-05-11 06:54:56.171982
562	vitamin a	vitamin	healthy	9.5	2026-05-11 06:55:04.504434
566	pea fibre	fiber	healthy	9	2026-05-11 18:41:12.314166
569	potash	mineral	neutral	5	2026-05-11 18:41:15.998496
572	vitamins a and d	vitamin	healthy	9.5	2026-05-11 18:41:26.932127
576	sorbitan tristearate and soy lecithin	emulsifier	neutral	6.5	2026-05-11 18:42:26.323173
580	phosphate and carrageenan	thickener	caution	4	2026-05-11 18:43:25.761923
584	egg albumen	protein	healthy	9	2026-05-11 18:44:03.612712
586	sorbitan esters	emulsifier	caution	4.5	2026-05-11 18:44:41.781382
588	nonanoyl para-aminobenzoic acid	preservative	caution	4.2	2026-05-11 18:45:10.90311
593	food dye	artificial color	caution	2.5	2026-05-11 18:46:28.586248
597	confectioner's glaze	coating	caution	2.5	2026-05-11 18:47:53.289003
599	partially hydrogenated soybean oil	fat	caution	2.5	2026-05-11 18:48:05.205249
603	glycerin	humectant	neutral	6.5	2026-05-11 18:48:32.124407
606	lady's fingers	vegetable	healthy	8.5	2026-05-11 18:49:04.252921
609	coconut sugar	sweetener	neutral	6.5	2026-05-11 18:50:30.920242
613	polysorbate 80	emulsifier	caution	4.2	2026-05-11 18:51:18.93093
615	tartrazine and maltol	artificial color	caution	2.5	2026-05-11 18:51:38.889418
618	smoked jalapeno pepper	spice	healthy	8.5	2026-05-11 19:04:37.405076
622	tartrazine and sunset yellow	artificial color	caution	2.5	2026-05-11 19:45:28.987569
625	liver	protein	healthy	8.5	2026-05-11 21:09:23.730253
628	salt, wheat flour	mineral	caution	4	2026-05-11 21:09:25.699759
630	monosodium glutamate	flavor enhancer	caution	4.2	2026-05-11 21:09:26.952023
635	barley malt	sweetener	neutral	6.5	2026-05-11 21:25:50.114375
637	artificial flavour	natural flavor	caution	4	2026-05-11 21:25:55.147346
640	casein	protein	neutral	6.5	2026-05-11 21:25:59.763889
643	artificial flavor	natural flavor	caution	4	2026-05-11 21:26:20.847319
646	dicalcium phosphate	mineral	neutral	8	2026-05-11 21:26:31.284558
648	artificial color	artificial color	caution	2	2026-05-11 21:26:36.520595
651	chocolate milk	beverage	neutral	6.5	2026-05-11 21:27:03.558825
653	artificial flavouring	natural flavor	caution	4	2026-05-11 21:27:22.632021
657	caramel sweetened condensed skim milk	sweetener	caution	4.2	2026-05-11 21:29:14.464999
662	wheat starch	thickener	neutral	6.5	2026-05-11 21:30:52.138674
665	lychee juice	natural flavor	healthy	8.5	2026-05-11 21:31:29.851482
667	chickpea flour	fiber	healthy	8.5	2026-05-11 21:31:58.022939
672	magnesium stearate	antioxidant	neutral	8	2026-05-11 21:32:36.004484
675	lychee	fruit	healthy	8.5	2026-05-11 21:32:54.36755
677	red 40	artificial color	caution	2.5	2026-05-11 21:33:00.589676
681	isomalt	sweetener	caution	4.5	2026-05-11 21:34:17.310723
684	dried lemon juice	natural flavor	healthy	8.5	2026-05-11 21:34:20.912427
687	palm oil and shea nut oil	fat	caution	4.5	2026-05-11 21:37:46.707559
694	shea nut	fat	healthy	8.5	2026-05-11 21:38:30.157884
698	baker's yeast	microorganism	healthy	9	2026-05-11 21:48:39.949677
701	arborio rice	starch	neutral	6.5	2026-05-11 21:48:45.669829
704	lard	fat	caution	4.2	2026-05-11 21:48:48.031483
706	celery extract	natural flavor	healthy	8.5	2026-05-11 21:48:48.752668
709	chili peppers	spice	healthy	8.5	2026-05-11 21:49:05.000227
713	protein	protein	healthy	9	2026-05-11 21:50:18.191934
715	aluminum phosphate	anti-caking agent	caution	4.2	2026-05-11 21:50:25.819342
718	microbial rennet	enzyme	neutral	8	2026-05-11 21:50:58.232328
720	butylated hydroxyanisole	preservative	caution	2.5	2026-05-11 21:51:13.356347
724	rice water	natural ingredient	healthy	8.5	2026-05-11 21:51:33.087897
727	folic acid	vitamin	healthy	9.5	2026-05-11 21:51:45.775409
729	mono- and diglycerides	emulsifier	caution	4.5	2026-05-11 21:51:59.2441
733	walnut	nut	healthy	8.5	2026-05-11 21:52:48.387787
735	cultured milk	protein	healthy	8.5	2026-05-11 21:53:19.192341
1197	milkfat	fat	neutral	6.5	2026-05-12 00:31:27.194975
738	dried apple	fruit	healthy	8.5	2026-05-11 21:53:30.142151
741	peanut oil	fat	neutral	6.5	2026-05-11 21:53:47.562744
743	methylcellulose	thickener	neutral	8	2026-05-11 21:54:25.667336
746	modified food starch	thickener	neutral	5	2026-05-11 21:54:57.815341
748	raspberry juice concentrate	natural flavor	healthy	8.5	2026-05-11 21:55:14.823045
753	macadamia nut	nut	healthy	8.5	2026-05-11 21:56:07.989566
758	petal	natural flavor	healthy	8	2026-05-11 21:57:07.750964
760	brewer's yeast extract	natural flavor	neutral	6.5	2026-05-11 21:57:58.812869
766	cranberry juice	natural flavor	healthy	8.5	2026-05-11 21:59:26.175882
769	wood rosin ester	thickener	caution	4.2	2026-05-11 21:59:34.720761
773	apocarotenal	artificial color	caution	2.5	2026-05-11 22:00:21.403574
776	red 40 & blue 1	artificial color	caution	2.5	2026-05-11 22:00:30.075549
779	dipotassium phosphate	preservative	caution	4.2	2026-05-11 22:00:47.871193
783	carob bean gum	thickener	neutral	8	2026-05-11 22:01:51.631747
786	tartrazine and sunset yellow fcf	artificial color	caution	2.5	2026-05-11 22:02:11.432266
790	vegetable shortening	fat	caution	4.2	2026-05-11 22:02:50.425584
794	yellow 6	artificial color	caution	2.5	2026-05-11 22:03:13.555627
796	egg yolk	protein	neutral	6.5	2026-05-11 22:03:24.980675
799	red 40 and blue 1	artificial color	caution	2.5	2026-05-11 22:03:47.013852
802	whole wheat	fiber	healthy	8.5	2026-05-11 22:04:13.613865
803	potassium sorbate and sodium benzoate	preservative	caution	4	2026-05-11 22:04:32.136892
216	peanut free nut butter	nut butter	healthy	8	2026-05-10 01:28:01.246231
402	preservatives	preservative	caution	2	2026-05-11 06:35:33.475345
464	sugar syrup and salt	sweetener	caution	3	2026-05-11 06:43:20.993879
522	milk and caramel with glucose-fructose syrup	sweetener	caution	4	2026-05-11 06:49:33.935896
565	citric acid and sunflower oil	{preservative,oil}	healthy	8	2026-05-11 18:41:09.763087
595	salt and vanilla and pretzels enriched wheat flour	{salt,spice,"natural flavor",carbohydrate}	neutral	7.5	2026-05-11 18:47:24.386523
633	sodium chloride solution with sweetened rice wine	preservative	caution	2.5	2026-05-11 21:09:34.641265
693	sugar vegetable oils palm and sunflower	sweetener	caution	2.5	2026-05-11 21:38:24.92167
761	herbs and spices	spice	healthy	9.5	2026-05-11 21:58:10.505027
685	powder	spice	neutral	5	2026-05-11 21:37:39.288289
807	applesauce	fruit puree	healthy	8	2026-05-11 22:05:04.09059
810	crab extract	natural flavor	neutral	6.5	2026-05-11 22:05:15.620616
813	pasteurized milk and cream	dairy product	healthy	8.5	2026-05-11 22:05:31.121733
816	enriched flour	grain	neutral	4.5	2026-05-11 22:05:42.746006
820	sodium tripolyphosphate	preservative	caution	2	2026-05-11 22:06:06.43132
823	holy basil	herb	healthy	8.5	2026-05-11 22:06:30.808842
825	sarsaparilla	natural flavor	neutral	5	2026-05-11 22:06:35.95648
828	curcuma longa	spice	healthy	9.5	2026-05-11 22:06:41.959861
831	asiago	cheese	neutral	6	2026-05-11 22:07:09.362324
834	spices	spice	neutral	8	2026-05-11 22:07:25.239063
836	capsicum annuum	spice	healthy	8	2026-05-11 22:07:34.254755
839	inactive dry yeast	yeast	neutral	6.5	2026-05-11 22:08:08.370859
843	calcium disodium edta	preservative	caution	2.5	2026-05-11 22:08:28.840959
845	citrus sinensis	fruit	healthy	9.5	2026-05-11 22:08:45.621098
849	red 3	artificial color	caution	2	2026-05-11 22:09:17.513343
852	fd&c blue #1	artificial color	caution	2	2026-05-11 22:09:34.473066
854	sorbic acid	preservative	caution	2	2026-05-11 22:09:53.867849
857	calcium lactate	preservative	healthy	8.5	2026-05-11 22:10:22.273663
860	pineapple essence	natural flavor	healthy	6	2026-05-11 22:10:33.439015
862	tapioca dextrin	thickener	neutral	6.5	2026-05-11 22:10:57.235113
864	sodium aluminum phosphate	preservative	caution	2.5	2026-05-11 22:11:45.873004
868	green mung bean	legume	healthy	8.5	2026-05-11 22:12:56.758127
871	cane syrup	sweetener	neutral	2	2026-05-11 22:13:04.976122
874	coconut milk or other plant-based creamer	plant-based milk	healthy	7.5	2026-05-11 23:29:38.56464
876	coconut milk or almond milk or oat milk or soy milk or rice milk or cashew milk or hazelnut milk or other plant-based creamer	dairy alternative	healthy	8.5	2026-05-11 23:29:41.157231
883	dextrose anhydrous equivalent of maltose	sweetener	neutral	5	2026-05-11 23:29:45.811137
886	bakingsoda	leavening agent	neutral	6	2026-05-11 23:29:57.613623
889	leavening agent	leavening agent	neutral	6	2026-05-11 23:30:17.152662
892	pasteurized butter	fat	neutral	7.5	2026-05-11 23:30:57.268122
895	flavours	natural flavor	neutral	5	2026-05-11 23:31:16.817628
898	crab and lobster extract	natural flavor	neutral	6.5	2026-05-11 23:31:22.467576
901	nopales	vegetable	healthy	8.5	2026-05-11 23:31:37.086594
904	potassium citrate	preservative	healthy	8.5	2026-05-11 23:31:46.79769
907	powdered sugar	sweetener	neutral	2	2026-05-11 23:32:02.269981
910	lemon oil	natural flavor	healthy	8.5	2026-05-11 23:32:33.138663
912	calcium iodate	preservative	caution	2.5	2026-05-11 23:32:46.486601
915	ammonium sulfate	preservative	caution	2	2026-05-11 23:33:17.638958
918	ammonium phosphate	preservative	caution	4.5	2026-05-11 23:33:35.082847
921	monoglycerides	emulsifier	neutral	5	2026-05-11 23:34:03.541226
924	calcium sulfate	preservative	caution	2.5	2026-05-11 23:34:14.134013
928	calcium stearate and silicon dioxide	emulsifier	caution	2	2026-05-11 23:34:47.304904
932	dill seed	spice	healthy	8.5	2026-05-11 23:35:06.934126
933	dill extract	natural flavor	healthy	8.5	2026-05-11 23:35:12.722661
936	partially hydrogenated vegetable oils coconut	fat	caution	2	2026-05-11 23:35:36.12895
939	propylene glycol esters	emulsifier	caution	2	2026-05-11 23:35:51.097151
942	sweetened condensed skim milk	dairy	neutral	4.5	2026-05-11 23:36:54.731559
946	red wine	alcohol	caution	4.5	2026-05-11 23:37:20.644487
948	ester gum	thickener	neutral	5	2026-05-11 23:37:36.50825
951	l-cysteine	amino acid	neutral	2	2026-05-11 23:38:13.816589
953	beta-apo-8-carotenal	color	caution	0.5	2026-05-11 23:38:56.774971
956	extractives of turmeric	natural flavor	neutral	5	2026-05-11 23:39:54.832808
959	textured vegetable protein (soy flour)	protein	neutral	6.5	2026-05-11 23:40:34.884656
964	corn gluten hydrolysate	protein	caution	2.5	2026-05-11 23:41:18.1698
966	calcium propionate and sorbic acid	preservative	caution	2	2026-05-11 23:41:39.874406
973	fontina and provolone cheese cultured part-skim milk	dairy product	neutral	2	2026-05-11 23:44:15.410566
977	blue 2 lake	artificial color	avoid	0	2026-05-11 23:45:21.856254
980	bvo	preservative	caution	2	2026-05-11 23:46:25.069573
982	reverse osmosis water	water	healthy	10	2026-05-11 23:46:29.918104
985	monopotassium phosphate	preservative	neutral	6	2026-05-11 23:46:40.43819
988	potassium metabisulfite	preservative	caution	2	2026-05-11 23:48:01.324496
991	soybean with tbhq	preservative	caution	2	2026-05-11 23:48:24.500564
995	nature identical	natural flavor	neutral	8	2026-05-11 23:51:24.483156
999	enriched rice	grain	neutral	7	2026-05-11 23:51:47.344801
1002	disodium inosinate	preservative	caution	4.5	2026-05-11 23:51:54.455439
1005	disodium guanylate	preservative	caution	3	2026-05-11 23:52:43.057005
1008	natamycin	preservative	caution	2	2026-05-11 23:53:17.826661
1010	calcium silicate	preservative	caution	2	2026-05-11 23:53:40.160358
1014	calcium caseinate	emulsifier	neutral	2.5	2026-05-11 23:55:06.397166
1017	medium chain fatty acids	fat	neutral	7.5	2026-05-11 23:55:09.361824
1021	egg whites	protein	healthy	9.5	2026-05-11 23:55:32.992927
1023	dried sweetener	sweetener	caution	2.5	2026-05-11 23:55:47.857654
1026	oatmeal	grain	healthy	8	2026-05-11 23:56:12.885235
1028	golden raisins	dried fruit	healthy	8.5	2026-05-11 23:56:30.676272
1032	passion fruit	fruit	healthy	8.5	2026-05-11 23:57:23.855194
1035	disodium inosinate and disodium 5'-inosinate	flavor enhancer	caution	2	2026-05-11 23:57:52.087384
1038	sun-dried tomato	vegetable	healthy	8	2026-05-11 23:58:33.355953
1040	curcuminoids and capsanthin	antioxidant	healthy	9.5	2026-05-11 23:58:52.2276
1044	green beans	vegetable	healthy	9.5	2026-05-11 23:59:13.911094
1046	blue cheese whey	dairy byproduct	neutral	4.5	2026-05-11 23:59:44.536361
1050	moisture	moisture content	neutral	5	2026-05-12 00:01:09.750567
1052	azodicarbonamide	preservative	caution	2.5	2026-05-12 00:01:28.280121
1055	monodiglycerides	emulsifier	caution	4.5	2026-05-12 00:02:32.653089
1058	celery seed oil	oil	neutral	8.5	2026-05-12 00:04:03.291726
1061	adipic acid	preservative	caution	2.5	2026-05-12 00:04:20.343627
1063	microbial enzymes	preservative	neutral	6.5	2026-05-12 00:04:29.864732
1066	aluminium phosphate	preservative	caution	2	2026-05-12 00:05:27.495495
1067	mono- and di-glycerides	emulsifier	neutral	2	2026-05-12 00:05:42.811131
1070	allium ampeloprasum	vegetable	healthy	8.5	2026-05-12 00:06:09.989502
1073	heavy whipping cream	dairy product	neutral	2	2026-05-12 00:06:30.335034
1076	polysorbate	emulsifier	caution	4.5	2026-05-12 00:07:26.347817
1079	sulfuric acid	preservative	avoid	0	2026-05-12 00:08:18.501154
1081	calcium peroxide	preservative	caution	2	2026-05-12 00:08:59.522234
1085	thiamin	vitamin	healthy	8.5	2026-05-12 00:09:53.094327
1087	annatto and turmeric extract	natural color	neutral	6.5	2026-05-12 00:10:17.019127
1090	annatto & turmeric extract	natural color	neutral	5	2026-05-12 00:10:27.148345
1095	turkey	protein	healthy	8.5	2026-05-12 00:11:16.016398
1098	onion and garlic powder is not a standard ingredient name, however, it can be broken down into 'onion powder' and 'garlic powder'.	spice	neutral	7.5	2026-05-12 00:11:35.290842
1106	cheese culture	preservative	neutral	8	2026-05-12 00:12:47.617723
1108	part-skim milk is not a standard ingredient name, however, the canonical name for the ingredient 'milk' is 'milk'. the canonical name for 'swiss cheese' is 'swiss cheese'.	dairy	healthy	8	2026-05-12 00:13:08.046043
1117	garbanzo beans	protein	healthy	8.5	2026-05-12 00:15:37.698422
1120	orange blossom honey	sweetener	healthy	8.5	2026-05-12 00:16:07.507801
1124	tomato solids	fruit/vegetable	healthy	8.5	2026-05-12 00:16:25.089654
1127	emulsifier blend	emulsifier	neutral	5	2026-05-12 00:17:02.068136
1129	soybean and/or canola oil	oil	neutral	8.5	2026-05-12 00:17:14.318584
1133	monosodium 5'-inosinate and monosodium 5'-guanylate	flavor enhancer	caution	2	2026-05-12 00:18:32.219211
1137	rice bran water	natural flavor	healthy	8	2026-05-12 00:18:47.883909
1141	blackberries	fruit	healthy	9.5	2026-05-12 00:19:15.283475
1144	celery juice	vegetable	healthy	8.5	2026-05-12 00:19:59.95451
1147	chicken meat	protein	healthy	8.5	2026-05-12 00:20:11.332629
1150	chickpea	protein	healthy	8.5	2026-05-12 00:20:22.44455
1154	rice starch	thickener	neutral	8	2026-05-12 00:21:10.78449
1156	chicken breast with rib meat	protein	healthy	9.5	2026-05-12 00:21:27.952343
1161	rennet	enzyme	neutral	5	2026-05-12 00:22:29.894506
1163	cow's milk	dairy product	neutral	7.5	2026-05-12 00:22:30.337913
1165	partially hydrogenated soybean and cottonseed oil	fat	caution	4.5	2026-05-12 00:22:41.653854
1170	propylene glycol ester of fatty acids	emulsifier	caution	4	2026-05-12 00:23:33.732677
1174	palmitic acid	fat	caution	2	2026-05-12 00:24:27.752981
1176	potassium bitartrate citric acid ascorbic acid	preservative	neutral	6	2026-05-12 00:25:11.059839
1178	acidic sodium aluminum phosphate is not a standard name, but it is commonly referred to as 'acidic sodium phosphate' or 'acidic sodium aluminum phosphate is a complex of acidic sodium phosphate and aluminum sulfate, however, the standard name for the complex is not widely recognized. however, the standard name for 'sodium aluminum phosphate' is 'sodium aluminum phosphate' and for 'aluminum sulfate' is 'aluminum sulfate'.	preservative	caution	2.5	2026-05-12 00:25:25.387898
1187	vitamin a palmitate and vitamin d3	vitamin	neutral	8	2026-05-12 00:27:23.350445
1192	peach puree	fruit puree	healthy	8.5	2026-05-12 00:28:57.49289
1195	potassium acid sulfate	preservative	caution	4	2026-05-12 00:30:00.399651
1199	milk protein concentrate	protein	healthy	8.5	2026-05-12 00:31:49.150953
1202	potassium sulfate	preservative	caution	2	2026-05-12 00:32:46.375307
1206	reduced fat cheddar	dairy product	neutral	6.5	2026-05-12 00:33:16.702344
1208	pasteurized milk cheese	dairy product	healthy	8.5	2026-05-12 00:33:30.648234
1213	potassium starch	thickener	neutral	6.5	2026-05-12 00:35:22.835485
1216	active dry yeast	yeast	healthy	9	2026-05-12 00:36:00.255643
1219	hydrolysate	protein	neutral	5	2026-05-12 00:36:55.091071
1222	annatto and turmeric extractives color	artificial color	neutral	5	2026-05-12 00:37:46.029341
1226	mango puree	fruit puree	healthy	8.5	2026-05-12 00:40:05.411197
1229	cassava	starch	neutral	4.5	2026-05-12 00:40:37.906019
1232	beet juice extract and turmeric for color	natural color	neutral	8	2026-05-12 00:41:33.374217
1235	mono- and diglycerides: guar gum	emulsifier	caution	4	2026-05-12 00:41:54.734879
1241	potassium acetate	preservative	caution	4.5	2026-05-12 00:44:13.665397
1244	bison meat	protein	healthy	9	2026-05-12 00:44:51.158515
1247	bison sirloin	protein	healthy	8.5	2026-05-12 00:44:58.76876
1250	green chili	spice	healthy	8.5	2026-05-12 00:46:19.000586
1252	modified tapioca starch and corn starch	thickener	neutral	8	2026-05-12 00:46:32.019444
1255	hard-cooked eggs	protein	healthy	8.5	2026-05-12 00:47:51.462106
1259	bacterial culture	preservative	neutral	5	2026-05-12 00:48:21.17581
1261	garlic extract	natural flavor	healthy	8	2026-05-12 00:49:39.635344
1266	cultured milk solids	protein	healthy	8	2026-05-12 00:50:04.00676
1269	woodsmoke flavor	natural flavor	neutral	5	2026-05-12 00:50:38.216467
1272	modified cheese milk	dairy	neutral	7	2026-05-12 00:51:07.097896
1275	sodium hexametaphosphate	preservative	caution	4	2026-05-12 00:51:19.825745
1278	chicken flavour	natural flavor	neutral	6.5	2026-05-12 00:51:58.076774
1282	swiss cheese	dairy	neutral	6.5	2026-05-12 00:52:41.681415
1285	green chili pepper	vegetable	healthy	9	2026-05-12 00:53:21.967212
1289	sodium bisulfite	preservative	caution	2.5	2026-05-12 00:53:45.348236
1292	hydrolyzed protein	protein	neutral	6	2026-05-12 00:54:17.964857
1295	spice extractives	spice	neutral	6.5	2026-05-12 00:55:12.356458
1296	monosodium inosinate and monosodium guanylate	flavor enhancer	caution	2	2026-05-12 00:55:41.901256
1301	cultured buttermilk	dairy product	healthy	8.5	2026-05-12 00:57:48.425885
1304	tetrasodium phosphate	preservative	neutral	4	2026-05-12 00:59:23.136748
1308	propylene glycol alginate	thickener	caution	2.5	2026-05-12 00:59:47.2697
1311	sodium aluminosilicate	preservative	caution	2	2026-05-12 01:00:15.08807
1316	black-eyed peas	vegetable	healthy	8.5	2026-05-12 01:01:19.600243
1317	white beans	legume	healthy	8.5	2026-05-12 01:01:33.715765
1318	red beans	legume	healthy	8.5	2026-05-12 01:01:39.134505
1321	propyl gallate	preservative	caution	2	2026-05-12 01:02:19.444179
1323	garlic and onion. contains 2% or less of caramel color sodium sulfite to promote color retention	spice	healthy	9	2026-05-12 01:02:49.874721
1330	carboxymethyl cellulose	thickener	neutral	6	2026-05-12 01:13:19.612708
1333	mandarin orange juice	fruit juice	healthy	9.5	2026-05-12 01:22:03.875442
1336	autolyzed yeast	preservative	caution	2	2026-05-12 05:31:17.104524
1339	carrot extract	natural flavor	healthy	8.5	2026-05-12 05:31:23.00586
1344	fresno pepper	spice	healthy	8.5	2026-05-12 05:32:58.016056
1346	fire roasted tomatoes	vegetable	healthy	9.5	2026-05-12 05:33:15.308127
1350	pink peppercorns	spice	healthy	8.5	2026-05-12 05:33:49.472751
1354	cured bacon	meat	caution	2.5	2026-05-12 05:35:43.815107
1357	zinc oxide and reduced iron	{mineral,mineral}	neutral	5	2026-05-12 05:36:53.235428
1360	malt syrup	sweetener	neutral	2.5	2026-05-12 05:38:05.326405
1362	fontina cheese	dairy	healthy	8.5	2026-05-12 05:38:17.387772
1365	green chile pepper	vegetable	healthy	9.5	2026-05-12 05:39:24.226227
1368	nitrite	preservative	caution	2	2026-05-12 05:39:52.530616
1370	sugar snap peas	vegetable	healthy	9.5	2026-05-12 05:40:36.808245
1373	mustard water	natural flavor	neutral	5	2026-05-12 05:41:08.078119
1377	mechanically recovered chicken meat	meat	caution	2.5	2026-05-12 05:41:54.116395
1380	chicken breast meat	protein	healthy	9.5	2026-05-12 05:43:54.866321
1383	mesquite smoke flavor	natural flavor	neutral	4.5	2026-05-12 05:44:43.438478
1387	hexane	solvent	avoid	0	2026-05-12 05:45:52.549037
1390	lactobacillus bulgaricus	probiotic	healthy	8.5	2026-05-12 05:46:27.854406
1393	turnip	vegetable	healthy	8.5	2026-05-12 05:46:39.398281
1395	zinc chloride	preservative	caution	2.5	2026-05-12 05:46:49.285676
1398	calcium chlorite	preservative	caution	2	2026-05-12 05:46:59.266704
1400	mechanically recovered chicken	protein	neutral	5.5	2026-05-12 05:47:30.268782
1404	mixed tocopherols and bht	preservative	caution	4.5	2026-05-12 05:48:31.272728
1408	onion and garlic powder	spice	healthy	8.5	2026-05-12 05:50:07.285841
1411	parboiled rice	grain	healthy	8.2	2026-05-12 05:50:36.188778
1415	thiamine mononitrate and folic acid	vitamin	healthy	9.5	2026-05-12 05:51:28.736073
1418	p. roquefortii	microorganism	caution	5	2026-05-12 06:00:08.295754
1420	yellowfin tuna	protein	healthy	8	2026-05-12 06:04:23.627054
1423	avocado powder	natural flavor	healthy	8.5	2026-05-12 06:15:01.636376
1426	ginseng	herb	healthy	8.5	2026-05-12 06:22:15.512579
1429	chloride	mineral	neutral	5	2026-05-12 06:26:13.696895
1432	copper(ii) sulfate	preservative	caution	2	2026-05-12 06:31:31.887325
1435	and/or sunflower seed oil	oil	healthy	8.5	2026-05-12 06:48:13.396943
1438	aluminum	preservative	caution	2	2026-05-12 07:01:24.729938
1442	concentrated juice	sweetener	neutral	3.2	2026-05-12 07:01:27.200088
1444	glucono delta-lactone	preservative	caution	6	2026-05-12 07:01:28.317625
1448	blackberry leaf and rosehips	herb	healthy	8.5	2026-05-12 07:12:44.774695
1450	sodium and/or calcium stearoyl lactylate	emulsifier	neutral	6	2026-05-12 07:14:42.229223
1453	dehydrated garlic and onion	herb	healthy	8.5	2026-05-12 18:25:48.452409
1454	potassium sorbate and citric acid and tbhq preservatives	preservative	caution	4	2026-05-12 18:25:49.980509
1460	tallow and/or soybean oil	fat	neutral	6	2026-05-12 18:26:24.963363
1463	strawberry gelatin	gelling agent	caution	2	2026-05-12 18:27:17.781687
1466	almond flavor	natural flavor	neutral	6	2026-05-12 18:27:44.833073
1468	citric acid and sodium propionate and potassium sorbate preservatives	preservative	caution	2	2026-05-12 18:28:33.812517
1476	green olives	vegetable	healthy	8.5	2026-05-12 18:29:47.698176
1479	olive water	natural flavor	healthy	8	2026-05-12 18:30:01.946164
1480	sodium citrate and disodium phosphate	preservative	caution	4.5	2026-05-12 18:30:11.772838
1484	bean sprouts	vegetable	healthy	8	2026-05-12 18:30:33.466319
1487	carmine	artificial color	avoid	0	2026-05-12 18:30:55.047328
1489	banana puree	fruit	healthy	8.5	2026-05-12 18:31:19.087684
1493	potassium sorbate and tbho (tert-butylhydroquinone) preservatives	{preservative,preservative}	neutral	5	2026-05-12 18:32:09.186025
1497	thiamine mononitrate -> thiamine, pyridoxine hydrochloride -> vitamin b6	vitamin	healthy	8.5	2026-05-12 18:34:25.461399
1504	bergamot oil	natural flavor	healthy	8.5	2026-05-12 18:35:21.31283
1507	licorice root extract	natural flavor	caution	6.5	2026-05-12 18:35:28.36862
1511	vegetable mono and diglycerides	emulsifier	neutral	5	2026-05-12 18:36:26.014235
1515	puffed rice	grain	neutral	5	2026-05-12 18:37:37.34473
1517	mechanically separated chicken	meat	caution	2	2026-05-12 18:38:17.389194
1521	succinic acid	preservative	caution	3	2026-05-12 18:39:28.610253
1524	sour cream and blue cheese flavor	natural flavor	neutral	5.5	2026-05-12 18:40:04.436959
1529	manioc	root vegetable	healthy	8.5	2026-05-12 18:41:16.829949
1532	textured vegetable protein	protein	healthy	7.5	2026-05-12 18:42:07.147844
1535	whole grain wheat flour	grain	healthy	9.5	2026-05-12 18:42:41.144734
1539	raisin	fruit	healthy	8.5	2026-05-12 18:44:32.096076
1541	anaheim pepper	spice	healthy	8.5	2026-05-12 18:44:58.682525
1544	banana pepper	vegetable	healthy	8.5	2026-05-12 18:45:18.164395
1549	ethyl acetate	preservative	caution	2	2026-05-12 18:46:04.930754
1552	artificial food coloring	artificial color	caution	2	2026-05-12 18:47:12.896192
1556	aloe	natural flavor	healthy	8	2026-05-12 18:47:51.957162
1559	modified tapioca starch	thickener	neutral	5	2026-05-12 18:48:25.250655
1563	guayusa	herb	healthy	8.5	2026-05-12 18:49:39.290112
1566	yumberry	fruit	healthy	8	2026-05-12 18:49:58.688894
1568	lime extract	natural flavor	healthy	8.5	2026-05-12 18:50:03.65095
1570	low-moisture mozzarella cheese	dairy	healthy	8.5	2026-05-12 18:50:23.038207
1574	mechanically separated poultry	meat	caution	2	2026-05-12 18:52:28.870743
1578	miso extract	natural flavor	neutral	6.5	2026-05-12 18:54:15.708488
1580	blood orange juice	juice	healthy	8.5	2026-05-12 18:55:09.432015
1583	lactococcus lactis subsp. lactis and lactococcus lactis subsp. cremoris	microorganism	neutral	5	2026-05-12 18:55:50.824174
1590	lycopene	vitamin	healthy	8.5	2026-05-12 18:58:51.034312
1594	edamame	vegetable	healthy	8.5	2026-05-12 18:59:36.309651
1597	palm oil and/or soybean oil with propylene glycol monoesters	emulsifier	caution	2.5	2026-05-12 19:00:29.274311
1602	red kidney bean	legume	healthy	8.5	2026-05-12 19:01:49.268041
1605	green split pea	vegetable	healthy	8.5	2026-05-12 19:02:31.164508
1607	pineapple and peach juice concentrate	juice concentrate	healthy	8.5	2026-05-12 19:03:08.500027
1612	mixed tocopherols	antioxidant	healthy	9.5	2026-05-12 19:04:21.217909
781	naturally occurring	natural substance	healthy	9	2026-05-11 22:01:41.126033
1016	potassium benzoate and potassium sorbate	preservative	caution	2	2026-05-11 23:55:09.028786
1240	calcium propionate and potassium sorbate	preservative	caution	4	2026-05-12 00:43:52.452599
1546	sodium benzoate and sodium metabisulfite	preservative	caution	2	2026-05-12 18:45:23.449546
1581	sodium pyrophosphate and sodium bisulfite and citric acid	preservative	caution	2	2026-05-12 18:55:19.15831
1616	jalapeno peppers	vegetable	neutral	8	2026-05-12 19:04:51.062528
1619	bell peppers	vegetable	healthy	8.5	2026-05-12 19:05:25.451464
1622	mushroom extract	natural flavor	healthy	8	2026-05-12 19:05:35.780964
1625	grana padano cheese	dairy	healthy	7.5	2026-05-12 19:05:53.147923
1628	green lentil	protein	healthy	8.5	2026-05-12 19:06:24.760646
1632	sweet cream	fat	healthy	8	2026-05-12 19:07:13.345019
1634	barolo wine	natural flavor	neutral	7.5	2026-05-12 19:08:01.651477
1637	color	artificial color	caution	2	2026-05-12 19:08:41.033518
1639	locust bean gum and guar gum	thickener	neutral	6	2026-05-12 19:08:55.496704
1642	iron phosphate	preservative	caution	2	2026-05-12 19:10:01.847843
1646	l-threonine	amino acid	healthy	9	2026-05-12 20:42:13.492267
1648	natrium	mineral	neutral	8	2026-05-12 20:42:35.70798
1650	chicken skin	protein	caution	2.5	2026-05-12 20:43:10.66988
1653	hydroxypropyl methylcellulose	thickener	neutral	5	2026-05-12 20:43:25.22781
1658	arabica coffee	natural flavor	healthy	8.5	2026-05-12 20:44:56.033185
1661	aspergillus	microorganism	caution	2.5	2026-05-12 20:45:41.339615
1663	emmer wheat	grain	healthy	8.5	2026-05-12 20:46:22.526736
1665	sucrose solution	sweetener	caution	2	2026-05-12 20:46:47.13756
1668	paprika extractives	natural flavor	neutral	5	2026-05-12 20:48:18.753985
1671	aji amarillo pepper	spice	healthy	8.5	2026-05-12 20:49:10.298212
1674	bonito	flavoring	neutral	3.5	2026-05-12 20:49:56.983891
1677	sundried tomato powder	natural flavor	healthy	8.5	2026-05-12 20:50:14.682289
1680	oyster extract	natural flavor	neutral	5	2026-05-12 20:50:31.978366
1683	quinoa flour	grain	healthy	8.5	2026-05-12 20:51:48.66736
1685	concentrated grape juice	sweetener	neutral	6.2	2026-05-12 20:52:03.007829
1689	fructooligosaccharides	sweetener	caution	6	2026-05-12 20:52:56.140778
1693	gum ghatti	natural sweetener	healthy	8.5	2026-05-12 20:53:41.426391
1695	riboflavin and folic acid	vitamin	healthy	9	2026-05-12 20:54:15.209033
1699	mango flavour	natural flavor	neutral	6.5	2026-05-12 20:55:49.486114
1703	cashew butter	nut butter	healthy	7.5	2026-05-12 20:57:41.286743
1705	vanilla ice cream skim milk	sweetener	neutral	2.5	2026-05-12 20:57:51.450612
1709	dried rice	grain	healthy	7.5	2026-05-12 20:59:06.777986
1711	raisin paste	sweetener	healthy	8	2026-05-12 21:00:16.826009
1713	disodium dihydrogen pyrophosphate	preservative	caution	3	2026-05-12 21:01:02.587589
1715	acesulfame potassium and sucralose non-nutritive sweeteners: acesulfame potassium and sucralose, sodium ascorbate: vitamin c	sweetener	caution	2	2026-05-12 21:02:00.70692
1722	mango extract	natural flavor	healthy	8.5	2026-05-12 21:09:52.161014
1725	skipjack tuna	protein	healthy	8.5	2026-05-12 21:12:46.235899
1727	pecorino romano cheese	dairy product	healthy	8.5	2026-05-12 23:26:44.033422
1730	pea starch	thickener	neutral	6	2026-05-12 23:26:45.010341
1733	oat and honey cluster sugar	sweetener	healthy	8	2026-05-12 23:27:31.294742
1737	acesulfame-k	sweetener	caution	6	2026-05-12 23:28:34.943934
1740	anthocyanins	antioxidant	healthy	8.5	2026-05-12 23:29:00.48037
1744	saffron	spice	neutral	7	2026-05-12 23:30:37.474621
1746	dried milk	dairy product	healthy	8	2026-05-12 23:30:44.578672
1749	arrowroot	thickener	healthy	8.5	2026-05-12 23:31:10.013069
1750	lactobacillus acidophilus and bifidobacterium bifidum	probiotic	healthy	9.5	2026-05-12 23:31:19.076713
1755	black sesame seed	seed	healthy	8.5	2026-05-12 23:32:19.234242
1759	gum acacia	gum	neutral	6.5	2026-05-12 23:34:22.671872
1761	jasmine green tea	herb	healthy	8.5	2026-05-12 23:35:09.47388
1764	dried cranberry	fruit	healthy	8.5	2026-05-12 23:35:19.080151
1768	lemon zest	natural flavor	healthy	8.5	2026-05-12 23:35:49.697983
1770	colorant	artificial color	caution	2	2026-05-12 23:37:41.424588
1773	potassium sorbate and sodium bisulfite	{preservative,preservative}	caution	2	2026-05-12 23:38:13.70347
1778	okra	vegetable	healthy	8.5	2026-05-12 23:40:49.874586
1780	green beans and red peppers	vegetable	healthy	8.5	2026-05-12 23:41:08.644401
1784	turmeric extract	spice	healthy	8	2026-05-12 23:42:52.708413
1787	sucrose monoglycerides	emulsifier	caution	2	2026-05-12 23:43:13.513214
1791	part-skim mozzarella cheese	dairy	healthy	8	2026-05-13 00:56:34.658009
1795	endive	vegetable	healthy	8	2026-05-13 00:57:04.233161
1798	mizuna	vegetable	healthy	8.5	2026-05-13 00:57:20.652789
1800	green chard	vegetable	healthy	9.5	2026-05-13 00:57:29.836747
1803	lamb's lettuce	leafy green	healthy	8.5	2026-05-13 00:57:39.48452
1806	lolla rosa	vegetable	healthy	8.5	2026-05-13 00:57:46.445508
1809	tannins	antioxidant	caution	7.5	2026-05-13 00:57:53.219741
1812	arugula	leafy green	healthy	8.5	2026-05-13 00:58:28.496767
1815	romaine lettuce	vegetable	healthy	9.5	2026-05-13 00:59:04.213191
1818	glaze	sweetener	caution	6	2026-05-13 00:59:43.190523
1821	parsnip	vegetable	healthy	8.5	2026-05-13 01:00:06.919464
1823	celery root	vegetable	healthy	9.5	2026-05-13 01:00:45.969518
1826	portobello mushroom	vegetable	healthy	9.5	2026-05-13 01:01:45.504332
1830	asadero cheese	dairy product	neutral	7.2	2026-05-13 01:02:59.886717
1834	calcium acetate	preservative	caution	4	2026-05-13 01:04:31.092904
1839	pectinase	enzyme	neutral	6	2026-05-13 01:05:50.527148
1842	smoked flavoring	natural flavor	neutral	5.5	2026-05-13 01:06:43.987074
1846	pork heart	meat	caution	2.5	2026-05-13 01:07:11.601458
1848	ground turkey	protein	healthy	8.5	2026-05-13 01:07:48.264128
1850	blue crab extract	natural flavor	neutral	8	2026-05-13 01:08:10.0021
1854	gruyère	dairy	neutral	7	2026-05-13 01:09:01.405049
1856	apo-carotenal	color	caution	2	2026-05-13 01:10:04.984567
1859	pepper jack cheese	dairy product	neutral	4.2	2026-05-13 01:12:01.626768
1862	lecithinated soy flour	protein	neutral	6.5	2026-05-13 01:13:07.446683
1864	lecithinated soy flour with buttermilk	protein	healthy	8.5	2026-05-13 01:13:17.762206
1868	cheddar cheese flavor	natural flavor	neutral	5	2026-05-13 01:14:26.051479
1871	artificial flavourings	natural flavor	neutral	5	2026-05-13 01:15:33.236157
1875	almond paste	nut	healthy	8.5	2026-05-13 01:16:53.493747
1879	strawberry puree	fruit puree	healthy	8.5	2026-05-13 01:18:03.187371
1881	apple and door county cherry juice concentrate	fruit juice	healthy	9.5	2026-05-13 01:18:22.450135
1886	tartrazine lake	artificial color	caution	2	2026-05-13 06:05:27.952825
1888	yellow lakes	artificial color	caution	2	2026-05-13 06:05:30.380825
1892	cranberry beans	legume	healthy	8.5	2026-05-13 06:06:15.195376
1893	yell is not a valid ingredient, but it seems you may be referring to 'yellow food dye' or 'saffron', however, the most common ingredient referred to as 'yell' is 'yellow mustard' or 'yellow mustard seed', but the most likely answer is 'turmeric'	spice	healthy	8.5	2026-05-13 06:06:31.519148
1905	cottonseed oil and soya oil	oil	neutral	7.5	2026-05-13 06:10:57.351922
1910	egg protein	protein	healthy	8.5	2026-05-13 06:13:32.98054
1912	gum tragacanth	thickener	caution	6	2026-05-13 06:14:21.073208
1915	habanero pepper	spice	healthy	9.5	2026-05-13 06:14:58.263287
1918	onion vinegar	preservative	neutral	5.5	2026-05-13 06:15:35.507959
1921	organic cane sugar	sweetener	caution	2.5	2026-05-13 06:16:03.201154
1924	cabbage juice	vegetable	healthy	9	2026-05-13 06:17:30.950259
1926	partially hydrogenated vegetable oils	fat	caution	2	2026-05-13 06:17:56.710595
1931	cooked chicken	protein	healthy	9.5	2026-05-13 06:19:24.424171
1934	garlic oil	oil	healthy	8.5	2026-05-13 06:19:58.256352
1938	pasteurized cow's milk	dairy	healthy	8	2026-05-13 06:22:35.254122
1941	glyceryl monostearate	emulsifier	neutral	5.5	2026-05-13 06:22:49.024472
1944	low fat milk	dairy product	healthy	8.5	2026-05-13 06:24:01.924088
1946	calcium pantothenate and biotin b vitamins	{vitamin}	healthy	9.5	2026-05-13 06:24:13.953797
1949	acesulfame potassium and caffeine	sweetener	caution	2	2026-05-13 06:24:56.059391
1953	huito	natural dye	neutral	5	2026-05-13 06:26:07.843054
1955	tert-butylhydroquinone	preservative	caution	4	2026-05-13 06:26:42.90787
1959	brazil nuts	nut	healthy	8.5	2026-05-13 06:28:26.344328
1961	animal rennet	enzyme	neutral	6	2026-05-13 06:28:40.069864
1964	sunflower oil and/or canola oil and salt	oil	healthy	8.5	2026-05-13 06:30:31.990376
1968	durum wheat	grain	healthy	9	2026-05-13 06:33:57.400872
2000	fruit and vegetable juice concentrates for color and calcium chloride. contains five live active cultures including s. theromphilus	natural color	healthy	8	2026-05-13 06:42:24.213412
2007	reduced-fat milk	dairy product	healthy	8	2026-05-13 06:44:17.418102
2010	monoester	emulsifier	neutral	4.5	2026-05-13 06:44:42.991566
2013	enzyme modified cheese cheddar cheese	protein	neutral	5	2026-05-13 06:45:19.991916
2016	enzyme-modified cheese cheddar	cheese	neutral	2.5	2026-05-13 06:45:59.287128
2021	dried red bell pepper	vegetable	healthy	9	2026-05-13 06:46:41.347205
2024	berries	fruit	healthy	9.5	2026-05-13 06:48:43.375842
2027	quinoa water	grain	healthy	9.5	2026-05-13 06:49:03.16191
2030	partially hydrogenated fat	fat	caution	2.5	2026-05-13 06:49:52.506279
2034	palm kernel oil and/or canola oil	oil	neutral	7	2026-05-13 06:50:20.919748
2039	cod	protein	healthy	8	2026-05-13 06:54:23.980606
2041	astaxanthin	antioxidant	healthy	9.5	2026-05-13 06:54:51.721752
2044	walleye	protein	healthy	8.5	2026-05-13 06:54:58.450231
2047	pistachio flavour water	natural flavor	neutral	5.5	2026-05-13 06:55:14.57269
2051	condensed milk	sweetener	caution	2.5	2026-05-13 06:56:01.133726
2053	pasteurized egg is often referred to as egg in food science, however the more specific term is pasteurized egg product, but in some contexts it is referred to as egg in food science, but more accurately it is referred to as egg product, however in this case we will use the term egg product	protein	neutral	7	2026-05-13 06:56:35.243371
2074	plum juice	juice	healthy	8	2026-05-13 07:05:47.253412
2077	dried apricots	fruit	healthy	8.5	2026-05-13 07:07:31.834948
2080	filberts	nut	healthy	9.5	2026-05-13 07:08:49.591508
2082	sodium benzoate and sodium bisulfite preservatives and lime oil	{preservative,"natural flavor"}	caution	2	2026-05-13 07:09:17.522413
2087	apple pectin	thickener	healthy	8.5	2026-05-13 07:12:17.900403
2089	nutritional yeast	nutritional supplement	healthy	9	2026-05-13 07:13:35.146245
2092	soybean oil and/or cottonseed oil	oil	neutral	8	2026-05-13 07:14:51.61107
2094	black currant juice	fruit juice	healthy	8.2	2026-05-13 07:15:29.117138
2095	benzoyl peroxide	preservative	caution	2	2026-05-13 07:15:45.250102
2098	shitake mushrooms	vegetable	healthy	8.5	2026-05-13 07:16:42.225266
2101	sardine protein	protein	healthy	9	2026-05-13 07:17:12.37279
2104	scallop extract	natural flavor	healthy	8.5	2026-05-13 07:17:28.952586
2108	gluten-free rice flour	grain	healthy	8	2026-05-13 07:17:56.634161
2111	jasmine	spice	neutral	6.5	2026-05-13 07:18:14.732431
2113	glutinous rice	grain	neutral	7.5	2026-05-13 07:18:31.091947
2116	fd & c yellow no. 5 and fd & c blue no. 1 mix	artificial color	caution	2	2026-05-13 07:19:05.188638
2121	water and sugar	sweetener	healthy	9.5	2026-05-13 07:20:03.579459
2124	squid	protein	neutral	5	2026-05-13 07:20:27.194623
2127	chestnut	nut	healthy	8	2026-05-13 07:20:45.969353
2131	threadfin bream fish paste	protein	healthy	9.5	2026-05-13 07:21:13.534171
2134	fish extract	natural flavor	neutral	6	2026-05-13 07:21:38.410623
2137	fish paste	preserved meat	caution	5	2026-05-13 07:21:54.328154
2139	onion and napa cabbage extract	natural flavor	healthy	9.2	2026-05-13 07:22:10.782803
2144	glycine	amino acid	healthy	8.5	2026-05-13 07:22:47.509956
2146	nori	vegetable	healthy	8.5	2026-05-13 07:22:52.054175
2149	fd&c blue no 1	artificial color	caution	2	2026-05-13 07:23:27.127297
2154	kidney bean paste	vegetable	healthy	8.5	2026-05-13 07:23:58.264882
2157	pork extract	meat extract	caution	4.5	2026-05-13 07:24:55.527159
2160	tartrazine and brilliant blue fcf	artificial color	caution	2	2026-05-13 07:26:29.730047
2163	2-ethyl-3-methylpyrazine	natural flavor	caution	3.5	2026-05-13 07:26:43.52021
2166	egg yolk powder	protein	healthy	8	2026-05-13 07:27:02.182426
2167	disodium inosinate and artificial flavor dried vegetables : dried green onion	flavor enhancer	caution	2.5	2026-05-13 07:27:20.834668
2175	soybean paste	protein	neutral	5.5	2026-05-13 07:28:44.885776
2178	grape flavor	natural flavor	neutral	5	2026-05-13 07:30:23.939686
2180	disodium 5'-inosinate	preservative	caution	2	2026-05-13 07:31:12.923539
2184	diatase	enzyme	neutral	5	2026-05-13 07:32:06.027632
2185	bifidobacterium animalis subsp. lactis	probiotic	healthy	8.5	2026-05-13 07:32:24.307068
2190	grapefruit peel	spice	healthy	8.5	2026-05-13 07:35:01.660377
2193	tartrazine and allura red	artificial color	caution	2.5	2026-05-13 07:35:22.11524
2195	palm oil and/or soybean oil with emulsifier propylene glycol	fat	caution	2.5	2026-05-13 07:36:05.497179
2205	benzyl benzoate	preservative	caution	2	2026-05-13 07:40:59.996265
2207	tripotassium phosphate	preservative	neutral	6	2026-05-13 07:42:11.774119
2211	iron and folic acid	mineral	healthy	8	2026-05-13 08:10:34.523655
2214	extra virgin olive oil	fat	healthy	9.5	2026-05-13 08:11:21.521519
2217	ripening agent	preservative	caution	2.5	2026-05-13 08:12:04.27853
2218	and/or soybean with tbhq and citric acid as preservatives	preservative	caution	2	2026-05-13 08:12:26.420458
2220	hop	spice	neutral	6.5	2026-05-13 08:12:40.706106
2222	cod and/or pacific whiting	protein	healthy	9	2026-05-13 08:13:42.520131
2226	field peas	legume	healthy	9	2026-05-13 08:15:20.547249
2228	tamarind water	natural flavor	healthy	8.5	2026-05-13 08:15:58.571924
2232	shellfish	protein	caution	5.5	2026-05-13 08:16:50.312532
2234	aged pepper mash red peppers	spice	neutral	8	2026-05-13 08:17:44.400847
2238	blue 3	artificial color	caution	2	2026-05-13 08:19:15.712625
2241	annatto and turmeric extracts	natural color	neutral	8	2026-05-13 08:20:15.902734
2244	glycerol triacetate	preservative	caution	3.2	2026-05-13 08:22:11.539836
2247	disodium pyrophosphate	preservative	caution	4	2026-05-13 08:25:08.69326
2250	monostearate	emulsifier	neutral	5	2026-05-13 08:47:03.671745
2252	acetic acid esters of mono and diglycerides	emulsifier	caution	2.5	2026-05-13 08:49:00.310356
2255	canola and/or soybean oil with tbhq and/or palm oil	fat	neutral	5	2026-05-13 10:29:49.235939
2261	less than 2%	preservative	caution	2	2026-05-13 10:30:08.098945
2292	potassium sorbate and calcium disodium edta as preservative	preservative	caution	4	2026-05-13 20:09:52.665802
2294	thiamine mononitrate is thiamine, riboflavin is vitamin b2, folic acid is folate	vitamin	healthy	9.5	2026-05-13 20:10:12.038945
2302	cheese whey	byproduct	neutral	6.5	2026-05-13 20:13:38.772486
2303	asiago and parmesan cheeses pasteurized milk	dairy product	healthy	8	2026-05-13 20:14:07.863698
2309	soy protein concentrate and turmeric and beet powder color	protein	healthy	8.5	2026-05-13 20:17:49.217948
2316	strawberry seeds	seed	healthy	8.5	2026-05-13 20:19:51.136446
2318	nonfat dry milk powder	dairy	healthy	8	2026-05-13 20:20:29.536834
2322	corn gluten meal	protein	caution	4.5	2026-05-13 20:22:05.258409
2325	dried beans	protein	healthy	8	2026-05-13 20:22:34.078349
2327	romano cheese cultures	dairy	healthy	8.5	2026-05-13 20:23:06.415179
2328	yellow 5 and yellow 6. freshness preserved with sodium bisulfite. dried	{"artificial color",preservative}	caution	3	2026-05-13 20:23:57.144669
2341	thiamin mononitrate, riboflavin	{vitamin,preservative}	healthy	8.5	2026-05-13 20:27:25.805335
797	carob cream and guar gum	{sweetener,thickener}	neutral	7.5	2026-05-11 22:03:33.023548
1322	soy protein and wheat gluten	{protein}	neutral	6.5	2026-05-12 01:02:48.916179
1691	raspberry puree	fruit	healthy	8.5	2026-05-12 20:53:33.940004
1789	sodium chloride, modified starch	{salt,thickener}	neutral	2	2026-05-13 00:56:32.064232
2064	tartrazine and erythrosine	artificial color	caution	6.5	2026-05-13 07:02:45.389643
2342	pasteurized part-skim milk	dairy product	healthy	8.5	2026-05-13 20:27:31.030869
2345	apple flavour	natural flavor	healthy	8	2026-05-13 20:27:55.088417
2348	dried ingredient	dried ingredient	neutral	5	2026-05-13 20:29:02.414026
2352	soy protein and wheat protein with partially hydrogenated soybean oil	{protein,fat}	caution	4	2026-05-13 20:32:03.538531
2358	tocopherols and ascorbyl palmitate	antioxidant	healthy	8.5	2026-05-13 20:35:00.071303
2360	mono- and diglycerides and soy lecithin with bht	emulsifier	caution	2.5	2026-05-13 20:35:40.867512
2365	soluble corn fiber	fiber	healthy	8	2026-05-14 04:30:17.815737
2367	degermed corn	grain	neutral	6.5	2026-05-14 04:31:05.672071
2369	baking soda and/or calcium phosphate leavening	leavening agent	caution	6.5	2026-05-14 04:33:03.403883
2374	soybean and/or cottonseed oils	oil	neutral	5	2026-05-14 04:35:49.864705
2377	baking soda sodium aluminium phosphate is not a standard name, however aluminium phosphate is often used as a synonym for sodium aluminium phosphate, so the canonical name would be aluminium phosphate	preservative	caution	4	2026-05-14 04:36:40.698093
2388	guanylate	flavor enhancer	caution	2.5	2026-05-14 04:41:56.519049
2390	banana flavour	natural flavor	healthy	8.5	2026-05-14 04:42:29.5022
2393	arabic gum	thickener	neutral	4.5	2026-05-14 04:42:51.921411
2395	xanthan gum and gum arabic	thickener	neutral	7.5	2026-05-14 04:43:04.577157
2400	anhydrous butterfat	fat	neutral	4	2026-05-14 04:44:24.124004
2402	fd&c colors including red 3	artificial color	caution	2	2026-05-14 04:44:29.011765
2405	sorbitan tristearate	emulsifier	neutral	5.5	2026-05-14 04:44:41.903417
2408	sulphur dioxide	preservative	caution	2	2026-05-14 04:47:33.043913
2412	dairy whey	protein	healthy	8	2026-05-14 04:50:23.446529
2416	mono-calcium phosphate	preservative	neutral	5	2026-05-14 04:52:05.686295
2418	propellant	preservative	caution	2	2026-05-14 04:53:02.410613
2420	asiago and provolone cheeses pasteurized cow's milk	dairy	neutral	7.5	2026-05-14 04:53:32.521078
2427	batter	protein	neutral	7	2026-05-14 04:56:19.664033
2430	fd&c blue 2	artificial color	avoid	0	2026-05-14 04:57:23.101812
2433	lea leaves	spice	neutral	6.5	2026-05-14 04:58:27.718217
2436	blue #1	artificial color	caution	2	2026-05-14 04:59:05.013413
2439	ammonium nitrate	preservative	caution	2	2026-05-14 04:59:39.607247
2441	lactic acid starter culture	preservative	neutral	6.5	2026-05-14 05:01:11.844382
2445	disodium inosinate and disodium 5'-guanylate	flavor enhancer	caution	2	2026-05-14 05:03:10.362763
2451	vegetable mono and other vegetable oils	fat	neutral	5	2026-05-14 05:05:30.247043
2454	red 3 lake and blue 1 lake	artificial color	caution	2	2026-05-14 05:07:22.965591
2460	sodium propionate and citric acid	{preservative,acid}	caution	6	2026-05-14 05:10:54.670687
2465	peppadew pepper	vegetable	healthy	8.5	2026-05-14 05:12:25.431973
2468	coconut cream	fat	neutral	6	2026-05-14 05:13:00.753795
2471	potassium sorbate and sodium benzoate as preservatives0	preservative	caution	3	2026-05-14 05:14:07.385925
2475	grapefruit	fruit	healthy	8.5	2026-05-14 05:15:10.011632
2477	celery seeds	spice	healthy	8.5	2026-05-14 05:15:22.134946
2479	potassium alum	preservative	caution	2	2026-05-14 05:15:38.522641
2482	orange extract	natural flavor	neutral	8	2026-05-14 05:16:09.410873
2487	acid phosphate	preservative	neutral	6	2026-05-14 05:18:17.97387
2488	canola	oil	neutral	8	2026-05-14 05:19:01.489719
2489	black mushrooms	vegetable	healthy	8.5	2026-05-14 05:19:08.408504
2492	maltodextrin salt	thickener	caution	3	2026-05-14 05:19:50.705687
2497	cocoa beans	bean	healthy	9.5	2026-05-14 05:21:16.776464
2500	lactobacillus bulgaricus and streptococcus thermophilus cultures	probiotic	healthy	9.5	2026-05-14 05:21:40.530789
2504	candelilla wax	thickener	neutral	2.5	2026-05-14 05:23:27.524913
2506	lactobacillus rhamnosus	probiotic	healthy	8.5	2026-05-14 05:23:45.39797
2510	bifidobacterium	probiotic	healthy	8.5	2026-05-14 05:24:34.015016
2514	l-rhamnose	sugar	neutral	2	2026-05-14 05:25:40.883968
2515	vitamin d3 and live active cultures s. thermophilus	{vitamin,probiotic}	healthy	8.5	2026-05-14 05:25:43.394408
2521	clarified butter	fat	caution	2.5	2026-05-14 05:26:53.431552
2523	pasteurized whole milk cheese	dairy product	healthy	8	2026-05-14 05:27:06.754867
2527	fennel seeds	spice	healthy	8.5	2026-05-14 05:27:34.50315
2531	kerda berry	fruit	healthy	8.5	2026-05-14 05:28:59.365243
2533	split mung bean	legume	healthy	8.5	2026-05-14 05:29:40.788395
2534	baking soda and citric acid	{"alkalizing agent",preservative}	caution	4	2026-05-14 05:29:42.999382
2538	bifidobacterium bifidum and streptococcus thermophilus	probiotic	healthy	8	2026-05-14 05:30:37.876456
2543	mango pulp	fruit	healthy	8.5	2026-05-14 05:31:31.175124
2545	spearmint oil	natural flavor	healthy	8.5	2026-05-14 05:32:24.654231
2549	pea flour	grain	healthy	8.5	2026-05-14 05:33:43.483545
2551	soy grits	grain	neutral	7.5	2026-05-14 05:35:26.61784
2554	thickness	thickener	neutral	5	2026-05-14 05:36:36.622232
2556	hickory smoke flavoring	natural flavor	neutral	5	2026-05-14 05:37:02.248238
2558	smoke flavouring	natural flavor	neutral	5	2026-05-14 05:38:12.054978
2561	disodium inosinate & disodium guanylate and spices	flavor enhancer	caution	2	2026-05-14 05:38:32.937193
2566	caramel colour	artificial color	caution	2	2026-05-14 05:52:40.77024
2567	caramel colour is not a standard name, but it is often referred to as 'class iv caramel' or 'ammonia caramel'. however, in the us, it is often referred to as 'class iv caramel'. in the eu, it is often referred to as 'ammonia caramel'. in the uk, it is often referred to as 'class iv caramel'. but in general, it is often referred to as 'class iv caramel'. so, the canonical name is 'class iv caramel' in lowercase.	artificial color	caution	2	2026-05-14 05:53:37.415137
2587	lettuce juice	vegetable	healthy	8	2026-05-14 18:26:01.815617
2591	sprouted grains	grain	healthy	8.5	2026-05-14 18:28:01.009302
2594	goat's milk	dairy	healthy	8.5	2026-05-14 18:30:23.777583
2596	baobab fruit	fruit	healthy	8.5	2026-05-14 18:30:56.037014
2599	merlot grapes	fruit	healthy	9.5	2026-05-14 18:31:55.482289
2602	white grape juice	fruit juice	healthy	8.5	2026-05-14 18:34:13.048378
2604	yerba mate extract	herbal extract	neutral	6.5	2026-05-14 18:34:59.908102
2607	confectioner's sugar	sweetener	neutral	2	2026-05-14 18:38:38.991258
2610	fingerling potatoes	vegetable	healthy	8.5	2026-05-14 18:39:18.242288
2613	cane juice	sweetener	neutral	6	2026-05-14 18:40:35.036714
2614	blackstrap molasses	sweetener	caution	6	2026-05-14 18:40:44.496119
2616	peanut oil and/or cottonseed oil	oil	neutral	4.5	2026-05-14 18:41:20.82664
2619	blue 1 is not recognized, blue 2 is recognized as blue 2 (brilliant blue fcf)	artificial color	caution	2	2026-05-14 18:41:55.519125
2625	mono- and diesters	emulsifier	neutral	6	2026-05-14 18:44:25.926465
2627	natural essence	natural flavor	neutral	5	2026-05-14 18:45:16.617338
2628	sodium benzoate and potassium sorbate as is commonly referred to as 'preservatives' but more specifically, 'sodium benzoate' is a preservative and 'potassium sorbate' is a preservative. however, the canonical name is not a combination of both. therefore, the canonical name for 'sodium benzoate' is 'sodium benzoate' and for 'potassium sorbate' is 'potassium sorbate'.	preservative	caution	4	2026-05-14 18:45:22.421471
2645	coarse durum wheat semolina	grain	neutral	6.5	2026-05-14 18:49:40.608275
2648	tartrazine & sunset yellow fcf	artificial color	caution	2	2026-05-14 18:51:11.90151
2652	neufchatel	dairy product	neutral	6.5	2026-05-14 18:52:54.162923
2654	neufchatel cheese	dairy	healthy	8	2026-05-14 18:53:03.56704
2657	honey modified potato starch	thickener	neutral	2	2026-05-14 18:53:52.504646
2660	phospholipid	emulsifier	neutral	6	2026-05-14 18:55:09.800265
2664	smoke flavorings	natural flavor	neutral	5	2026-05-14 18:56:28.833711
2667	organic acid	acid	neutral	6	2026-05-14 19:00:15.907449
2669	cultured whey	protein	healthy	8.5	2026-05-14 19:00:55.853404
2672	butter and cheese flavour	natural flavor	neutral	2.5	2026-05-14 19:02:30.720707
2676	blueberry puree	fruit puree	healthy	8.5	2026-05-14 19:03:44.247807
2680	iodized salt	salt	neutral	2	2026-05-14 19:04:48.405356
2683	filter coffee	natural flavor	neutral	8	2026-05-14 19:06:17.769197
2687	rice bran extract	natural flavor	neutral	6.2	2026-05-14 19:09:17.414768
2690	potassium bisulphite	preservative	caution	2	2026-05-14 19:10:40.150271
2694	mold	preservative	caution	1	2026-05-14 19:11:22.939139
2696	dried lavender	natural flavor	neutral	6	2026-05-14 19:11:43.727852
2697	sodium benzoate and tartrazine	{preservative,"artificial color"}	caution	2	2026-05-14 19:11:55.452509
2704	dried currants	fruit	healthy	8.5	2026-05-14 19:13:34.592762
2708	concord grape	fruit	healthy	9.5	2026-05-14 19:14:08.351631
2710	chlorella	supplement	healthy	9.5	2026-05-14 19:14:15.430465
2713	red raspberry leaf	herb	healthy	8.5	2026-05-14 19:14:22.47496
2716	mangosteen	fruit	healthy	8.5	2026-05-14 19:14:29.413559
2719	sunflower seed butter	nut butter	healthy	8.5	2026-05-14 19:14:40.944168
2722	almond extract	natural flavor	neutral	5	2026-05-14 19:15:29.007242
2725	sheep casing	preservative	neutral	5	2026-05-14 19:16:14.400851
2726	carrageenan locust bean gum is not a standard name, however, the canonical names are 'carrageenan' and 'locust bean gum'	thickener	neutral	8	2026-05-14 19:16:38.646632
2734	fruit and vegetable juice concentrates	sweetener	neutral	6.5	2026-05-14 19:19:30.544578
2737	sweet onion	vegetable	healthy	8.5	2026-05-14 19:20:10.601676
2739	condensed skim milk	dairy	neutral	6.5	2026-05-14 19:20:58.253372
2741	vicia faba	legume	healthy	9.5	2026-05-14 19:21:22.718834
2744	raspberry and apricot filling	fruit	healthy	8.5	2026-05-14 19:22:35.683448
2747	kelp	vegetable	healthy	8.5	2026-05-14 19:25:46.253212
2749	artificial flavour and colouring	natural flavor and artificial color	avoid	2	2026-05-14 19:26:28.503984
2752	coconut with sodium metabisulfite for color retention	natural flavor	caution	4.5	2026-05-14 19:33:49.955921
2335	apple and grape juices from concentrate filtered water	juice	healthy	8	2026-05-13 20:25:11.312598
\.


--
-- Name: food_allergies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.food_allergies_id_seq', 415, true);


--
-- Name: ingredient_aliases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredient_aliases_id_seq', 15633, true);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 2754, true);


--
-- Name: food_allergies food_allergies_ingredient_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.food_allergies
    ADD CONSTRAINT food_allergies_ingredient_name_key UNIQUE (ingredient_name);


--
-- Name: food_allergies food_allergies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.food_allergies
    ADD CONSTRAINT food_allergies_pkey PRIMARY KEY (id);


--
-- Name: ingredient_aliases ingredient_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredient_aliases
    ADD CONSTRAINT ingredient_aliases_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_name_key UNIQUE (name);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: ingredient_aliases ingredient_aliases_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredient_aliases
    ADD CONSTRAINT ingredient_aliases_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(id);


--
-- PostgreSQL database dump complete
--

