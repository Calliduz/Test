import React, { useState, useEffect } from "react";
import Header from "../components/Header";
import Footer from "../components/Footer";
import InventoryTable from "../components/InventoryTable";
import AddItemModal from "../components/AddItemModal";
import ItemHistoryModal from "../components/ItemHistoryModal";
import IncreaseStockModal from "../components/IncreaseStockModal";
import ReduceStockModal from "../components/ReduceStockModal";
import ManageCategoriesModal from "../components/ManageCategoriesModal";
import ReportView from "../components/ReportView";
import { ConsolidatedItem, HistoryEntry, Category, ViewMode } from "../types";
import { getConsolidatedInventory } from "../utils/inventoryUtils";
import axios from "axios";

const OperatorDashboard: React.FC = () => {
  const [historyEntries, setHistoryEntries] = useState<HistoryEntry[]>([]);
  const [categories, setCategories] = useState<Category>({});
  const [viewMode, setViewMode] = useState<ViewMode>("consolidated");
  const [showReportView, setShowReportView] = useState<boolean>(false);
  const [showAddModal, setShowAddModal] = useState(false);
  const [showCategoryModal, setShowCategoryModal] = useState(false);
  const [selectedItem, setSelectedItem] = useState<ConsolidatedItem | null>(null);
  const [showIncreaseModal, setShowIncreaseModal] = useState(false);
  const [showReduceModal, setShowReduceModal] = useState(false);
  const [showHistoryModal, setShowHistoryModal] = useState(false);
  const [consolidatedItems, setConsolidatedItems] = useState<ConsolidatedItem[]>([]);

  // Fetch categories
  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get("http://localhost/Test/API/categories.php");
        const json = typeof res.data === "string" ? JSON.parse(res.data) : res.data;
        setCategories(json);
      } catch (error) {
        console.error("❌ Failed to load categories:", error);
      }
    };
    fetchData();
  }, []);

  // Fetch items from backend
