# HLHS-Multimodal-AI
A multimodal nomogram combining ResNet-like VAE image features and clinical parameters for accurate prenatal HLHS risk prediction.

📘 Overview



This project presents a self-supervised multimodal diagnostic framework for the prenatal risk assessment of Hypoplastic Left Heart Syndrome (HLHS).
By integrating ultrasound image-derived features, clinical demographics, and fetal cardiac morphology, the study develops a multimodal nomogram that achieves expert-level diagnostic performance.




The core model uses a ResNet-like Variational Autoencoder (RVAE) to extract features from fetal four-chamber heart view images under a self-supervised learning paradigm. These features are then fused with clinical and morphological parameters via logistic regression to build a multimodal predictive nomogram.

🧠 Highlights
🔹 Self-supervised RVAE feature extraction from fetal ultrasound images
🔹 Multimodal fusion combining image-derived features with clinical parameters
🔹 Nomogram visualization for interpretability and clinical usability
🔹 Comparison with machine learning models and human experts
🔹 Heatmap generation for model explainability
🧩 Workflow

Data Collection


161 normal pregnancies and 52 HLHS cases (Maternal and Child Health Hospital of Hubei Province, 2019–2023)
Standard four-chamber fetal cardiac views selected by experienced sonographers

Image Preprocessing

Manual delineation of left/right atria and ventricles
Resizing and normalization
Data augmentation (rotation, contrast adjustment)

Feature Extraction

A ResNet-like Variational Autoencoder (RVAE) trained in a self-supervised manner
Latent features converted to an image score representing cardiac structural abnormalities

Multimodal Nomogram Construction

Univariate and multivariate logistic regression combining:
Image score
Left ventricular diameter
Area ratio between left/right atrium and ventricles
Developed a nomogram for clinical risk interpretation

Evaluation

Compared with:
Traditional logistic regression
ML models (Random Forest, SVM, XGBoost, MLP)
Expert models (sonographers with 3, 6, and 10 years’ experience)
Performance metrics: Accuracy, AUC, Sensitivity, Specificity

⚙️ Installation

Clone the repository and install dependencies:

git clone https://github.com/yourusername/HLHS-Nomogram.git
cd HLHS-Nomogram
pip install -r requirements.txt

Main dependencies:

torch
torchvision
numpy
pandas
scikit-learn
matplotlib
seaborn
opencv-python
