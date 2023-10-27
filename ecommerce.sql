-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2023 at 01:21 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `user_id`, `product_id`, `quantity`) VALUES
(44, 14, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Laptop'),
(2, 'PC'),
(3, 'Printer'),
(4, 'Accessories');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `order_date` int(11) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `product_id`, `quantity`, `order_date`, `billing_address`, `phone_number`) VALUES
(1, 1, 1, 1.00, NULL, NULL, NULL),
(2, 1, 1, 1.00, NULL, 'b301 emaad  heights sarkhej', '9687171228'),
(3, 1, 1, 2.00, NULL, 'aa', '9685'),
(4, 1, 1, 2.00, NULL, 'Ljiet', '966696'),
(8, 1, 4, 1.00, NULL, 'qqqq', '9687171228'),
(9, 1, 1, 1.00, NULL, 'ss', '555'),
(10, 1, 1, 1.00, NULL, 'jj', '999'),
(11, 1, 1, 2.00, NULL, 's', '2'),
(12, 1, 1, 1.00, NULL, 'a', '1'),
(13, 1, 1, 1.00, NULL, 'aa', '11'),
(14, 1, 4, 4.00, NULL, 'aa', '11'),
(15, 1, 1, 2.00, NULL, 'aa', '6665'),
(16, 1, 4, 1.00, NULL, 'lklk', '535'),
(17, 1, 4, 1.00, NULL, 'w', '5');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `category_id`) VALUES
(1, 'Asus Tuf Gaming F17', 'Processor: i5 11th gen\r\nRam: 8GB\r\nStorage: 512GB SSD\r\nDisplay: 144HZ\r\nGraphics: 4GB NVIDIA GeForce RTX 2050\r\nOperating System: Windows 11\r\ncolour: Black\r\nWeight: 2.60 kg', 57990, 1),
(4, 'HP Victus Gaming Laptop', 'Processor: i5 12th gen\nRam: 16GB\nStorage: 512GB SSD\nDisplay: 144HZ\nGraphics: 4GB NVIDIA GeForce RTX 3050\nOperating System: Windows 11\ncolour: Black\nWeight: 2.29 kg', 71990, 1),
(5, 'Dell G15-5520 Gaming Laptop', 'Processor: i5 12th gen\r\nRam: 8GB\r\nStorage: 512GB SSD\r\nDisplay: 120HZ\r\nGraphics: 4GB NVIDIA GeForce RTX 3050\r\nOperating System: Windows 11\r\ncolour: Black\r\nWeight: 2.81 kg', 67990, 1),
(6, 'Canon PIXMA G3000', 'Print/Scan/Copy(Xerox)All in One WiFi Inktank Colour Printer with 2 Additional Black Ink Bottles', 14399, 3),
(7, 'Epson EcoTank L3250', 'Print/Scan/Copy(Xerox)A4 Wi-Fi All-in-One Ink Tank Printer', 15028, 3),
(8, 'Brother DCP-L2520D', 'Multi-Function Monochrome Laser Printer with Auto-Duplex Printing', 14999, 3),
(9, 'AirCase Protective Laptop Bag', 'fits Upto 15.6\" Laptop/MacBook', 900, 4),
(10, 'i.jet toner cartridge', 'compitible with 12A supported laser printer', 650, 4),
(11, 'Zebronics Zeb-Transformer Gaming Keyboard and Mouse Combo', 'compitible with all laptops and PCs', 1199, 4),
(12, 'ASUS TUF Series Pre Build PC', 'Processor: Ryzen 5 5500h\r\nRam: 16GB\r\nStorage: 512GB SSD\r\nGraphics: 4GB NVIDIA GeForce RTX 3050\r\nOperating System: Windows 11\r\n', 90000, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(8) DEFAULT NULL,
  `mobile` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `email`, `password`, `mobile`) VALUES
(1, '', '', '', 'musaib00', ''),
(2, '', '', '', 'cst1', ''),
(3, '', '', '', '123', ''),
(4, '', '', '', 'zafu1', ''),
(5, '', '', '', '2c', ''),
(6, '', '', '', 'abc1', ''),
(7, 'musaib', 'memon', 'musaibmemon', '123', '9632587412'),
(8, '', '', '', '', ''),
(9, 'zaif', 'mirza', 'zaifu@gmail.com', 'zafu123', '9632587412'),
(10, '', '', '', '', ''),
(11, 'zaif', 'mirza', 'zaifu@gmail.com', 'zafu123', '9632587410'),
(12, 'dhruvil', 'jadav', 'dhruvil69@gmail.com', 'deesnuts', '6969696969'),
(13, 'stym', 'ydv', 'ydv', '1234', '7958678'),
(14, 'a', 'z', 'aa', '11', '888');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`),
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
