const NMEC = "118772";
const TARGET_DB = "cbd";
const OUTPUT_FILE = `CBD_L202_${NMEC}.txt`;
const TOTAL_QUESTIONS = 25;

const QUESTION_TITLES = {
  1: "Liste todos os documentos da colecao.",
  2: "Apresente os campos restaurant_id, nome, localidade e gastronomia para todos os documentos da colecao.",
  3: "Apresente os campos restaurant_id, nome, localidade e codigo postal (zipcode), excluindo o campo _id de todos os documentos da colecao.",
  4: "Indique o total de restaurantes localizados no Bronx.",
  5: "Apresente os primeiros 15 restaurantes localizados no Bronx, ordenados por ordem crescente de nome.",
  6: "Liste todos os restaurantes que tenham pelo menos um score superior a 85.",
  7: "Encontre os restaurantes que obtiveram uma ou mais pontuacoes (score) entre [80 e 100].",
  8: "Indique os restaurantes com latitude inferior a -95,7.",
  9: "Indique os restaurantes que nao tem gastronomia \"American\", tiveram uma ou mais pontuacoes superiores a 70 e estao numa latitude inferior a -65.",
  10: "Liste o restaurant_id, o nome, a localidade e gastronomia dos restaurantes cujo nome comecam por \"Wil\".",
  11: "Liste o nome, a localidade e a gastronomia dos restaurantes que pertencem ao Bronx e cuja gastronomia e do tipo \"American\" ou \"Chinese\".",
  12: "Liste o restaurant_id, o nome, a localidade e a gastronomia dos restaurantes localizados em \"Staten Island\", \"Queens\" ou \"Brooklyn\".",
  13: "Liste o nome, a localidade, o score e gastronomia dos restaurantes que alcancaram sempre pontuacoes inferiores ou iguais a 3.",
  14: "Liste o nome e as avaliacoes dos restaurantes que obtiveram uma avaliacao com grade \"A\", score 10 na data ISODate \"2014-08-11T00:00:00Z\".",
  15: "Liste o restaurant_id, o nome e os score dos restaurantes nos quais a segunda avaliacao foi grade \"A\" e ocorreu em ISODate \"2014-08-11T00:00:00Z\".",
  16: "Liste o restaurant_id, o nome, o endereco (address) dos restaurantes onde o segundo elemento da matriz coord tem valor superior a 42 e inferior ou igual a 52.",
  17: "Liste nome, gastronomia e localidade de todos os restaurantes, ordenando por ordem crescente da gastronomia e, em segundo, por ordem decrescente de localidade.",
  18: "Liste nome, localidade, grade e gastronomia de todos os restaurantes localizados em Brooklyn que nao incluem gastronomia \"American\" e obtiveram classificacao \"A\", por ordem decrescente de gastronomia.",
  19: "Indique o numero total de avaliacoes (numGrades) na colecao.",
  20: "Apresente o nome e numero de avaliacoes (numGrades) dos 3 restaurantes com mais avaliacoes.",
  21: "Apresente o numero total de avaliacoes (numGrades) em cada dia da semana.",
  22: "Conte o total de restaurantes existentes em cada localidade.",
  23: "Indique os restaurantes que tem gastronomia \"Portuguese\", o somatorio de score superior a 50 e estao numa latitude inferior a -60.",
  24: "Apresente o numero de gastronomias diferentes na rua \"Fifth Avenue\".",
  25: "Apresente o nome, o score medio (avgScore) e numero de avaliacoes (numGrades) dos restaurantes com score medio superior a 30 desde 1-Jan-2014."
};

const fs = require("fs");

function serializeResult(value) {
  try {
    return EJSON.stringify(value, null, 2);
  } catch (e) {
    try {
      return JSON.stringify(value, null, 2);
    } catch (err) {
      return String(value);
    }
  }
}

function extractQuestionNumber(fileName) {
  const match = fileName.match(/q(\d+)\.js$/);
  return match ? Number(match[1]) : null;
}

function run() {
  db = db.getSiblingDB(TARGET_DB);

  const files = [];
  for (let i = 1; i <= TOTAL_QUESTIONS; i += 1) {
    files.push(`lab2_2/q${i}.js`);
  }

  const lines = [];

  lines.push("Lista de Perguntas:");
  for (let i = 1; i <= TOTAL_QUESTIONS; i += 1) {
    lines.push(`${i}. ${QUESTION_TITLES[i]}`);
  }
  lines.push("");
  lines.push("// ========================================");
  lines.push("");

  for (const file of files) {
    const question = extractQuestionNumber(file);
    const command = fs.readFileSync(file, "utf8").trim();

    lines.push(`Pergunta ${question}`);
    lines.push(`Enunciado: ${QUESTION_TITLES[question]}`);
    lines.push("Comando:");
    lines.push(command);
    lines.push("Resultado:");

    try {
      let result = eval(command);

      if (result && typeof result.toArray === "function") {
        result = result.toArray();
      }

      lines.push(serializeResult(result));
    } catch (err) {
      lines.push(`ERRO: ${err.message}`);
    }

    lines.push("// ----------------------------------------");
    lines.push("");
  }

  fs.writeFileSync(OUTPUT_FILE, `${lines.join("\n")}\n`, "utf8");
  print(`Ficheiro gerado: ${OUTPUT_FILE}`);
}

run();
