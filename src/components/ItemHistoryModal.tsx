import React from 'react';
import { X } from 'lucide-react';
import { ConsolidatedItem, HistoryEntry, Category } from '../types';
import { formatDate } from '../utils/inventoryUtils';

interface ItemHistoryModalProps {
  item: ConsolidatedItem;
  historyEntries: HistoryEntry[];
  categories: Category;
  onClose: () => void;
}

const ItemHistoryModal: React.FC<ItemHistoryModalProps> = ({ 
  item, 
  historyEntries, 
  categories, 
  onClose 
}) => {
  // Get category label
  const getCategoryLabel = (mainCategory: string, subcategory: string): string => {
    const mainCategoryLabel = categories[mainCategory]?.label || mainCategory;
    const subcategoryLabel = categories[mainCategory]?.subcategories[subcategory]?.label || subcategory;
    return `${mainCategoryLabel} / ${subcategoryLabel}`;
  };

  // Sort history entries by date (newest first)
  const sortedEntries = [...historyEntries].sort(
  (a, b) => new Date(b.date ?? '').getTime() - new Date(a.date ?? '').getTime()
);
  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-3xl w-full max-h-[90vh] overflow-y-auto p-6 relative">
        <button 
          onClick={onClose}
          className="absolute top-4 right-4 text-gray-500 hover:text-gray-700"
        >
          <X className="h-6 w-6" />
        </button>
        
        <h2 className="text-xl font-semibold mb-6 pr-8">Item History</h2>
        
        <div className="mb-6">
          <p className="font-medium text-lg">{item.name}</p>
          <p className="text-gray-600">{getCategoryLabel(item.mainCategory, item.subcategory)}</p>
          <p className="text-gray-600">Current Stock: {item.quantity} {item.unit}</p>
        </div>
        
        <div className="overflow-x-auto">
          <table className="w-full border-collapse">
            <thead>
              <tr className="bg-green-700 text-white">
                <th className="p-3 text-left">Date</th>
                <th className="p-3 text-left">Quantity Change</th>
                <th className="p-3 text-left">Harvest/Produced Date</th>
                <th className="p-3 text-left">Notes</th>
              </tr>
            </thead>
            <tbody>
  {sortedEntries.length === 0 ? (
    <tr>
      <td colSpan={4} className="p-4 text-center text-gray-500 border border-gray-200">
        No history available
      </td>
    </tr>
  ) : (
    sortedEntries.map((entry, index) => (
  <tr 
    key={`history-${entry.id}-${entry.date}-${index}`} 
    className="border-b border-gray-200 hover:bg-gray-50"
  >
    <td className="p-3">{formatDate(entry.date ?? null)}</td>
    <td className="p-3">
      {entry.quantity > 0 ? (
        <span className="text-green-600 font-medium">
          +{entry.quantity} {entry.unit}
        </span>
      ) : (
        <span className="text-red-600 font-medium">
          {entry.quantity} {entry.unit}
        </span>
      )}
    </td>
    <td className="p-3">{formatDate(entry.harvestDate ?? null)}</td>
    <td className="p-3">{entry.notes || "-"}</td>
  </tr>
))
  )}
</tbody>
          </table>
        </div>
        
        <div className="mt-6">
          <button
            type="button"
            onClick={onClose}
            className="w-full bg-gray-200 hover:bg-gray-300 text-gray-800 py-2 px-4 rounded-lg transition-colors"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
};

export default ItemHistoryModal;