
int word_count(char *article) {
  int idx = 0;
  while (article[idx] != '\0') {
    idx += 1;
  }
  return idx;
}
