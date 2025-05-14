import React from 'react';
import { ChevronDown, ChevronUp, History } from 'lucide-react';
import { ConsolidatedItem, Category, ViewMode, HistoryEntry } from '../types';
import { formatDate } from '../utils/inventoryUtils';

interface InventoryTableProps {
  items: ConsolidatedItem[] | HistoryEntry[];
  viewMode: ViewMode;
  categories: Category;
  onReduceStock: (item: ConsolidatedItem) => void;
  onIncreaseStock: (item: ConsolidatedItem) => void;
  onViewHistory: (item: ConsolidatedItem) => void;
}

const InventoryTable: React.FC<InventoryTableProps> = ({
  items,
  viewMode,
  categories,
  onReduceStock,
  onIncreaseStock,
  onViewHistory
}) => {
  // Ensure items is an array
  const itemsArray = Array.isArray(items) ? items : [];

  // Get category label
  const getCategoryLabel = (mainCategory: string | number, subcategory: string | number) => {
    const mainCat = categories[mainCategory];
    const mainLabel = mainCat?.label || mainCategory;
    const subLabel = mainCat?.subcategories?.[subcategory]?.label || subcategory;
    return `${mainLabel}/${subLabel}`;
  };

  // Add this function to safely format dates
  const safeFormatDate = (date: string | number | null | undefined) => {
    if (!date) return "-";
    return formatDate(String(date));
  };

  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse">
        <thead>
          <tr className="bg-green-700 text-white">
            {viewMode === 'consolidated' ? (
              <>
                <th className="p-3 text-left">Item Name</th>
                <th className="p-3 text-left">Category</th>
                <th className="p-3 text-left">Current Stock</th>
                <th className="p-3 text-left">Recent Harvest Date</th>
                <th className="p-3 text-left">Actions</th>
              </>
            ) : (
              <>
                <th className="p-3 text-left">Date</th>
                <th className="p-3 text-left">Item Name</th>
                <th className="p-3 text-left">Category</th>
                <th className="p-3 text-left">Quantity Change</th>
                <th className="p-3 text-left">Harvest Date</th>
                <th className="p-3 text-left">Notes</th>
              </>
            )}
          </tr>
        </thead>
        <tbody>
          {itemsArray.length === 0 ? (
            <tr>
              <td 
                colSpan={viewMode === 'consolidated' ? 5 : 6} 
                className="p-4 text-center text-gray-500 border border-gray-200"
              >
                No items found
              </td>
            </tr>
          ) : (
            viewMode === 'consolidated' ? (
              // Consolidated view
              (itemsArray as ConsolidatedItem[]).map(item => (
                <tr key={item.id} className="border-b border-gray-200 hover:bg-gray-50">
                  <td className="p-3">{item.name}</td>
                  <td className="p-3">{getCategoryLabel(item.mainCategory, item.subcategory)}</td>
                  <td className="p-3">
                    <span className="font-medium">{item.quantity} {item.unit}</span>
                  </td>
                  <td className="p-3">{safeFormatDate(item.harvestDate)}</td>
                  <td className="p-3">
                    <div className="flex gap-2">
                      <button 
                        onClick={() => onIncreaseStock(item)}
                        className="bg-green-700 text-white px-3 py-1 rounded text-sm hover:bg-green-800 transition-colors"
                      >
                        Add
                      </button>
                      <button 
                        onClick={() => onReduceStock(item)}
                        className="bg-amber-600 text-white px-3 py-1 rounded text-sm hover:bg-amber-700 transition-colors"
                      >
                        Reduce
                      </button>
                      <button 
                        onClick={() => onViewHistory(item)}
                        className="bg-teal-700 text-white px-3 py-1 rounded text-sm hover:bg-teal-800 transition-colors flex items-center gap-1"
                      >
                        <History className="h-3 w-3" />
                        History
                      </button>
                    </div>
                  </td>
                </tr>
              ))
            ) : (
              // History view
              (itemsArray as HistoryEntry[]).map(entry => (
                <tr key={entry.id} className="border-b border-gray-200 hover:bg-gray-50">
                  <td className="p-3">{safeFormatDate(entry.date)}</td>
                  <td className="p-3">{entry.name}</td>
                  <td className="p-3">{getCategoryLabel(entry.mainCategory, entry.subcategory)}</td>
                  <td className="p-3">
                    {entry.quantity > 0 ? (
                      <span className="text-green-600 font-medium">+{entry.quantity} {entry.unit}</span>
                    ) : (
                      <span className="text-red-600 font-medium">{entry.quantity} {entry.unit}</span>
                    )}
                  </td>
                  <td className="p-3">{safeFormatDate(entry.harvestDate)}</td>
                  <td className="p-3">{entry.notes || "-"}</td>
                </tr>
              ))
            )
          )}
        </tbody>
      </table>
    </div>
  );
};

export default InventoryTable;