const fetchItems = async () => {
  try {
    const res = await axios.get("http://localhost/Test/API/items.php");
    console.log('API Response:', res.data);
    const data = typeof res.data === "string" ? JSON.parse(res.data) : res.data;
    
    if (data.items && Array.isArray(data.items)) {
      const itemsWithDates = data.items.map((item: ConsolidatedItem) => {
        // Get all history entries for this item
        const itemHistory = data.history.filter((h: HistoryEntry) => 
          h.predefined_item_id === item.predefined_item_id
        );

        // First check for the most recent entry with a harvest date
        const entriesWithDates = itemHistory
          .filter((h: HistoryEntry) => h.harvestDate && h.harvestDate.trim() !== '')
          .sort((a: HistoryEntry, b: HistoryEntry) => 
            new Date(b.date).getTime() - new Date(a.date).getTime()
          );

        if (entriesWithDates.length > 0) {
          return {
            ...item,
            harvestDate: entriesWithDates[0].harvestDate
          };
        }

        // If no entries with harvest dates, look for the initial 'add' entry
        const addEntries = itemHistory
          .filter((h: HistoryEntry) => h.changeType === 'add')
          .sort((a: HistoryEntry, b: HistoryEntry) => 
            new Date(b.date).getTime() - new Date(a.date).getTime()
          );

        if (addEntries.length > 0) {
          return {
            ...item,
            harvestDate: addEntries[0].harvestDate
          };
        }

        // If no matching entries found, return item with null harvest date
        return {
          ...item,
          harvestDate: null
        };
      });
      
      console.log('Items with dates:', itemsWithDates);
      setConsolidatedItems(itemsWithDates);
      setHistoryEntries(Array.isArray(data.history) ? data.history : []);
    }
  } catch (error) {
    console.error("❌ Failed to load items:", error);
    setHistoryEntries([]);
    setConsolidatedItems([]);
  }
};

  useEffect(() => {
    fetchItems();
  }, []);

  const getCategoryLabel = (mainCategory: string | number, subcategory: string | number) => {
    const mainCat = categories[mainCategory];
    const mainLabel = mainCat?.label || mainCategory;
    const subLabel = mainCat?.subcategories?.[subcategory]?.label || subcategory;
    return `${mainLabel}/${subLabel}`;
  };

  // Function to handle reducing stock
  const handleReduceStock = (item: ConsolidatedItem) => {
    setSelectedItem(item);
    setShowReduceModal(true);
  };

  // Function to handle increasing stock
  const handleIncreaseStock = (item: ConsolidatedItem) => {
    setSelectedItem(item);
    setShowIncreaseModal(true);
  };

  // Function to handle viewing history
  const handleViewHistory = (item: ConsolidatedItem) => {
    setSelectedItem(item);
    setShowHistoryModal(true);
  };

  return (
    <div className="min-h-screen flex flex-col bg-gray-100">
      <Header />
      <main className="flex-1 p-6 max-w-7xl mx-auto">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-2xl font-bold">Operator Dashboard</h2>
          <div className="space-x-2">
            <button
              className="bg-green-700 text-white px-3 py-2 rounded hover:bg-green-800"
              onClick={() => setShowAddModal(true)}
            >
              + Add Item
            </button>
            <button
              className="bg-blue-700 text-white px-3 py-2 rounded hover:bg-blue-800"
              onClick={() => setShowCategoryModal(true)}
            >
              Manage Categories
            </button>
            <button
              className="bg-yellow-600 text-white px-3 py-2 rounded hover:bg-yellow-700"
              onClick={() => setShowReportView(!showReportView)}
            >
              {showReportView ? "Back to Inventory" : "Generate Report"}
            </button>
          </div>
        </div>

        {!showReportView ? (
  <>
    <div className="mb-4">
      <button
        className={`px-4 py-2 mr-2 rounded ${
          viewMode === "consolidated" ? "bg-green-700 text-white" : "bg-white border"
        }`}
        onClick={() => setViewMode("consolidated")}
      >
        Consolidated View
      </button>
      <button
        className={`px-4 py-2 rounded ${
          viewMode === "history" ? "bg-green-700 text-white" : "bg-white border"
        }`}
        onClick={() => setViewMode("history")}
      >
        History View
      </button>
    </div>
    <InventoryTable
      items={viewMode === "consolidated" ? consolidatedItems : historyEntries}
      viewMode={viewMode}
      categories={categories}
      onReduceStock={handleReduceStock}
      onIncreaseStock={handleIncreaseStock}
      onViewHistory={handleViewHistory}
    />
  </>
) : (
  <ReportView
    historyEntries={historyEntries}
    categories={categories}
    onClose={() => setShowReportView(false)}
  />
)}
      </main>
      <Footer />

      {showAddModal && (
        <AddItemModal
          categories={categories}
          onClose={() => setShowAddModal(false)}
          onAddItem={() => {
            setShowAddModal(false);
            fetchItems(); // Refresh items after adding
          }}
        />
      )}

      {showCategoryModal && (
        <ManageCategoriesModal
          categories={categories}
          onUpdateCategories={(updatedCategories) => setCategories(updatedCategories)}
          onClose={() => setShowCategoryModal(false)}
        />
      )}

      {showReduceModal && selectedItem && (
        <ReduceStockModal
  item={selectedItem}
  onClose={() => setShowReduceModal(false)}
  onReduceStock={(entry) => {
    setShowReduceModal(false);
    fetchItems(); // <-- Make sure this reloads historyEntries from backend
  }}
/>
      )}

      {showIncreaseModal && selectedItem && (
        <IncreaseStockModal
          item={selectedItem}
          onClose={() => setShowIncreaseModal(false)}
          onIncreaseStock={(entry) => {
            setShowIncreaseModal(false);
            fetchItems(); // Refresh items after increasing stock
          }}
        />
      )}
{showHistoryModal && selectedItem && (
  <ItemHistoryModal
  item={selectedItem}
  historyEntries={historyEntries.filter(
    entry =>
      entry.name === selectedItem.name &&
      entry.mainCategory === selectedItem.mainCategory &&
      entry.subcategory === selectedItem.subcategory
  )}
  categories={categories}
  onClose={() => setShowHistoryModal(false)}
/>
)}
    </div>
  );
};

export default OperatorDashboard;