
# Neural Tagger for MD and NER

This repo contains the software that was used to conduct the experiments reported
in our article titled "Improving Named Entity Recognition by Jointly Learning to 
Disambiguate Morphological Tags" [1] to be presented at [COLING 2018](http://coling2018.org).


## Tag sentences

This project do not have a designated tagger script for now but you can obtain the output in `eval_dir`. 
You should provide the text in tokenized form in CoNLL format. The script will tag both the development and 
testing files and produce files in `./evaluation/temp/eval_logs/`. If you need this and want to contribute by coding
 and sharing it with the project, you are welcome.

## How to run using Docker

1. Clone the repo
```bash
git clone https://github.com/BOUN-TABILab-TULAP/NER.git
```
2. Launch a terminal in the root directory of the repo and build the Docker image where
- `-t` is the tag for the Docker image. You can provide any name you want
- `.` is the relative path to the Dockerfile 
```bash
docker build -t ner .
```
3. Run the Docker image where
- `-d` indicates "detach", let the container run in the background
- `-p 8080:8080` indicates mapping port 8080 of the container to the port 8080 of the host.
```bash
docker run -d -p 8080:8080 ner
```
4. Send a POST request
- via curl
    ```bash
    curl -X POST http://localhost:8080/ner/predict/ 
   -H 'Content-Type: application/json' 
   -d "{'text':'İstanbul'daki maçta Demet ile Ahmet değişerek oynadı.'}"
   
   > {'dataset_file_string': {'0': ["İstanbul'daki", '_', 'i̇stanbul+Noun+Prop+A3sg+Pnon+Loc^DB+Adj+Rel', 'O'], '1': ['maçta', '_', 'maç+Noun+A3sg+Pnon+Loc', 'O'], '2': ['Demet', '_', 'demet+Noun+A3sg+Pnon+Nom', 'demet+Noun+Prop+A3sg+Pnon+Nom', 'O'], '3': ['ile', '_', 'il+Noun+A3sg+Pnon+Dat', 'ile+Conj', 'ile+Postp+PCNom', 'O'], '4': ['Ahmet', '_', 'ahmet+Noun+Prop+A3sg+Pnon+Nom', 'O'], '5': ['değişerek', '_', 'değ+Verb+Recip+Pos^DB+Adverb+ByDoingSo', 'değiş+Verb+Pos^DB+Adverb+ByDoingSo', 'O'], '6': ['oynadı', '_', 'oyna+Verb+Pos+Past+A3sg', 'O'], '7': ['.', '_', '.+Punc', 'O']}, 'tagger_output': {'0': ["İstanbul'daki", 'B-LOC'], '1': ['maçta', 'O'], '2': ['Demet', 'B-PER'], '3': ['ile', 'O'], '4': ['Ahmet', 'B-PER'], '5': ['değişerek', 'O'], '6': ['oynadı', 'O'], '7': ['.', 'O']}}
    ```
- via Python's requests library
    ```python
    import requests
    res = requests.post('http://localhost:8080/ner/predict/', json={'text':"İstanbul'daki maçta Demet ile Ahmet değişerek oynadı."})
    print(res.json())

    > {'dataset_file_string': {'0': ["İstanbul'daki", '_', 'i̇stanbul+Noun+Prop+A3sg+Pnon+Loc^DB+Adj+Rel', 'O'], '1': ['maçta', '_', 'maç+Noun+A3sg+Pnon+Loc', 'O'], '2': ['Demet', '_', 'demet+Noun+A3sg+Pnon+Nom', 'demet+Noun+Prop+A3sg+Pnon+Nom', 'O'], '3': ['ile', '_', 'il+Noun+A3sg+Pnon+Dat', 'ile+Conj', 'ile+Postp+PCNom', 'O'], '4': ['Ahmet', '_', 'ahmet+Noun+Prop+A3sg+Pnon+Nom', 'O'], '5': ['değişerek', '_', 'değ+Verb+Recip+Pos^DB+Adverb+ByDoingSo', 'değiş+Verb+Pos^DB+Adverb+ByDoingSo', 'O'], '6': ['oynadı', '_', 'oyna+Verb+Pos+Past+A3sg', 'O'], '7': ['.', '_', '.+Punc', 'O']}, 'tagger_output': {'0': ["İstanbul'daki", 'B-LOC'], '1': ['maçta', 'O'], '2': ['Demet', 'B-PER'], '3': ['ile', 'O'], '4': ['Ahmet', 'B-PER'], '5': ['değişerek', 'O'], '6': ['oynadı', 'O'], '7': ['.', 'O']}}
    ```

## References

[1] Gungor, O., Uskudarli, S., Gungor, T., Improving Named Entity Recognition by Jointly Learning to 
Disambiguate Morphological Tags, 2018, COLING 2018, 19-25 August, (to appear).

