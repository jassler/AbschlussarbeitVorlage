for f in `ls *.Rmd`
do
  echo "-----"
  echo `find . -maxdepth 1 -type f -name "${f%.*}.*" -not -name "*.Rmd"`
  find . -maxdepth 1 -type f -name "${f%.*}.*" -not -name "*.Rmd" -delete
done
