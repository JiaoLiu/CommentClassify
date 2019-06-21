import Cocoa
import CreateML
import NaturalLanguage

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/Jiao/Desktop/SecurityKeeper/CommentClassify/data.json"))
var (trainData, testData) = data.randomSplit(by: 0.8, seed: 5);
let param = MLTextClassifier.ModelParameters(validationData: testData, algorithm: MLTextClassifier.ModelAlgorithmType.maxEnt(revision: 1), language: NLLanguage.simplifiedChinese)
let commentClassifier = try MLTextClassifier(trainingData: data, textColumn: "content", labelColumn: "subject", parameters: param)
let evalMetrics = commentClassifier.evaluation(on: testData)
let evalAcc = 1 - evalMetrics.classificationError
print(evalAcc)

let metadata = MLModelMetadata(author: "Jiao", shortDescription: "comment classify", license: "MIT", version: "1.0", additional: nil)
try commentClassifier.write(to: URL(fileURLWithPath: "/Users/Jiao/Desktop/SecurityKeeper/CommentClassify/mlmodel/classifier.mlmodel"), metadata: metadata)
