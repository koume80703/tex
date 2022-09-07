#!/bin/bash

if [ $# -lt 1 ]; then
    echo "引数エラー: 引数が足りません"
    exit 1
fi

# 引数を変数に代入
arg=$1

# 得られた引数をもとにファイル名(拡張子付き)、ディレクトリ名、ファイル名(拡張子無し)、拡張子の4つに展開する
# シェルの変数展開を用いている。
# ${VAR#PATTERN} : 前方一致(最短マッチ)
# ${VAR##PATTERN}: 前方一致(最長マッチ)
# ${VAR%PATTERN} : 後方一致(最短マッチ)
# ${VAR%%PATTERN}: 後方一致(最長マッチ)
filename=$(basename $arg)
dirname=$(dirname $arg)
basename=${filename%.*}
extension=${filename##*.}

if [ "${extension}" != "tex" ]; then
    echo "引数: .tex ファイルを指定してください"
    exit 1
fi

if [ -f ./${dirname}/${filename} ]; then
    echo "x" | docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja platex ${dirname}/${filename}

    echo "x" | docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja platex ${dirname}/${filename}

    if [ ! -e ${basename}.dvi ]; then
        echo -e "\n${basename}.dvi が見つかりません"
        exit 1
    fi

    echo "x" | docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja dvipdfmx -o pdf/${basename}.pdf ${basename}.dvi
    echo -e "\n${basename}.pdf を作成しました\n"

    rm -f ${basename}.log ${basename}.aux ${basename}.dvi ${basename}.toc ${basename}.out
else
    echo "ファイル: ${dirname}/${filename} が見つかりません"
    exit 1
fi

if [ -f ./pdf/${basename}.pdf ]; then
    echo -e "${basename}.pdf を開きます\n"
    code pdf/${basename}.pdf
else
    echo "ファイル: ${basename}.pdf が見つかりません"
    exit 1
fi
