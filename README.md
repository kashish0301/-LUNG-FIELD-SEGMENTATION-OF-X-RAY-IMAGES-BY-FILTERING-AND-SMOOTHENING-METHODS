# Lung Field Segmentation of X-Ray Images using Image processing techniques and CNN

## Overview

This project focuses on the segmentation of lung fields in chest X-ray images using various filtering and smoothing methods. The primary objective is to enhance the accuracy of lung area detection, which is crucial for diagnosing lung diseases.

Abnormal image for lung segmentation using Active Contour and GGIF

![image](https://github.com/user-attachments/assets/09e8b9dd-4c6b-4e8f-a056-dc4a2dd8eb5f)


![image](https://github.com/user-attachments/assets/98989a47-b251-4d3f-8be1-172f12d85194)


## Abstract

Accurate lung segmentation is a critical pre-processing step in the analysis of pulmonary radiographs. This project proposes a method utilizing MATLAB to segment lung areas, employing the Weighted Least Squares (WLS) filter and Globally Guided Image Filtering (GGIF) combined with the Active Contour Model. The method improves segmentation efficiency and lung abnormality detection while reducing processing time.


## Methodology
1. **Weighted Least Squares (WLS) Filter**: This technique smooths the image while preserving edges, facilitating better segmentation.
2. **Globally Guided Image Filtering (GGIF)**: GGIF enhances image quality, making features more distinguishable.
3. **Active Contour Model**: This model adapts to object boundaries, effectively segmenting the lung areas.
4. **Convolutional Neural Networks (CNN)**: CNNs are implemented for automatic feature extraction and segmentation, improving classification accuracy.

## Implementation
The lung field segmentation pipeline includes:
- Preprocessing X-ray images using WLS and GGIF.
- Applying the Active Contour Model for initial segmentation.
- Using CNN to refine and validate segmentation results.


### Techniques Used

- **Active Contour Model**: For dynamic segmentation based on shape.
- **Globally Guided Image Filtering (GGIF)**: To enhance image details.
- **Weighted Least Squares (WLS) Filtering**: For smoothening and reducing noise in images.

### Key Functions

- `boxfilter.m`: Applies a box filter for basic image smoothing.
- `getDiceCoeff.m`: Calculates the Dice coefficient for evaluating segmentation performance.
- `getJaccard.m`: Computes the Jaccard index for segmentation accuracy assessment.
- `lungsMain.m`: Main script for executing the lung segmentation process.
- `minor.m`: Additional processing function for minor adjustments.
- `sed_seg.m`: Implements the SEDUCM method for effective lung segmentation.
- `wlsFilter.m`: Applies the WLS filter to enhance image quality.

## Authors

- **Kashish Kharyal**  
- **Aakriti Singh**  


## Conclusion

The segmentation method developed in this project provides a robust framework for improving the analysis of chest X-rays, which is essential for early diagnosis and treatment of lung conditions.


