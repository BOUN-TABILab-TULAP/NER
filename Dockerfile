FROM python:3.5

RUN pip install wheel
RUN pip install cython
RUN pip install dynet

RUN mkdir /opt/ner-tagger-dynet

WORKDIR /opt/ner-tagger-dynet
COPY . .
# COPY *.py /opt/ner-tagger-dynet/
# COPY requirements.txt /opt/ner-tagger-dynet/

RUN pip install pbr

RUN pip install -r requirements.txt

# RUN mkdir dataset

# COPY evaluation/conlleval evaluation/
# COPY evaluation/conlleval.py evaluation/
# COPY evaluation/conlleval-runner.sh evaluation/
RUN mkdir -p evaluation/temp/eval_logs/

RUN mkdir models/

# COPY web /opt/ner-tagger-dynet/web
# COPY utils /opt/ner-tagger-dynet/utils
# COPY toolkit /opt/ner-tagger-dynet/toolkit


RUN wget -q -r -nH --cut-dirs=2  --no-parent -e robots=off https://tulap.cmpe.boun.edu.tr/staticFiles/NER/
RUN touch models/model_paths_database.dat
RUN chmod -R +x ../ner-tagger-dynet/
# CMD tail -f /dev/null
EXPOSE 8080
ENTRYPOINT [ "python" ]
CMD [ "main.py", "--command", "webapp", "--model_path", "model-00000025", "--model_epoch_path", "model-epoch-00000039", "--port", "8080" ]
